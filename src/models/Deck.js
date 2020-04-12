const { Model, DataTypes } = require('sequelize');

class Deck extends Model {
  static init(connection) {
    super.init({
      image_path: DataTypes.STRING
    }, {
      sequelize: connection
    });
  }

  static associate(models) {
    this.belongsTo(models.DeckSubject, { foreignKey: 'subject', as: 'deck_subject'});
  }

}

module.exports = Deck;