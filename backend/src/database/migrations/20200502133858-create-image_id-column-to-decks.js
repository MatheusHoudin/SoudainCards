'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('decks', 'image_id', {
      type: Sequelize.INTEGER,
      allowNull: true,
      references: { model: 'files', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'SET NULL'
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('decks', 'image_id');
    
  }
};
