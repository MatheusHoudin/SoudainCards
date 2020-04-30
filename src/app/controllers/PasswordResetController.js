const Mail = require('../../lib/Mail');
const Yup = require('yup');
const User = require('../models/User');
const PasswordReset = require('../models/PasswordReset');
const crypto = require('crypto');
const ResponseHandlers = require('../../utils/ResponseHandlers');

class PasswordResetController {
  async store(req, res) {
    const schema = Yup.object().shape({
      email: Yup.string()
        .email('The provided email is not valid')
        .required('The email field is required'),
    });

    schema
      .validate(req.body, { abortEarly: false })
      .then(async (value) => {
        const { email } = req.body;

        const user = await User.findOne({
          where: { email },
        });

        if (!user) {
          return res.status(404).json({
            code: 404,
            error: {
              field: 'email',
              message:
                'The email you provided is not associated to a Soudain user',
            },
            message:
              'The email you provided is not associated to a Soudain user',
          });
        }
        const generatedCode = crypto.randomBytes(16);
        const confirmationHash = generatedCode.toString('hex');

        PasswordReset.create({
          confirmation_hash: confirmationHash,
          user_id: user.id,
        })
          .then(async (passwordReset) => {
            console.log(passwordReset);
            const expireDate = new Date(passwordReset.createdAt);
            expireDate.setDate(expireDate.getDate() + 4);

            await Mail.sendMail({
              to: `User name <user email>`,
              subject: 'Email title',
              template: 'password_recovery',
              context: {
                username: user.name,
                url: `http://localhost:3001/passwordreset/${confirmationHash}`,
                expireMessage: `at ${expireDate.getFullYear()}/${expireDate.getMonth()}/${expireDate.getDate()}, exactly at ${expireDate.getHours()}:${expireDate.getMinutes()}`,
              },
            });

            return res.status(201).json({
              code: 201,
              data: {
                code: confirmationHash,
                expireDate,
              },
              message:
                'An email was sent to you, there you will find a link to change your password',
            });
          })
          .catch((err) => {
            console.log(err);
            return res.status(500).json({
              code: 500,
              error: {
                field: 'none',
                message: 'Error while requiring a password reset',
              },
              message:
                'An error ocurred when trying to generate a new password reset',
            });
          });
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
}

module.exports = new PasswordResetController();
