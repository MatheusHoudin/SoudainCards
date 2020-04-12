const express = require('express');
const routes = require('./routes');

require('./database');

const app = express();

app.use(express.json());
app.use(routes);

app.listen(3001,() => {
    console.log('listening on 3001')
});