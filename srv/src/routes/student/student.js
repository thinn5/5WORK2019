const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const STUDENT_CONTROLLER = require(PATH.join(__dirname, '..', '..', '..', 'src', 'controllers', 'student', 'studentController'));
const { isLoggedIn } = require('../../lib/auth');

ROUTER.get('/index', isLoggedIn, STUDENT_CONTROLLER.index);

module.exports = ROUTER;