module.exports = {
  dialect: 'postgres',
  host: '192.168.99.100',
  username: 'postgres',
  port: 5433,
  password: 'soudain',
  database: 'soudain',
  define: {
    timestamps: true,
    underscored: true,
    underscoredAll: true,
  },
};
