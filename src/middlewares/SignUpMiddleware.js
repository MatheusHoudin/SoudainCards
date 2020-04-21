const SignUpValidator = require('../utils/SignUpValidator');
const signup = (req, res, next) => {
    const validationRule = {
        "name": "required|string",
        "email": "required|email",
        "password": "required|string|min:8|confirmed",
    }
    SignUpValidator(req.body, validationRule, {}, (err, status) => {
      if (!status) {
        res.status(412)
        .send({
          success: false,
          message: 'Validation failed',
          data: err
        });
      } else {
        next();
      }
    });
}

module.exports = { 
  signup
}