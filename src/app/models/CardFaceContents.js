const { Model, DataTypes } = require('sequelize');

class CardFaceContents extends Model {
  static init(connection) {
    super.init({
      content_path: DataTypes.STRING,
      content_type: DataTypes.STRING,
    }, {
      sequelize: connection
    });
  }

  static associate(models) {
    this.belongsTo(models.CardFace, { foreignKey: 'card_face', as: 'card_face_content'});
  }

}

module.exports = CardFaceContents;