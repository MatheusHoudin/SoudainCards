const express = require('express');
const multer = require('multer');
const multerConfig = require('./config/multer');

const DeckSubjectController = require('./app/controllers/DeckSubjectController');
const DeckController = require('./app/controllers/DeckController');
const CardFaceContentController = require('./app/controllers/CardFaceContentController');
const CardFaceController = require('./app/controllers/CardFaceController');
const CardController = require('./app/controllers/CardController');
const UserController = require('./app/controllers/UserController');

//const authMiddleware = require('./app/middlewares/auth');
const upload = multer(multerConfig);

const routes = express.Router();

//routes.use(authMiddleware)

routes.post('/signup', upload.single('file'), UserController.store);

routes.post('/deck/subject/:subject', DeckController.store);

routes.get('/decksubject', DeckSubjectController.index);
routes.post('/decksubject', DeckSubjectController.store);

routes.post('/cardfacecontent', CardFaceContentController.store);

routes.post('/cardface', CardFaceController.store);
routes.get('/cardface/:card_face', CardFaceController.index);

routes.post('/card',CardController.store);
routes.get('/card/:card',CardController.index);

module.exports = routes;