'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('cards', 'starred', {
      type: Sequelize.BOOLEAN,
      allowNull: false,
      defaultValue: false
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('cards', 'starred');
    
  }
};
