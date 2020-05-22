'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('user_deck_evaluations', 'deck', {
      type: Sequelize.INTEGER,
      allowNull: false,
      references: { model: 'decks', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('user_deck_evaluations', 'deck');
    
  }
};
