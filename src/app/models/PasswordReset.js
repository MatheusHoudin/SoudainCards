const { Model, DataTypes } = require('sequelize');

class PasswordReset extends Model {
  static init(connection) {
    super.init(
      {
        confirmation_hash: DataTypes.STRING,
      },
      {
        sequelize: connection,
      }
    );

    return this;
  }

  static associate(models) {
    this.belongsTo(models.User, { foreignKey: 'user_id', as: 'user' });
  }
}

module.exports = PasswordReset;
