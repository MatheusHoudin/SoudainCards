const express = require('express');
const DeckSubjectController = require('./controllers/DeckSubjectController');
const DeckController = require('./controllers/DeckController');

const routes = express.Router();

routes.post('/deck/subject/:subject', DeckController.store);

routes.get('/decksubject', DeckSubjectController.index);
routes.post('/decksubject', DeckSubjectController.store);

module.exports = routes;