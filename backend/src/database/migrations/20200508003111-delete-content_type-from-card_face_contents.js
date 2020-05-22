'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('card_face_contents', 'content_type');
    
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('card_face_contents', 'content_type', {
      type: Sequelize.STRING,
      allowNull: false,
    });
  }
};
