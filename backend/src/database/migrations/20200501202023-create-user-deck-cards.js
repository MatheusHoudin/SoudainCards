'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('user_deck_cards', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      user: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'users', key: 'id'},
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
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
        onDelete: 'CASCADE'
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
    return queryInterface.dropTable('user_deck_cards');
  }
};
