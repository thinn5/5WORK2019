const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const ADMINISTRATOR_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'administratorController'));

ROUTER.get('/', ADMINISTRATOR_ADMIN_CONTROLLER.list);
ROUTER.post('/add', ADMINISTRATOR_ADMIN_CONTROLLER.add);
ROUTER.post('/delete/:id', ADMINISTRATOR_ADMIN_CONTROLLER.delete);
ROUTER.post('/update/:id', ADMINISTRATOR_ADMIN_CONTROLLER.update);

module.exports = ROUTER;