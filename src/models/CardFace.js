const { Model, DataTypes } = require('sequelize');

class CardFace extends Model {
  static init(connection) {
    super.init({
      text_content: DataTypes.STRING
    }, {
      sequelize: connection
    });
  }

  static associate(models) {
    this.hasMany(models.CardFaceContents, { foreignKey: 'card_face', as: 'card_face_contents'});
  }

}

module.exports = CardFace;