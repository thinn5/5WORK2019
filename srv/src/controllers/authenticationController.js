const CONTROLLER = {};
const PATH = require('path');

CONTROLLER.login = (req, res) => {
    //res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'index'));
    res.send('Hello Login!');
};

module.exports = CONTROLLER;