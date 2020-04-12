const DeckSubject = require('../models/DeckSubject');

const store = async (req,res) => {
  const {subject} = req.body;
  
  const deckSubject = await DeckSubject.create({ subject });

  return res.json(deckSubject);
}

const index = async (req,res) => {
  const deckSubjects = await DeckSubject.findAll();

  return res.json(deckSubjects);
}

module.exports = {
  store,
  index
}