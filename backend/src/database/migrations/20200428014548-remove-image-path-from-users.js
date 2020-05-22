'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('users', 'image_path');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('users', 'image_path', {
      type: Sequelize.INTEGER,
      allowNull: true,
    });
  }
};
