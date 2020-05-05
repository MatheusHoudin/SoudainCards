'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('decks', 'image_path');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('decks', 'image_path', {
      type: Sequelize.STRING,
      allowNull: true,
    });
  },
};
