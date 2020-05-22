'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('decks', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      subject: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'deck_subjects', key: 'id'},
        onUpdate: 'CASCADE',
      },
      image_path: {
        type: Sequelize.STRING,
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
    return queryInterface.dropTable('decks');
  }
};

