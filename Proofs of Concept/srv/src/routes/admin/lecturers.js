const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const LECTURER_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'lecturerController'));

ROUTER.get('/', LECTURER_ADMIN_CONTROLLER.list);
ROUTER.post('/add', LECTURER_ADMIN_CONTROLLER.add);
ROUTER.post('/delete/:id', LECTURER_ADMIN_CONTROLLER.delete);
ROUTER.post('/update/:id', LECTURER_ADMIN_CONTROLLER.update);

module.exports = ROUTER;