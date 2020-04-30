'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.addColumn('password_resets', 'id', {
      type: Sequelize.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement:true,
    });
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.removeColumn('password_resets', 'id');
    
  }
};
