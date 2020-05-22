'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('user_collections');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.createTable('user_collections', {
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
      collection: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'collection_decks', key: 'id'},
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      title: {
        type: Sequelize.STRING,
        allowNull: true,
      },
      description: {
        type: Sequelize.STRING,
        allowNull: true,
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
  }
};
