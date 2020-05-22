const { Model, DataTypes } = require('sequelize');

class Tag extends Model {
  static init(connection) {
    super.init(
      {
        tag: DataTypes.STRING,
      },
      {
        sequelize: connection,
      }
    );
  }

  static associate(models) {
    this.belongsToMany(models.Card, {
      foreignKey: 'tag',
      through: 'card_tags',
    });
  }
}

module.exports = Tag;
