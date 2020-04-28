const express = require('express');
const multer = require('multer');
const multerConfig = require('./config/multer');

const DeckSubjectController = require('./app/controllers/DeckSubjectController');
const DeckController = require('./app/controllers/DeckController');
const CardFaceContentController = require('./app/controllers/CardFaceContentController');
const CardFaceController = require('./app/controllers/CardFaceController');
const CardController = require('./app/controllers/CardController');
const SessionController = require('./app/controllers/SessionController');
const UserController = require('./app/controllers/UserController');
const FileController = require('./app/controllers/FileController');

const authMiddleware = require('./app/middlewares/auth');
const upload = multer(multerConfig);

const routes = express.Router();

routes.post('/users', UserController.store);
routes.post('/sessions', SessionController.store);

routes.use(authMiddleware)

routes.put('/users', UserController.update);

routes.post('/files', upload.single('file'), FileController.store);

module.exports = routes;
