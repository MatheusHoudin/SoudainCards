const DeckSubject = require('../models/DeckSubject');

class DeckSubjectController {
  async store(req, res) {
    const { subject } = req.body;

    const deckSubjectExists = await DeckSubject.findOne({
      where: { subject: subject },
    });

    if (deckSubjectExists) {
      return res.status(400).json(`Deck subject ${subject} already exists`);
    }

    const deckSubject = await DeckSubject.create({ subject });

    return res.json(deckSubject);
  }

  async index(req, res) {
    const deckSubjects = await DeckSubject.findAll();

    return res.json(deckSubjects);
  }
}

module.exports = new DeckSubjectController();
