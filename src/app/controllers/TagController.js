const Yup = require('yup');
const Tag = require('../models/Tag');
const DeckCard = require('../models/DeckCard');
const UserCollectionDeck = require('../models/UserCollectionDeck');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class TagController {
  async store(req, res) {
    const schema = Yup.object().shape({
      tag: Yup.string('The tag field must be a string')
        .required('The tag field is required')
        .min(3, 'The tag size must be at least 3 characters long'),
      card: Yup.number('The card field must be a number').required(
        'The card field is required'
      ),
      deck: Yup.number('The deck field must be a number').required(
        'The deck field is required'
      ),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (_) => {
        try {
          const { deck, card, tag } = req.body;

          const userHasCard = await UserCollectionDeck.findOne({
            where: {
              user: req.userId,
              deck: deck,
            },
            include: [
              {
                model: DeckCard,
                where: {
                  deck,
                  card
                }
              }
            ]
          });

          if (!userHasCard) {
            return res.status(401).json({
              code: 401,
              error: {
                field: 'card/deck',
                message:
                  'The provided card/deck does not belong do the specified user',
              },
            });
          }

          const tagData = await Tag.create(tag);

          const deckTag = await tagData.addCard(card);

          return res.status(201).json({
            code: 201,
            data: deckTag,
            message: 'The tag was added successfuly'
          })
        } catch (err) {
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
