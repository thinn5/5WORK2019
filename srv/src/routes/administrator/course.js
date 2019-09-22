const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const COURSE_CONTROLLER = require(PATH.join(__dirname, '..', '..', '..', 'src', 'controllers', 'administrator', 'courseController'));
const { isLoggedIn } = require('../../lib/auth');

ROUTER.get('/courses/courses', isLoggedIn, COURSE_CONTROLLER.courses);
ROUTER.post('/courses/courses/add', isLoggedIn, COURSE_CONTROLLER.addCourse);
ROUTER.post('/courses/courses/delete/:id', isLoggedIn, COURSE_CONTROLLER.deleteCourse);
ROUTER.post('/courses/courses/update/:id', isLoggedIn, COURSE_CONTROLLER.updateCourse);

module.exports = ROUTER;