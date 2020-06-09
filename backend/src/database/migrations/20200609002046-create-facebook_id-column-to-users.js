'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('users', 'facebook_id', {
      type: Sequelize.STRING,
      allowNull: true,
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('users', 'facebook_id');
  }
};
