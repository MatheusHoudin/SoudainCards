'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('password_resets', 'used');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('password_resets', 'used', {
      type: Sequelize.BOOLEAN,
      allowNull: false,
      defaultValue: false,
    });
  },
};
