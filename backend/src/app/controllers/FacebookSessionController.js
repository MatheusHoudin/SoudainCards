const jwt = require('jsonwebtoken');
const Yup = require('yup');
const User = require('../models/User');
const File = require('../models/File');
const authConfig = require('../../config/auth');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class FacebookSessionController {
  async store(req, res) {
    const schema = Yup.object().shape({
      id: Yup.number('id must be a number').required('id is a required field'),
      name: Yup.string('Name must be a string').required(
        'Name is a required field'
      ),
      email: Yup.string('Email must be a string')
        .email('Email format is not valid')
        .required('The email field is required'),
      picture: Yup.string('Picture must be a string')  
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        try {
          const { id, email, name, picture} = req.body;

          const user = await User.findOrCreate({
            where: {
              name: name,
              email: email,
              facebook_id: id.toString()
            },
            defaults: {
              password: jwt.sign({ id }, authConfig.secret, {
                expiresIn: authConfig.expiresIn,
              }),
            },
          });

          const file = await File.findOrCreate({
            where: {
              name: name,
              path: picture,
            },
            defaults: {
              type: 'image/jpeg'
            }
          });

          await user[0].update({
            avatar_id: file.id
          })

          return res.status(201).json({
            code: 201,
            data: {
              user: {
                id: user[0].id,
                name: name,
                email: email,
              },
              token: jwt.sign({id: user[0].id}, authConfig.secret, {
                expiresIn: authConfig.expiresIn,
              }),
            },
            message: 'The user could log in successfully',
          });
        } catch (error) {
          console.log(error)
          return res.status(500).json({
            code: 500,
            error: error.name,
            message: 'A server error ocurred',
          });
        }
      })
      .catch((err) => {
        console.log(err);
        return res.status(400).json({
          code: 401,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new FacebookSessionController();
