const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const INDEX_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'src', 'controllers', 'indexController'));

ROUTER.get('/', INDEX_CONTROLLER.index);

module.exports = ROUTER;