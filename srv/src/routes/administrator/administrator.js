const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const ADMINISTRATOR_CONTROLLER = require(PATH.join(__dirname, '..', '..', '..', 'src', 'controllers', 'administrator', 'administratorController'));
const { isLoggedIn } = require('../../lib/auth');
const { isAdministrator } = require('../../lib/auth');

ROUTER.get('/dashboard', isLoggedIn, isAdministrator, ADMINISTRATOR_CONTROLLER.dashboard);
ROUTER.get('/users/administrators', isLoggedIn, isAdministrator, ADMINISTRATOR_CONTROLLER.administrators);
ROUTER.post('/users/administrators/add', isLoggedIn, isAdministrator, ADMINISTRATOR_CONTROLLER.addAdministrator);
ROUTER.post('/users/administrators/delete/:id', isLoggedIn, isAdministrator, ADMINISTRATOR_CONTROLLER.deleteAdministrator);
ROUTER.post('/users/administrators/update/:id', isLoggedIn, isAdministrator, ADMINISTRATOR_CONTROLLER.updateAdministrator);

module.exports = ROUTER;