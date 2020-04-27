const { Model, DataTypes } = require('sequelize');

class DeckSubject extends Model {
  static init(connection) {
    super.init({
      subject: DataTypes.STRING
    }, {
      sequelize: connection
    });
  }
}

module.exports = DeckSubject;