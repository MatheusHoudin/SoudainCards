const jwt = require('jsonwebtoken');
const Op = require('sequelize').Op;
const Yup = require('yup');
const User = require('../models/User');
const authConfig = require('../../config/auth');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class SessionController {
  async store(req, res) {
    const schema = Yup.object().shape({
      email: Yup.string().email().required(),
      password: Yup.string().required(),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        try {
          const { email, password } = req.body;

          const user = await User.findOne({
            where: {
              email,
              facebook_id: {
                [Op.is]: null
              },
              google_id: {
                [Op.is]: null
              },
            }
          });

          if (!user) {
            return res.status(401).json({
              code: 401,
              data: { email },
              message: 'User is not registered',
            });
          }

          if (!(await user.checkPassword(password))) {
            return res.status(401).json({
              code: 401,
              data: { password },
              message: 'The provided password does not match',
            });
          }

          const { id, name } = user;

          return res.status(201).json({
            code: 201,
            data: {
              user: {
                id,
                name,
                email,
              },
              token: jwt.sign({ id }, authConfig.secret, {
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
        return res.status(401).json({
          code: 401,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new SessionController();
