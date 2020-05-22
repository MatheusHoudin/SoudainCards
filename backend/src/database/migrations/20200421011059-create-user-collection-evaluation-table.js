'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('user_collection_evaluations', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      collection: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'collection_decks', key: 'id'},
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      evaluation_user: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'users', key: 'id'},
        onUpdate: 'CASCADE',
      },
      comment: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      like: {
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
    return queryInterface.dropTable('user_collection_evaluations');
  }
};
