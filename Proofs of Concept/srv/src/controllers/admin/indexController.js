const CONTROLLER = {};
const PATH = require('path');

CONTROLLER.index = (req, res) => {
    res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'index'));
};

CONTROLLER.administrators = (req, res) => {
    res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'students'));
};

CONTROLLER.lecturers = (req, res) => {
    res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'students'));
};

CONTROLLER.students = (req, res) => {
    res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'students'));
};

module.exports = CONTROLLER;