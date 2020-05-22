const bcrypt = require('bcrypt');
const { Model, DataTypes } = require('sequelize');

class User extends Model {
  static init(connection) {
    super.init(
      {
        name: DataTypes.STRING,
        email: DataTypes.STRING,
        password: DataTypes.VIRTUAL,
        password_hash: DataTypes.STRING,
      },
      {
        sequelize: connection,
      }
    );

    this.addHook('beforeSave', async (user) => {
      console.log('before save');
      if (user.password) {
        user.password_hash = await bcrypt.hash(user.password, 8);
      }
    });

    this.addHook('beforeBulkUpdate', async (user) => {
      if (user.attributes.password) {
        console.log('BEFORE BULK UPDATE');
        user.password_hash = await bcrypt.hash(user.attributes.password, 8);
        console.log(user.password_hash);
      }
    });

    return this;
  }

  static associate(models) {
    this.belongsTo(models.File, { foreignKey: 'avatar_id', as: 'avatar' });
  }

  checkPassword(password) {
    return bcrypt.compare(password, this.password_hash);
  }
}

module.exports = User;
