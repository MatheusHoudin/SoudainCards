const { Model, DataTypes } = require('sequelize');

class Deck extends Model {
  static init(connection) {
    super.init(
      {
        shared: {
          type: DataTypes.BOOLEAN,
          defaultValue: false,
        },
        name: DataTypes.STRING,
      },
      {
        sequelize: connection,
      }
    );
  }

  static associate(models) {
    this.belongsTo(models.Subject, {
      foreignKey: 'subject',
      as: 'deck_subject'
    });
    this.belongsTo(models.File, { foreignKey: 'image_id', as: 'file'});
    this.belongsTo(models.User, { foreignKey: 'creator', as: 'deck_creator' });
  }
}

module.exports = Deck;
