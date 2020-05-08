'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('user_deck_cards', 'card');
    
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('user_deck_cards', 'card', {
      type: Sequelize.INTEGER,
      allowNull: true,
      references: { model: 'cards', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'SET NULL'
    },);
  }
};
