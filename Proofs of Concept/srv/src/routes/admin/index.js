const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const INDEX_CONTROLLER = require(PATH.join(__dirname, '..', '..','..', 'src', 'controllers', 'admin', 'indexController'));
const STUDENT_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'studentController'));
const LECTURER_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'lecturerController'));
const ADMINISTRATOR_ADMIN_CONTROLLER = require(PATH.join(__dirname, '..', '..', 'controllers', 'admin', 'administratorController'));

ROUTER.get('/', INDEX_CONTROLLER.index);
ROUTER.get('/admin/administrators', ADMINISTRATOR_ADMIN_CONTROLLER.list);
ROUTER.get('/admin/lecturers', LECTURER_ADMIN_CONTROLLER.list);
ROUTER.get('/admin/students', STUDENT_ADMIN_CONTROLLER.list);

module.exports = ROUTER;