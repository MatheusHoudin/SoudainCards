const { Model, DataTypes } = require('sequelize');

class Subject extends Model {
  static init(connection) {
    super.init({
      subject: DataTypes.STRING
    }, {
      sequelize: connection
    });
  }
}

module.exports = Subject;