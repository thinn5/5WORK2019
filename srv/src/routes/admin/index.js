const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const INDEX_CONTROLLER = require(PATH.join(__dirname, '..', '..','..', 'src', 'controllers', 'admin', 'indexController'));
const STUDENT_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'studentController'));

ROUTER.get('/', INDEX_CONTROLLER.index);
ROUTER.get('/admin/administrators', INDEX_CONTROLLER.administrators);
ROUTER.get('/admin/lecturers', INDEX_CONTROLLER.lecturers);
ROUTER.get('/admin/students', STUDENT_ADMIN_CONTROLLER.list);

module.exports = ROUTER;