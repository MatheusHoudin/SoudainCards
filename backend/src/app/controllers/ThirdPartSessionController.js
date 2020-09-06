const jwt = require('jsonwebtoken');
const Yup = require('yup');
const imageDownloader = require('image-downloader')
const { extname, resolve } = require('path');
const User = require('../models/User');
const File = require('../models/File');
const authConfig = require('../../config/auth');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class ThirdPartSessionController {
  async store(req, res) {
    const schema = Yup.object().shape({
      id: Yup.number('id must be a number').required('id is a required field'),
      name: Yup.string('Name must be a string').required(
        'Name is a required field'
      ),
      email: Yup.string('Email must be a string')
        .email('Email format is not valid')
        .required('The email field is required'),
      picture: Yup.string('Picture must be a string'),
      isFacebook: Yup.boolean('isFacebook must be a boolean').required(
        'isFacebook is a required field'
      ),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        try {
          const { id, email, name, picture, isFacebook } = req.body;

          const data = isFacebook
            ? {
                name: name,
                email: email,
                facebook_id: id.toString(),
                password: jwt.sign({ id }, authConfig.secret, {
                  expiresIn: authConfig.expiresIn,
                }),
              }
            : {
                name: name,
                email: email,
                google_id: id.toString(),
                password: jwt.sign({ id }, authConfig.secret, {
                  expiresIn: authConfig.expiresIn,
                }),
              };

          var userAlreadyExists;    
          if (isFacebook) {
            userAlreadyExists = await User.findOne({
              where: {
                email,
                facebook_id: id.toString()
              },
            });
          }else{
            userAlreadyExists = await User.findOne({
              where: {
                email,
                google_id: id.toString()
              },
            });
          }

          if (userAlreadyExists) {
            if (
              !userAlreadyExists.facebook_id &&
              !userAlreadyExists.google_id
            ) {
              // On this case, there is already a non third part user registered on Soudain
              return res.status(409).json({
                code: 409,
                error: [
                  {
                    field: 'email',
                    message:
                      'The provided email was already taken by another user',
                  },
                ],
                message: 'The provided email was already taken by another user',
              });
            } else if (
              (isFacebook && userAlreadyExists.facebook_id === id.toString()) ||
              (!isFacebook && userAlreadyExists.google_id === id.toString())
            ) {
              return res.status(201).json({
                code: 201,
                data: {
                  user: {
                    id: userAlreadyExists.id,
                    name: userAlreadyExists.name,
                    email: userAlreadyExists.email,
                  },
                  token: jwt.sign(
                    { id: userAlreadyExists.id },
                    authConfig.secret,
                    {
                      expiresIn: authConfig.expiresIn,
                    }
                  ),
                },
                message: 'The user could log in successfully',
              });
            }
          } else {
 
            const user = await User.create(data);

            const options = {
              url: picture,
              dest: resolve(__dirname, '..', '..', '..', 'temp', 'uploads', `${id.toString()}.jpeg`)               // will be saved to /path/to/dest/image.jpg
            }
             
            const r = await imageDownloader.image(options);
            console.log(r);
            const file = await File.findOrCreate({
              where: {
                name: id.toString(),
                path: `${id.toString()}.jpeg`,
              },
              defaults: {
                type: 'image/jpeg',
              },
            });

            await User.update(
              { avatar_id: file[0].id },
              { where: { id: user.id } }
            );

            return res.status(201).json({
              code: 201,
              data: {
                user: {
                  id: user.id,
                  name: user.name,
                  email: user.email,
                },
                token: jwt.sign({ id: user.id }, authConfig.secret, {
                  expiresIn: authConfig.expiresIn,
                }),
              },
              message: 'The user could log in successfully',
            });
          }
        } catch (error) {
          console.log(error);
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

module.exports = new ThirdPartSessionController();
