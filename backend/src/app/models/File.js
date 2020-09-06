const { Sequelize, Model } = require('sequelize');

class File extends Model {
  static init(sequelize) {
    super.init(
      {
        name: Sequelize.STRING,
        path: Sequelize.STRING,
        type: Sequelize.STRING,
        url: {
          type: Sequelize.VIRTUAL,
          get() {
            return `http://192.168.0.120:3001/files/get/${this.path}`;
          },
        },
      },
      {
        sequelize,
      }
    );
  }
}
//1497687107070288
module.exports = File;
