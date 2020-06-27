const Yup = require('yup');
const CollectionDecks = require('../models/CollectionDecks');
const User = require('../models/User');
const File = require('../models/File');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class UserController {
  async index(req, res) {
    const schema = Yup.object().shape({
      id: Yup.number('The id field must be a number').required(
        'The id field is required'
      ),
    });

    schema
      .validate(req.params, { abortEarly: false })
      .then(async (values) => {
        try {
          const user = await User.findByPk(values.id, {
            include: [
              {
                model: File,
                as: 'avatar',
                attributes: ['url','path']
              }
            ],
            attributes: ['id','name','email','avatar_id']
          });

          if (user) {
            return res.status(200).json({
              code: 200,
              data: user,
              message: 'The user was retrieved successfully',
            });
          } else {
            return res.status(404).json({
              code: 404,
              data: null,
              message: 'The user was retrieved successfully',
            });
          }
        } catch (e) {
          console.log(e)
          return res.status(500).json({
            code: 500,
            error: e.name,
            message: 'A server error has ocurred',
          });
        }
      })
      .catch((err) => {
        return res.status(400).json({
          code: 400,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }

  async store(req, res) {
    const schema = Yup.object().shape({
      name: Yup.string().required('Name must be provided'),
      email: Yup.string()
        .email('Invalid email')
        .required('Email must be provided'),
      password: Yup.string().min(6).required('Password must be provided'),
      passwordConfirmation: Yup.string()
        .required()
        .oneOf([Yup.ref('password'), null], 'Passwords must match'),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        try {
          const userAlreadyExists = await User.findOne({
            where: { email: value.email },
          });

          if (userAlreadyExists) {
            return res.status(401).json({
              code: 400,
              error: {
                field: 'email',
                message: 'Email already exists',
              },
              message: 'Unfortunately there is an user with this email',
            });
          }

          const { id, name, email } = await User.create({
            name: value.name,
            email: value.email,
            password: value.password,
          });

          return res.status(201).json({
            code: 201,
            data: {
              id,
              name,
              email,
            },
            message: 'User created successfully',
          });
        } catch (err) {
          console.log(err);
          return res.status(500).json({
            code: 500,
            error: err.name,
            message: 'A server error has ocurred',
          });
        }
      })
      .catch((err) => {
        console.log(err);
        return res.status(400).json({
          code: 400,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }

  async update(req, res) {
    const schema = Yup.object().shape({
      name: Yup.string(),
      email: Yup.string().email('Invalid email'),
      oldPasword: Yup.string().min(6),
      password: Yup.string()
        .min(6)
        .when('oldPassword', (oldPassword, field) =>
          oldPassword ? field.required() : field
        ),
      confirmPassword: Yup.string().when('password', (password, field) =>
        password
          ? field
              .required()
              .oneOf([Yup.ref('password')], 'Passwords must match')
          : field
      ),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        const { email, oldPasword } = req.body;

        const user = await User.findByPk(req.userId);

        if (email !== user.email) {
          const userExists = await User.findOne({ where: { email } });

          if (userExists) {
            return res.status(401).json({
              code: 401,
              error: {
                field: 'email',
                message: 'Email aleready exists',
              },
              message: 'Unfortunately there is an user with this email',
            });
          }
        }

        if (oldPasword && !(await user.checkPassword(oldPasword))) {
          return res.status(401).json({
            code: 401,
            error: {
              field: 'oldPassword',
              message: 'The oldPassword is wrong',
            },
            message: 'The oldPassword is wrong',
          });
        }

        const { id, avatar_id, name } = await user.update(req.body);

        return res.status(200).json({
          code: 200,
          data: {
            id,
            name,
            email,
            avatar_id,
          },
          message: 'User updated successfully',
        });
      })
      .catch((err) => {
        console.log(err);
        return res.status(401).json({
          code: 401,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new UserController();
