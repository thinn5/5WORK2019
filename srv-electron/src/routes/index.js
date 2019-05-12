const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const INDEX_CONTROLLER = require(PATH.join(__dirname, '..', 'controllers', 'indexController'));

ROUTER.get('/', (req, res) => {
    res.send('Hello World');
});
//ROUTER.get('/', INDEX_CONTROLLER.show);

module.exports = ROUTER;