const { Model } = require('sequelize');

class DeckCard extends Model {
  static init(connection) {
    super.init(
      {},
      {
        sequelize: connection,
      }
    );
  }

  static associate(models) {
    this.belongsTo(models.User, { foreignKey: 'creator' });
    this.belongsTo(models.Deck, { foreignKey: 'deck' });
    this.belongsTo(models.Card, { foreignKey: 'card' });
  }
}

module.exports = DeckCard;
