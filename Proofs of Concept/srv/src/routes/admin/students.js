const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const STUDENT_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'studentController'));

ROUTER.get('/', STUDENT_ADMIN_CONTROLLER.list);
ROUTER.post('/add', STUDENT_ADMIN_CONTROLLER.add);
ROUTER.post('/delete/:id', STUDENT_ADMIN_CONTROLLER.delete);
ROUTER.post('/update/:id', STUDENT_ADMIN_CONTROLLER.update);

module.exports = ROUTER;