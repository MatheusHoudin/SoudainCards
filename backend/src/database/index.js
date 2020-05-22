const Sequelize = require('sequelize');
const dbConfig = require('../config/database');

const Subject = require('../app/models/Subject');
const Deck = require('../app/models/Deck');
const UserCollectionDeck = require('../app/models/UserCollectionDeck');
const CardFace = require('../app/models/CardFace');
const DeckCard = require('../app/models/DeckCard');
const CardFaceContents = require('../app/models/CardFaceContents');
const Card = require('../app/models/Card');
const Tag = require('../app/models/Tag');
const User = require('../app/models/User');
const File = require('../app/models/File');
const PasswordReset = require('../app/models/PasswordReset');
const CollectionDecks = require('../app/models/CollectionDecks');

const models = [
  File,
  PasswordReset,
  User,
  Subject,
  Deck,
  CardFaceContents,
  CardFace,
  Card,
  CollectionDecks,
  UserCollectionDeck,
  Tag,
  DeckCard,
];

class Database {
  constructor() {
    this.init();
  }

  init() {
    this.connection = new Sequelize(dbConfig);

    models.map((model) => model.init(this.connection));
    models.map(
      (model) => model.associate && model.associate(this.connection.models)
    );
  }
}

module.exports = new Database();
