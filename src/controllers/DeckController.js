const Deck = require('../models/Deck');
const DeckSubject = require('../models/DeckSubject');
const store = async (req,res) => {
  
  const {subject} = req.params;

  const {image_path} = req.body;

  const subjectValue = await DeckSubject.findByPk(subject);
  
  if(!subjectValue) {
    return res.status(400).json({error: "Subject not found"});
  }

  const deck = await Deck.create({
    image_path,
    subject
  });

  return res.json(deck);
}

module.exports = {
  store,
}