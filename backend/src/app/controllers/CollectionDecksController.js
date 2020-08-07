const Yup = require('yup');
const sequelize = require('sequelize');
const CollectionDecks = require('../models/CollectionDecks');
const Deck = require('../models/Deck');
const UserCollectionDeck = require('../models/UserCollectionDeck');
const File = require('../models/File');
const Subject = require('../models/Subject');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class CollectionDecksController {
  async index(req, res) {
    const schema = Yup.object().shape({
      collection: Yup.string().required('Collection is a required field'),
    });

    schema
      .validate(req.params, { abortEarly: false })
      .then(async (_) => {
        const collectionValue =
          req.params.collection == 'default' ? null : req.params.collection;
        if (collectionValue) {
          const userHasCollection = await UserCollectionDeck.findOne({
            where: {
              user: req.userId,
              collection: collectionValue,
            },
          });

          if (!userHasCollection) {
            return res.status(401).json({
              code: 401,
              error: {
                fields: 'collection',
                message:
                  'The collection provided does not belongs to the given user',
              },
            });
          }
        }

        const collectionJoinQuery = `${collectionValue ? `ucd.collection=${collectionValue}` : "ucd.collection is null"}`;
         
        const userCollectionDecks = await UserCollectionDeck.findAndCountAll({
          attributes: {
            exclude: ['createdAt', 'updatedAt'],
            include: [
              [
                sequelize.literal(`(
                  select count(*) from deck_cards as dc 
                  join user_collection_decks as ucd on dc.deck=ucd.deck 
                  where ucd.user=${req.userId} and ${collectionJoinQuery} 
                  and ucd.deck=collection_deck.id group by ucd.deck
                )`),
                'cards_count'
              ],
            ],
          },
          where: {
            user: req.userId,
            collection: collectionValue,
          },
          include: [
            {
              model: Deck,
              attributes: ['id', 'name', 'shared'],
              as: 'collection_deck',
              include: [
                {
                  model: File,
                  attributes: ['id', 'path', 'url'],
                  as: 'file',
                },
                {
                  model: Subject,
                  attributes: ['id', 'subject'],
                  as: 'deck_subject',
                },
              ],
            }
          ],
        });

        return res.status(200).json({
          code: 200,
          data: userCollectionDecks.rows,
          message: 'Retrieved decks',
        });
      })
      .catch((err) => {
        console.log(err);
        return res.status(400).json({
          code: 400,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
  async store(req, res) {
    const schema = Yup.object().shape({
      title: Yup.string('Title must be a string').required('The collection title is required'),
      description: Yup.string('Description must be a string'),
      collection_image: Yup.number('The collection image must be a number'),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        try {
          if (req.body.collection_image) {
            const collectionImage = await File.findOne({
              where: {
                id: req.body.collection_image,
              },
            });

            if (!collectionImage) {
              return res.status(404).json({
                code: 404,
                errors: {
                  field: 'collection_image',
                  message: 'The image you provided does not exist',
                },
                message: 'The image you provided does not exist',
              });
            }
          }

          const collectionWithNameAlreadyExists = await CollectionDecks.findOne(
            {
              where: {
                creator: req.userId,
                title: req.body.title,
              },
            }
          );

          if (collectionWithNameAlreadyExists) {
            return res.status(409).json({
              code: 409,
              error: {
                field: 'name',
                message: `A collection with the name ${req.body.title} already exists`,
              },
              message: `A collection with the name ${req.body.title} already exists`,
            });
          }

          const collectionDecks = await CollectionDecks.create({
            title: req.body.title,
            description: req.body.description,
            collection_image: req.body.collection_image
              ? req.body.collection_image
              : null,
            creator: req.userId,
          });

          return res.status(201).json({
            code: 201,
            data: collectionDecks,
            message: 'The collection was created successfully',
          });
        } catch (err) {
          console.log(err);
          return res.status(500).json({
            code: 500,
            error: err.name,
            message: 'A server error has ocurred',
          });
        }
      })
      .catch((err) => {
        console.log(err);
        return res.status(400).json({
          code: 400,
          errors: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new CollectionDecksController();
