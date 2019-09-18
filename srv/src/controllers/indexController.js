const CONTROLLER = {};
const PATH = require('path');

CONTROLLER.index = (req, res) => {
    //res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'index'));
    res.send('Hello World!');
};

module.exports = CONTROLLER;