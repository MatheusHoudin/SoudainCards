'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('user_deck_evaluations', 'user_deck');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('user_deck_evaluations', 'user_deck', {
      type: Sequelize.INTEGER,
      allowNull: false,
      references: { model: 'user_decks', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
  }
};
