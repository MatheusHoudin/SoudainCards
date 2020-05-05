'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('shared_decks', 'name', {
      type: Sequelize.STRING,
      allowNull: true,
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('shared_decks', 'name');
    
  }
};
