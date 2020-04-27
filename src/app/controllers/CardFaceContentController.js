const CardFaceContent = require('../models/CardFaceContents');

class CardFaceContentController {
  async store(req,res) {
  
    const {content_path,content_type,card_face} = req.body;
  
    const cardFaceContent = await CardFaceContent.create({
      content_path,
      content_type,
      card_face
    });
  
    return res.json(cardFaceContent);
  }
}

module.exports = new CardFaceContentController();