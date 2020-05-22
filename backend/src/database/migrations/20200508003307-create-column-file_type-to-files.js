'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('files', 'type', {
      type: Sequelize.STRING,
      allowNull: false,
      defaultValue: ""
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('files', 'type');
  }
};
