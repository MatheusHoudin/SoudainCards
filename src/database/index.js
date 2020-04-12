const Sequelize = require('sequelize');
const dbConfig = require('../config/database');

const DeckSubject = require('../models/DeckSubject');
const Deck = require('../models/Deck');

const connection = new Sequelize(dbConfig);

DeckSubject.init(connection);
Deck.init(connection);

Deck.associate(connection.models);

module.exports = connection;

