'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('user_collections', 'description', {
      type: Sequelize.STRING,
      allowNull: true,
    },);
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('user_collections', 'description');
    
  }
};
