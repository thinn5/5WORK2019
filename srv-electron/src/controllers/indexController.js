'use strict';
const CONTROLLER = {};
const PATH = require('path');

CONTROLLER.show = (req, res) => {
    res.render(PATH.join(__dirname, '..', 'views', 'index'));
};

module.exports = CONTROLLER;