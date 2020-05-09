const File = require('../models/File');
const Yup = require('yup');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class CardMediaController {
  async store(req, res) {
    const schema = Yup.object().shape({
      files: Yup.array()
        .of(Yup.object())
        .min(1, 'The card media list must have at least one media')
        .required('The card medias list is required'),
    });

    schema
      .validate(req, { abortEarly: false })
      .then(async (_) => {
        try {

          const cardMedias = req.files.map(
            function ({ originalname: name, filename: path, mimetype: type }) {
              return {
                name, path, type
              }
            }
          );

          const result = await File.bulkCreate(cardMedias);

          return res.status(201).json({
            code: 201,
            data: result,
            message: 'The card medias were created',
          });
        } catch (err) {
          return res.status(500).json({
            code: 500,
            error: err,
            message: 'A server failure has ocurred',
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

module.exports = new CardMediaController();
