const User = require('../models/User');

const store = (req,res) => {
  const {file}= req;
  const {name, email, password} = req.body;

  console.log('UserController:store');
  console.log(file);

}

module.exports = {
  store
}