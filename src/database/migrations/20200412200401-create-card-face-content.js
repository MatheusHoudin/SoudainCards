'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('card_face_contents', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
      },
      card_face: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'card_faces', key: 'id'},
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      face_content: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: { model: 'face_contents', key: 'id'},
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
    return queryInterface.dropTable('card_face_contents');
  }
};
