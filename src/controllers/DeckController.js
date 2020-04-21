const Deck = require('../models/Deck');
const DeckSubject = require('../models/DeckSubject');
const User = require('../models/User');
const store = async (req,res) => {
  
  const {subject} = req.params;

  const {image_path,creator} = req.body;

  const subjectValue = await DeckSubject.findByPk(subject);
  
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

const addCard = async (req,res) => {
  const deck = req.params;
  const {user,card} = req.body;

  // Verify if the user has the deck
  // 1: User is the creator
  // OR
  // 2: User has imported the deck
}

module.exports = {
  store,
}