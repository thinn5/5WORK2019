const EXPRESS = require('express');
const ROUTER = EXPRESS.Router();
const PATH = require('path');
const COMPETENCY_CONTROLLER = require(PATH.join(__dirname, '..', '..', '..', 'src', 'controllers', 'administrator', 'competencyController'));
const { isLoggedIn } = require('../../lib/auth');

ROUTER.get('/courses/competencies', isLoggedIn, COMPETENCY_CONTROLLER.competencies);
ROUTER.post('/courses/competencies/add', isLoggedIn, COMPETENCY_CONTROLLER.addCompetency);
ROUTER.post('/courses/competencies/delete/:id', isLoggedIn, COMPETENCY_CONTROLLER.deleteCompetency);
ROUTER.post('/courses/competencies/update/:id', isLoggedIn, COMPETENCY_CONTROLLER.updateCompetency);

module.exports = ROUTER;