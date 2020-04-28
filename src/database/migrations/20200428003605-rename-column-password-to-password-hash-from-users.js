'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.renameColumn('users', 'password', 'password_hash');
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.renameColumn('users', 'password_hash', 'password');;
  },
};
