'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('collection_decks', 'collection_image', {
      type: Sequelize.INTEGER,
      allowNull: true,
      references: { model: 'files', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'SET NULL'
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('collection_decks', 'collection_image');
    
  }
};
