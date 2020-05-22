const { Model, DataTypes } = require('sequelize');

class Card extends Model {
  static init(connection) {
    super.init(
      {
        starred: {
          type: DataTypes.BOOLEAN,
          defaultValue: false,
        },
      },
      {
        sequelize: connection,
      }
    );
  }

  static associate(models) {
    this.belongsTo(models.CardFace, { foreignKey: 'front', as: 'front_face' });
    this.belongsTo(models.CardFace, { foreignKey: 'back', as: 'back_face' });
    this.belongsToMany(models.Tag, {
      foreignKey: 'card',
      through: 'card_tags',
    });
  }
}

module.exports = Card;
