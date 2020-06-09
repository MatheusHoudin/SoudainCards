const express = require('express');
const multer = require('multer');
const multerConfig = require('./config/multer');

const SessionController = require('./app/controllers/SessionController');
const FacebookSessionController = require('./app/controllers/FacebookSessionController');
const UserController = require('./app/controllers/UserController');
const FileController = require('./app/controllers/FileController');
const TagController = require('./app/controllers/TagController');
const PasswordResetController = require('./app/controllers/PasswordResetController');
const SubjectController = require('./app/controllers/SubjectController');
const CardMediaController = require('./app/controllers/CardMediaController');
const CollectionDecksController = require('./app/controllers/CollectionDecksController');
const DeckController = require('./app/controllers/DeckController');
const CardController = require('./app/controllers/CardController');
const CollectionController = require('./app/controllers/CollectionController');
const UserDecksController = require('./app/controllers/UserDecksController');

const authMiddleware = require('./app/middlewares/auth');
const upload = multer(multerConfig);

const routes = express.Router();

routes.post('/users', UserController.store);

routes.post('/sessions', SessionController.store);
routes.post('/sessions/facebook', FacebookSessionController.store);

routes.post('/passwordreset', PasswordResetController.store);
routes.put('/passwordreset/:confirmationCode', PasswordResetController.update);

routes.get('/subjects', SubjectController.index);

routes.use(authMiddleware);

routes.put('/users', UserController.update);

routes.post('/files', upload.single('file'), FileController.store);

routes.post('/subject', SubjectController.store);

routes.post('/collection', CollectionDecksController.store);
routes.get('/user/collection', CollectionController.index);

routes.get('/collection/:collection/decks', CollectionDecksController.index);

routes.post('/deck', DeckController.store, UserDecksController.store);

routes.post('/card', CardController.store);
routes.post('/card/tags', TagController.store);
routes.post('/card/medias', upload.array('file', 4), CardMediaController.store);

module.exports = routes;
