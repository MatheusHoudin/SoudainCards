const Sequelize = require('sequelize');
const dbConfig = require('../config/database');

const DeckSubject = require('../models/DeckSubject');
const Deck = require('../models/Deck');
const CardFace = require('../models/CardFace');
const CardFaceContents = require('../models/CardFaceContents');
const Card = require('../models/Card');

const connection = new Sequelize(dbConfig);

DeckSubject.init(connection);
Deck.init(connection);
CardFace.init(connection);
CardFaceContents.init(connection);
Card.init(connection);

Deck.associate(connection.models);
CardFaceContents.associate(connection.models);
CardFace.associate(connection.models);
Card.associate(connection.models);

module.exports = connection;

