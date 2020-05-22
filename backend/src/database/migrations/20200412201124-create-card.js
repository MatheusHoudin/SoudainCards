'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('cards', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      front: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'card_faces', key: 'id'},
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      back: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'card_faces', key: 'id'},
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
    return queryInterface.dropTable('cards');
  }
};
