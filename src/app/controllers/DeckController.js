const Deck = require('../models/Deck');
const Subject = require('../models/Subject');
const User = require('../models/User');

class DeckController {
  async store(req,res) {
  
    const {subject} = req.params;
  
    const {image_path,creator} = req.body;
  
    const subjectValue = await Subject.findByPk(subject);
    
    if(!subjectValue) {
      return res.status(400).json({error: "Subject not found"});
    }
  
    const deck = await Deck.create({
      image_path,
      subject,
      creator
    });
  
    return res.json(deck);
  }
}

module.exports = new DeckController();