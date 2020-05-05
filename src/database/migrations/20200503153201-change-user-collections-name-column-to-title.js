'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.renameColumn('user_collections', 'name', 'title');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.renameColumn('user_collections', 'title', 'name');;
  },
};
