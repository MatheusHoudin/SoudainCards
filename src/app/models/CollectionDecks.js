const { Model, DataTypes } = require('sequelize');

class CollectionDecks extends Model {
  static init(connection) {
    super.init({
      title: DataTypes.STRING,
      description: DataTypes.STRING,
      shared: {
        type: DataTypes.STRING,
        defaultValue: false
      },
    }, {
      sequelize: connection
    });
  }

  static associate(models) {
    this.belongsTo(models.Subject, { foreignKey: 'subject', as: 'collection_subject'});
    this.belongsTo(models.User, { foreignKey: 'creator'});
    this.belongsTo(models.File, { foreignKey: 'collection_image', as: 'file'});

  }

}

module.exports = CollectionDecks;