const Yup = require('yup');
const UserCollections = require('../models/UserCollections');
const CollectionDecks = require('../models/CollectionDecks');
const Subject = require('../models/Subject');
const User = require('../models/User');
const File = require('../models/File');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class UserCollectionsController {
  async store(req, res) {
    const schema = Yup.object().shape({
      user: Yup.number('The user must be a number').required(),
      collection: Yup.number('The collection must be a number').required(),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        try {
          const user = await User.findByPk(req.body.userId);

          if (!user) {
            return res.status(404).json({
              code: 404,
              errors: {
                field: 'user',
                message: 'The user you provided does not exist',
              },
              message: 'The user you provided does not exist',
            });
          }

          const collection = await User.findByPk(req.body.collection);

          if (!collection) {
            return res.status(404).json({
              code: 404,
              errors: {
                field: 'collection',
                message: 'The collection you provided does not exist',
              },
              message: 'The collection you provided does not exist',
            });
          }

          const userCollections = await UserCollections.create(req.body);

          return res.status(201).json({
            code: 201,
            data: userCollections,
            message: 'The user collection was created successfully',
          });
        } catch (err) {
          await CollectionDecks.destroy({
            where: {
              id: req.body.collection,
            },
          });

          return res.status(500).json({
            code: 500,
            error: err.name,
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

  async index(req, res) {
    try {
      const userCollections = await UserCollections.findAll({
        where: {
          user: req.userId,
        },
        attributes: ['id','imported', 'title', 'description'],
        include: [
          {
            model: CollectionDecks,
            as: 'collection_decks',
            attributes: ['title', 'description', 'shared'],
            include: [
              {
                model: Subject,
                as: 'collection_subject',
                attributes: ['id','subject']
              },
              {
                model: File,
                as: 'file',
                attributes: ['id', 'path']
              }
            ]
          },
        ],
      });

      return res.status(200).json({
        code: 200,
        data: userCollections,
        message: 'Collections',
      });
    } catch (err) {
      console.log(err)
      return res.status(500).json({
        code: 500,
        error: err.name,
        message: 'A server error has ocurred',
      });
    }
  }
}

module.exports = new UserCollectionsController();
