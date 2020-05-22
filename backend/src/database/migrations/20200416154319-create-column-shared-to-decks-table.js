'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('decks', 'shared', Sequelize.BOOLEAN);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('decks', 'shared');
  }
};
