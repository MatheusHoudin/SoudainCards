const Yup = require('yup');
const Deck = require('../models/Deck');
const User = require('../models/User');
const UserCollectionDeck = require('../models/UserCollectionDeck');
const CollectionDecks = require('../models/CollectionDecks');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class UserDecksController {
  async store(req, res) {
    const schema = Yup.object().shape({
      user: Yup.number('User must be a number').required(
        'User is a required field'
      ),
      deck: Yup.number('Deck must be a number').required(
        'User is a required field'
      ),
      collection: Yup.number('Collection must be a number'),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (_) => {
        try {

          const deck = await Deck.findByPk(req.body.deck);

          if (!deck) {
            return res.status(404).json({
              code: 404,
              errors: {
                field: 'deck',
                message: 'The deck you provided does not exist',
              },
              message: 'The deck you provided does not exist',
            });
          }

          if (typeof req.body.collection !== 'undefined') {
            const userHasCollection = await CollectionDecks.findOne({
              where: {
                id: req.body.collection,
                creator: req.body.user,
              },
            });

            if (!userHasCollection) {
              await Deck.destroy({
                where: {
                  id: req.body.deck,
                },
              });

              return res.status(401).json({
                code: 401,
                error: {
                  field: 'collection',
                  message: 'The provided collection does not belong to user',
                },
                message: 'Invalid collection',
              });
            }
          }
          
          const userDeck = await UserCollectionDeck.create(req.body);

          return res.status(201).json({
            code: 201,
            data: userDeck,
            message: 'The deck was created successfully',
          });
        } catch (err) {
          await Deck.destroy({
            where: {
              id: req.body.deck,
            },
          });
          console.log(err)
          return res.status(500).json({
            code: 500,
            error: err.name,
            message: 'A server error has ocurred',
          });
        }
      })
      .catch((err) => {
        console.log(err)
        return res.status(400).json({
          code: 400,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'A server error has ocurred',
        });
      });
  }
}

module.exports = new UserDecksController();
