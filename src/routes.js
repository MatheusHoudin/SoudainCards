const express = require('express');
const DeckSubjectController = require('./controllers/DeckSubjectController');
const DeckController = require('./controllers/DeckController');
const CardFaceContentController = require('./controllers/CardFaceContentController');
const CardFaceController = require('./controllers/CardFaceController');
const CardController = require('./controllers/CardController');

const routes = express.Router();

routes.post('/deck/subject/:subject', DeckController.store);

routes.get('/decksubject', DeckSubjectController.index);
routes.post('/decksubject', DeckSubjectController.store);

routes.post('/cardfacecontent', CardFaceContentController.store);

routes.post('/cardface', CardFaceController.store);
routes.get('/cardface/:card_face', CardFaceController.index);

routes.post('/card',CardController.store);
routes.get('/card/:card',CardController.index);

module.exports = routes;