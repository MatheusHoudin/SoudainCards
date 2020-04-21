'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('users', 'login');
    
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('users', 'login', {
      type: Sequelize.STRING,
      allowNull: false,
    });
  }
};
