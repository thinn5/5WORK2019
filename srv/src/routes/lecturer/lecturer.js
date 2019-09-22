const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const LECTURER_CONTROLLER = require(PATH.join(__dirname, '..', '..', '..', 'src', 'controllers', 'lecturer', 'lecturerController'));
const { isLoggedIn } = require('../../lib/auth');

ROUTER.get('/index', isLoggedIn, LECTURER_CONTROLLER.index);

module.exports = ROUTER;