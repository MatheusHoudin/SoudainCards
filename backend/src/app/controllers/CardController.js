const Card = require('../models/Card');
const UserCollectionDeck = require('../models/UserCollectionDeck');
const CardFace = require('../models/CardFace');
const DeckCard = require('../models/DeckCard');
const CardFaceContents = require('../models/CardFaceContents');
const Yup = require('yup');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class CardController {
  async store(req, res) {
    const schema = Yup.object().shape({
      cards: Yup.array()
        .min(1, 'You must save at least one card')
        .of(
          Yup.object({
            deck: Yup.number('The deck must be a number').required(
              'The deck field is required'
            ),
            collection: Yup.number('The collection must be a number').required(
              'The collection field is required'
            ),
            starred: Yup.boolean('The starred must be a boolean'),
            front: Yup.object({
              text_content: Yup.string(
                'The text content must be a string'
              ).required('The text content is required'),
              medias: Yup.array().of(Yup.number('Medias must be a number')),
            }),
            back: Yup.object({
              text_content: Yup.string(
                'The text content must be a string'
              ).required('The text content is required'),
              medias: Yup.array().of(Yup.number('Medias must be a number')),
            }),
          })
        ),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (_) => {
        try {
          const { cards } = req.body;

          const saveCardsPromises = cards.map(async (cardData) => {
            const { deck, collection, starred, front, back } = cardData;

            const userHasDeckAndCollection = await UserCollectionDeck.findOne({
              where: {
                user: req.userId,
                deck: deck,
                collection: collection,
              },
            });

            if (!userHasDeckAndCollection) {
              return res.status(401).json({
                code: 401,
                error: {
                  field: 'collection/deck',
                  message:
                    'The provided collection/deck does not belong to the user',
                },
                message:
                  'You are not allowed to insert cards on the provided collection and deck',
              });
            }
            
            const frontContentAlreadyExists = await DeckCard.findOne({
              where: {
                deck: deck,
                creator: req.userId,
              },
              attributes: ['id', 'creator', 'deck', 'card'],
              include: [
                {
                  required: true,
                  model: Card,
                  attributes: ['id'],
                  include: [
                    {
                      model: CardFace,
                      as: 'front_face',
                      attributes: ['id', 'text_content'],
                      where: {
                        text_content: front.text_content,
                      },
                    },
                  ],
                },
              ],
            });

            if (frontContentAlreadyExists) {
              return {
                error: 'Front card duplicate found',
                duplicateFront: frontContentAlreadyExists
              }
            }

            const [frontData, backData] = await Promise.all([
              CardFace.create({ text_content: front.text_content }),
              CardFace.create({ text_content: back.text_content }),
            ]);

            var frontMedias = null;
            var backMedias = null;
            var mediaError = null;
            if (typeof front.medias !== 'undefined') {
              frontMedias = front.medias.map(function (mId) {
                return {
                  card_face: frontData.id,
                  file: mId,
                };
              });
            }

            if (typeof back.medias !== 'undefined') {
              backMedias = back.medias.map(function (mId) {
                return {
                  card_face: backData.id,
                  file: mId,
                };
              });
            }

            if (frontMedias || backMedias) {
              var medias = [];
              if (frontMedias) medias = medias.concat(frontMedias);
              if (backMedias) medias = medias.concat(backMedias);

              if (medias.length >= 0) {
                try {
                  await CardFaceContents.bulkCreate(
                    medias
                  );
                } catch (err) {

                  await CardFace.destroy({
                    where: {
                      id: [frontData.id, backData.id],
                    },
                  });
                  mediaError = {
                    error: 'The provided medias are not saved on our database',
                    card: cardData,
                  };
                }

              }
            }

            if(mediaError) return mediaError;

            const card = await Card.create({
              starred,
              front: frontData.id,
              back: backData.id,
            });

            await DeckCard.create({
              creator: req.userId,
              deck,
              card: card.id,
            });

            return {
              card,
              collection,
              deck,
            };
          });

          Promise.all(saveCardsPromises)
            .then((result) => {
              return res.status(201).json({
                code: 201,
                data: result,
                message: 'All of the cards were saved successfuly',
              });
            })
            .catch((err) => {
              return res.status(500).json({
                code: 500,
                error: err.name,
                message: 'An error ocurred while saving the cards',
              });
            });
        } catch (err) {
          console.log(err);
          return res.status(500).json({
            code: 500,
            error: err,
            message: 'A server error has ocurred',
          });
        }
      })
      .catch((err) => {
        return res.status(500).json({
          code: 500,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }

  async userHasCollectionAndDeck(req, res, deck, collection) {}

  async frontContentAlreadyExistsFunction(req, res, deck, front) {}

  async saveCardMedias(front, back) {
    return {
      frontData,
      backData,
    };
  }
}

module.exports = new CardController();
