'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('user_deck_cards', 'user_decks');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('user_decks', 'user_deck_cards');
  }
};
