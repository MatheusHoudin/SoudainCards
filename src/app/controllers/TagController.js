const Yup = require('yup');
const Tag = require('../models/Tag');
const DeckCard = require('../models/DeckCard');
const UserCollectionDeck = require('../models/UserCollectionDeck');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class TagController {
  async store(req, res) {
    const schema = Yup.object().shape({
      card: Yup.number('The card field must be a number').required(
        'The card field is required'
      ),
      deck: Yup.number('The deck field must be a number').required(
        'The deck field is required'
      ),
      tags: Yup.array()
        .min(1, 'You must save at least one tag')
        .of(
          Yup.string('The tag field must be a string')
            .required('The tag field is required')
            .min(3, 'The tag size must be at least 3 characters long')
        ),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (_) => {
        try {
          const { deck, card, tags } = req.body;
          const userHasDeck = await UserCollectionDeck.findOne({
            where: {
              user: req.userId,
              deck: deck,
            },
          });

          if (!userHasDeck) {
            return res.status(401).json({
              code: 401,
              error: {
                field: 'deck',
                message:
                  'The provided deck does not belong do the specified user',
              },
            });
          }

          const deckHasCard = await DeckCard.findOne({
            where: {
              card: card,
              deck: deck,
            },
          });

          if (!deckHasCard) {
            return res.status(401).json({
              code: 401,
              error: {
                field: 'card',
                message:
                  'The provided card does not belong do the specified deck',
              },
            });
          }

          const saveTagsPromises = tags.map(async (tag) => {
            const tagData = await Tag.findOrCreate({
              where: {
                tag: tag.toUpperCase(),
              },
            });

            const cardTag = await tagData[0].addCard(card);

            if (typeof cardTag === 'undefined') {
              return {
                error: 'The tag was already created on the specified card',
                data: {
                  deck: deck,
                  card: card,
                  tag: tag.toUpperCase(),
                },
              };
            } else {
              return {
                id: cardTag.id,
                tagId: cardTag.tag,
                tag: tag.toUpperCase(),
              };
            }
          });

          Promise.all(saveTagsPromises)
            .then((saverCardTags) => {
              return res.status(201).json({
                code: 201,
                data: {
                  card: card,
                  deck: deck,
                  tags: saverCardTags,
                },
                message: 'The tags were added successfuly',
              });
            })
            .catch((err) => {
              console.log(err);
              return res.status(500).json({
                code: 500,
                error: err,
                message: 'An error ocurred while saving the tags',
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
        return res.status(400).json({
          code: 400,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new TagController();
