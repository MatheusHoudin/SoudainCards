'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('deck_cards', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      deck: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'decks', key: 'id'},
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      card: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'cards', key: 'id'},
        onUpdate: 'CASCADE',
      },
      created_at: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      updated_at: {
        type: Sequelize.DATE,
        allowNull: false,
      }
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('deck_cards');
  }
};
