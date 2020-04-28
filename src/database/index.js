const Sequelize = require('sequelize');
const dbConfig = require('../config/database');

const DeckSubject = require('../app/models/DeckSubject');
const Deck = require('../app/models/Deck');
const CardFace = require('../app/models/CardFace');
const CardFaceContents = require('../app/models/CardFaceContents');
const Card = require('../app/models/Card');
const User = require('../app/models/User');
const File = require('../app/models/File');

const models = [File, User, DeckSubject, Deck, CardFaceContents, CardFace, Card];

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
