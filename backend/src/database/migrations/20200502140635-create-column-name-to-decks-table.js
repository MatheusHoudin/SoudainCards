'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('decks', 'name', {
      type: Sequelize.STRING,
      allowNull: false,
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('decks', 'name');
    
  }
};
