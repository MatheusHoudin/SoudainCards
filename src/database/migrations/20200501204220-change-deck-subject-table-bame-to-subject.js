'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('deck_subjects', 'subjects');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.renameTable('subjects', 'deck_subjects');
  }
};
