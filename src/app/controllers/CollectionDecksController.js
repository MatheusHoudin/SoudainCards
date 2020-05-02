const Yup = require('yup');
const CollectionDecks = require('../models/CollectionDecks');
const File = require('../models/File');
const Subject = require('../models/Subject');
const ResponseHandlers = require('../../utils/ResponseHandlers');
class CollectionDecksController {
  async store(req, res, next) {
    const schema = Yup.object().shape({
      title: Yup.string().required('The collection title is required'),
      description: Yup.string().required(
        'The collection description is required'
      ),
      collection_image: Yup.number('The collection image must be a number'),
      subject: Yup.number('The collection subject must be a number').required('The collection subject is required'),
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
  
          const collectionDecks = await CollectionDecks.create({
            title: req.body.title,
            description: req.body.description,
            collection_image: req.body.collection_image
              ? req.body.collection_image
              : null,
            subject: req.body.subject,
            creator: req.userId,
          });
          
          req.body = {
            user: req.userId,
            collection: collectionDecks.id
          }

          next();
        } catch (err){
          return res.status(500).json({
            code: 500,
            error: err.name,
            message: 'A server error has ocurred'
          })
        }
      })
      .catch((err) => {
        console.log(err)
        return res.status(400).json({
          code: 400,
          errors: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new CollectionDecksController();
