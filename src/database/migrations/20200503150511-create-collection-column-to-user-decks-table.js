'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('user_decks', 'collection', {
      type: Sequelize.INTEGER,
      allowNull: true,
      references: { model: 'collection_decks', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'SET NULL'
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('user_decks', 'collection');
    
  }
};
