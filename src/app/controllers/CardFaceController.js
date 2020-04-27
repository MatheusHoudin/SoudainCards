const CardFace = require('../models/CardFace');

class CardFaceController {
  async store(req,res) {
  
    const {text_content} = req.body;
  
    const cardFace = await CardFace.create({
      text_content
    });
  
    return res.json(cardFace);
  }
  
  async index(req,res) {
    const {card_face} = req.params;
  
    const cardFace = await CardFace.findByPk(card_face, {
      include: { association: 'card_face_contents' }
    });
  
    res.json(cardFace);
  }
}

module.exports = new CardFaceController();