const jwt = require('jsonwebtoken');
const { promisify } = require('util');
const authConfig = require('../../config/auth');

module.exports = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({
      code: 401,
      error: {
        field: 'Authorization',
        message: 'Token was not provided'
      },
      message: 'You do not have access to this functionality'
    });
  }

  try {
    const decoded = await promisify(jwt.verify)(authHeader, authConfig.secret);
    req.userId = decoded.id;
    return next();
  } catch (err) {
    console.log(err);
    return res.status(401).json({
      code: 401,
      error: {
        field: 'Authorization',
        message: 'Token is not valid'
      },
      message: 'Your token seems to be wrong, log in to get a brand new one'
    });
  }
};
