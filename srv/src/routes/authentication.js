const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const AUTHENTICATION_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'src', 'controllers', 'authenticationController'));

ROUTER.post('/login', AUTHENTICATION_CONTROLLER.login);

module.exports = ROUTER;