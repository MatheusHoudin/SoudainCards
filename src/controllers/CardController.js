const Card = require('../models/Card');
const store = async (req,res) => {
  
  const {front,back} = req.body;

  const card = await Card.create({
    front,
    back
  });

  return res.json(card);
}

const index = async (req,res) => {
  const {card} = req.params;

  const cardObject = await Card.findByPk(card, {
    attributes: ['id'],
    include: [{ association: 'front_face' },{ association: 'back_face' }],
  });

  res.json(cardObject);
}

module.exports = {
  store,
  index
}