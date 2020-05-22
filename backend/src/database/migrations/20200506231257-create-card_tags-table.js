'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('card_tags', {
      tag: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'tags', key: 'id'},
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
