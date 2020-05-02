'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('collection_decks', 'image_path');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('collection_decks', 'image_path', {
      type: Sequelize.STRING,
      allowNull: false,
    });
  },
};
