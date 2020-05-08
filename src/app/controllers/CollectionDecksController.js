const Yup = require('yup');
const CollectionDecks = require('../models/CollectionDecks');
const Deck = require('../models/Deck');
const User = require('../models/User');
const UserCollectionDeck = require('../models/UserCollectionDeck');
const UserCollections = require('../models/UserCollections');
const File = require('../models/File');
const Subject = require('../models/Subject');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class CollectionDecksController {
  async index(req, res) {
    const schema = Yup.object().shape({
      collection: Yup.string().required(
        'Collection is a required field'
      ),
    });

    schema
      .validate(req.params, { abortEarly: false })
      .then(async (_) => {
        const collectionValue = req.params.collection == 'default' ? null : req.params.collection;
        console.log(collectionValue)
        if(collectionValue) {
          const userHasCollection = await UserCollections.findOne({
            where: {
              user: req.userId,
              collection: collectionValue,
            }
          })
  
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

        const userCollectionDecks = await UserCollectionDeck.findAll({
          attributes: [],
          where: {
            user: req.userId,
            collection: collectionValue,
          },
          include: [
            {
              model: Deck,
              attributes: ['id', 'name'],
              as: 'collection_deck',
              include: [
                {
                  model: File,
                  attributes: ['id', 'path', 'url'],
                  as: 'file'
                },
                {
                  model: Subject,
                  attributes: ['id', 'subject'],
                  as: 'deck_subject'
                }
              ]
            },
          ]
        });

        return res.status(200).json({
          code: 200,
          data: userCollectionDecks,
          message: 'Retrieved decks'
        });
      })
      .catch((err) => {
        console.log(err)
        return res.status(400).json({
          code: 400,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
  async store(req, res, next) {
    const schema = Yup.object().shape({
      title: Yup.string().required('The collection title is required'),
      description: Yup.string().required(
        'The collection description is required'
      ),
      collection_image: Yup.number('The collection image must be a number'),
      subject: Yup.number('The collection subject must be a number').required(
        'The collection subject is required'
      ),
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

          if (req.body.subject) {
            const subject = await Subject.findOne({
              where: {
                id: req.body.subject,
              },
            });

            if (!subject) {
              return res.status(404).json({
                code: 404,
                errors: {
                  field: 'subject',
                  message: 'The subject you provided does not exist',
                },
                message: 'The subject you provided does not exist',
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
            return res.status(400).json({
              code: 400,
              data: collectionWithNameAlreadyExists,
              message: `A collection with the name ${req.body.title} already exists`,
            });
          }

          const collectionDecks = await CollectionDecks.create({
            title: req.body.title,
            description: req.body.description,
            collection_image: req.body.collection_image
              ? req.body.collection_image
              : null,
            subject: req.body.subject,
            creator: req.userId
          });

          req.body = {
            user: req.userId,
            collection: collectionDecks.id,
          };

          next();
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
