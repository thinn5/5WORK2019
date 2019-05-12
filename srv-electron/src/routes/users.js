const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const USER_CONTROLLER = require(PATH.join(__dirname, '..', 'controllers', 'userController'));

ROUTER.get('/', USER_CONTROLLER.list);
ROUTER.post('/add', USER_CONTROLLER.add);
ROUTER.get('/delete/:id', USER_CONTROLLER.delete);
ROUTER.get('/update/:id', USER_CONTROLLER.edit);
ROUTER.post('/update/:id', USER_CONTROLLER.update);

module.exports = ROUTER;