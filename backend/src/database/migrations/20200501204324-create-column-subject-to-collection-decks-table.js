'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('collection_decks', 'subject', {
      type: Sequelize.INTEGER,
      allowNull: false,
      references: { model: 'subjects', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'SET NULL'
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('collection_decks', 'subject');
    
  }
};
