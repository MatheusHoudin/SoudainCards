'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('card_face_contents', 'file', {
      type: Sequelize.INTEGER,
      allowNull: true,
      references: { model: 'files', key: 'id'},
      onUpdate: 'CASCADE',
      onDelete: 'SET NULL'
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('card_face_contents', 'file');
    
  }
};
