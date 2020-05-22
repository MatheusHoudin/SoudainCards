'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('user_decks', 'user_collection_decks');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('user_collection_decks', 'user_decks');
  }
};
