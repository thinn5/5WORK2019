const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const ADMINISTRATOR_CONTROLLER = require(PATH.join(__dirname, '..', '..', '..', 'src', 'controllers', 'administrator', 'administratorController'));
const { isLoggedIn } = require('../../lib/auth');

ROUTER.get('/dashboard', isLoggedIn, ADMINISTRATOR_CONTROLLER.dashboard);
ROUTER.get('/users/administrators', isLoggedIn, ADMINISTRATOR_CONTROLLER.administrators);
ROUTER.post('/users/administrators/add', isLoggedIn, ADMINISTRATOR_CONTROLLER.addAdministrator);
ROUTER.post('/users/administrators/delete/:id', isLoggedIn, ADMINISTRATOR_CONTROLLER.deleteAdministrator);
ROUTER.post('/users/administrators/update/:id', isLoggedIn, ADMINISTRATOR_CONTROLLER.updateAdministrator);

module.exports = ROUTER;