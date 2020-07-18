'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('collection_decks', 'subject');
    
  },

  down: (queryInterface, Sequelize) => {
  }
};
