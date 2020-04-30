const jwt = require('jsonwebtoken');
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
        const { email, password } = req.body;

        const user = await User.findOne({ where: { email } });

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
      })
      .catch((err) => {
        return res.status(401).json({
          code: 401,
          error: ResponseHandlers.convertYupValidationErrors(err),
          message: 'The fields you provided are not valid',
        });
      });
  }
}

module.exports = new SessionController();
