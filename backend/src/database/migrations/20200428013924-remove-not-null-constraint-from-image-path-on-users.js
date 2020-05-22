'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.changeColumn('users', 'image_path', {
      type: Sequelize.STRING,
      allowNull: true,
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.changeColumn('users', 'image_path', {
      type: Sequelize.STRING,
      allowNull: false,
    });
  },
};
