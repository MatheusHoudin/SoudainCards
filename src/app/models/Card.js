const { Model, DataTypes } = require('sequelize');

class Card extends Model {
  static init(connection) {
    super.init({
    }, {
      sequelize: connection
    });
  }

  static associate(models){
    this.belongsTo(models.CardFace, {foreignKey: 'front', as: 'front_face'});
    this.belongsTo(models.CardFace, {foreignKey: 'back', as: 'back_face'});
  }
}

module.exports = Card;