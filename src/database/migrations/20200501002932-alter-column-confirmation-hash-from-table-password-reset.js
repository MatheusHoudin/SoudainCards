'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.changeColumn('password_resets', 'confirmation_hash', {
      type: Sequelize.STRING,
      allowNull: true,
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.changeColumn('password_resets', 'confirmation_hash', {
      type: Sequelize.STRING,
      allowNull: false,
    });
  },
};
