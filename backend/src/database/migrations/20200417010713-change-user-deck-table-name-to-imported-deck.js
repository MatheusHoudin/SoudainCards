'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('user_decks', 'imported_decks');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('imported_decks', 'user_decks');
  }
};
