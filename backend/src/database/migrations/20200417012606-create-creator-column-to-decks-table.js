'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('decks', 'creator', {
      type: Sequelize.INTEGER,
      allowNull: false,
      references: { model: 'users', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'CASCADE'
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('decks', 'creator');
    
  }
};
