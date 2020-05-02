const { Model, DataTypes } = require('sequelize');

class UserCollections extends Model {
  static init(connection) {
    super.init(
      {
        imported: {
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
    this.belongsTo(models.User, { foreignKey: 'user' });
    this.belongsTo(models.CollectionDecks, {
      foreignKey: 'collection',
    });
  }
}

module.exports = UserCollections;
