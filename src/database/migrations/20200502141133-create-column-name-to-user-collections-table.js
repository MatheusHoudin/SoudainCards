'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('user_collections', 'name', {
      type: Sequelize.STRING,
      allowNull: true,
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('user_collections', 'name');
    
  }
};
