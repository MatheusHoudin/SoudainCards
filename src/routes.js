const express = require('express');
const multer = require('multer');
const multerConfig = require('./config/multer');

const SessionController = require('./app/controllers/SessionController');
const UserController = require('./app/controllers/UserController');
const FileController = require('./app/controllers/FileController');
const PasswordResetController = require('./app/controllers/PasswordResetController');
const SubjectController = require('./app/controllers/SubjectController');
const CollectionDecksController = require('./app/controllers/CollectionDecksController');
const UserCollectionsController = require('./app/controllers/UserCollectionsController');
const DeckController = require('./app/controllers/DeckController');
const UserDecksController = require('./app/controllers/UserDecksController');

const authMiddleware = require('./app/middlewares/auth');
const upload = multer(multerConfig);

const routes = express.Router();

routes.post('/users', UserController.store);
routes.post('/sessions', SessionController.store);
routes.post('/passwordreset', PasswordResetController.store);
routes.put('/passwordreset/:confirmationCode', PasswordResetController.update);
routes.get('/subjects', SubjectController.index);

routes.use(authMiddleware);

routes.put('/users', UserController.update);

routes.post('/files', upload.single('file'), FileController.store);

routes.post('/subject', SubjectController.store);

routes.post(
  '/collection',
  CollectionDecksController.store,
  UserCollectionsController.store
);
routes.get('/collection', UserCollectionsController.index);
routes.get('/collection/:collection/decks', CollectionDecksController.index);

routes.post('/deck', DeckController.store, UserDecksController.store);

module.exports = routes;
