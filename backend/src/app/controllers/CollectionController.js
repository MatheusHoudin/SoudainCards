const Yup = require('yup');
const sequelize = require('sequelize')
const CollectionDecks = require('../models/CollectionDecks');
const File = require('../models/File');
const UserCollectionDeck = require('../models/UserCollectionDeck');
class CollectionController {
  async index(req, res) {
    const user = req.userId;

    try {
      const userCollections = await CollectionDecks.findAndCountAll({
        where: {
          creator: user
        },
        include: [
          {
            model: File,
            as: 'file',
            attributes: ['url', 'path']
          },
        ],
        attributes: {
          include: [
            [
              sequelize.literal(`(
                select count(*) from user_collection_decks as u
                where u.user=${user} and u.collection="CollectionDecks".id group by u.collection
              )`),
              'decksCount'
            ],
          ]
        }
      })

      return res.status(200).json({
        code: 200,
        data: userCollections,
        message: 'The collections were retrieved successfully'
      })
    } catch (err) {
      console.log(err)
      return res.status(500).json({
        code: 500,
        err: err,
        message: 'A server error has ocurred'
      })
    }
  }
}

module.exports = new CollectionController();