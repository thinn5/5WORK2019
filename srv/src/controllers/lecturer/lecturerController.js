const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "lecturer/layout/main"
const POOL = require('../../database');
const MY_ADMINISTRATOR = require('../../models/user');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'lecturer');
const PASSPORT = require('passport');

const TABLE = 'users';
const FIELD_ID = 'id';
const ROLE = 'student';
const LIST = 'SELECT * FROM ' + TABLE + ' WHERE role = "' + ROLE + '" AND deletedAt IS NULL';

CONTROLLER.index = async(req, res) => {
    const students = await POOL.query(LIST);
    res.locals.metaTags = {
        title: "Main",
        description: "Main"
    };
    res.render(PATH.join(VIEW, 'index'), { students: students, layout: LAYOUT });
};

module.exports = CONTROLLER;