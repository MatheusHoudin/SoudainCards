const User = require('../models/User');

class UserController {
  async store(req,res) {
    const {file}= req;
    const {name, email, password} = req.body;
  
    console.log('UserController:store');
    console.log(file);
  
    // Search if someone has already picked up the given email
  
    if(typeof file == 'undefined'){
      
      // Save the user with a default image, return the jwt token     
    }else{
      // Save the user image
      // Its possible to proceed the user signup even if the image wasnt uploaded successfuly, return the jwt
    }
  
  }
}

module.exports = new UserController();