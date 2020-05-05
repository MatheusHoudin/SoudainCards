const Yup = require('yup');
const Deck = require('../models/Deck');
const Subject = require('../models/Subject');
const User = require('../models/User');
const File = require('../models/File');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class DeckController {
  async store(req, res, next) {
    const schema = Yup.object().shape({
      subject: Yup.number('Subject must be a number').required(
        'Subject is a required field'
      ),
      image_id: Yup.number('Image id must be a number'),
      name: Yup.string('Name must be a string').required(
        'Name is a required field'
      ),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (_) => {
        try {
          const subject = await Subject.findByPk(req.body.subject);
          if (!subject) {
            return res.status(404).json({
              code: 404,
              error: {
                field: 'subject',
                message: 'The subject you provided does not exist',
              },
            });
          }
          if (req.body.image_id) {
            const image = await File.findByPk(req.body.image_id);

            if (!image) {
              return res.status(404).json({
                code: 404,
                error: {
                  field: 'image_id',
                  message: 'The image you provided does not exist',
                },
              });
            }
          }

          const deckWithNameAlreadyExists = await Deck.findOne({
            where: {
              creator: req.userId,
              name: req.body.name,
            },
          });

          if (deckWithNameAlreadyExists) {
            return res.status(400).json({
              code: 400,
              data: deckWithNameAlreadyExists,
              message: `A deck called ${req.body.name} already exists`,
            });
          }

          const deck = await Deck.create({
            subject: req.body.subject,
            name: req.body.name,
            image_id: req.body.image_id ? req.body.image_id : null,
            creator: req.userId,
          });

          req.body = {
            deck: deck.id,
            user: req.userId,
            collection: req.body.collection,
          };

          return next();
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
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new DeckController();
