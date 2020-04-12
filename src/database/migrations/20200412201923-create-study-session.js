'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('study_sessions', {
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
      next_study_day: {
        type: Sequelize.DATE,
        allowNull: false,
      },
      new: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
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
    return queryInterface.dropTable('study_sessions');
  }
};



