const { Model, DataTypes } = require('sequelize');

class CardFaceContents extends Model {
  static init(connection) {
    super.init(
      {},
      {
        sequelize: connection,
      }
    );
  }

  static associate(models) {
    this.belongsTo(models.CardFace, {
      foreignKey: 'card_face',
    });
    this.belongsTo(models.File, {
      foreignKey: 'file',
    });
  }
}

module.exports = CardFaceContents;
