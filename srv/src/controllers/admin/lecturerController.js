const CONTROLLER = {};
const PATH = require('path');
const POOL = require(PATH.join(__dirname, '..', '..', 'database'));
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'admin', 'students');
const MY_STUDENT = require('../../models/user');

const TABLE = 'users';
const FIELD_ID = 'id';
const LIST = 'SELECT * FROM ' + TABLE;
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const LIST_BY_ID = 'SELECT * FROM ' + TABLE + ' WHERE ' + FIELD_ID + ' = ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const DELETE = 'DELETE FROM ' + TABLE + ' WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.list = async (req, res) => {
    const students = await POOL.query('SELECT * FROM users');
    res.render(PATH.join(__dirname, '..', '..', 'views', 'admin', 'students'), { students });
};

CONTROLLER.add = async (req, res) => {
    req.body.role = "student";
    MY_STUDENT.User(req.body.username, req.body.password, req.body.firstName, req.body.lastName, req.body.email, req.body.role);
    await POOL.query(INSERT, [MY_STUDENT]);
    res.redirect('/admin/students');
};

CONTROLLER.delete = async (req, res) => {
    const { id } = req.params;
    await POOL.query(DELETE, [id]);
    res.redirect('/admin/students');
};

CONTROLLER.update = async (req, res) => {
    const { id } = req.params;
    req.body.updatedAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { username, firstName, lastName, email, updatedAt } = req.body;
    const UPDATE_STUDENT = { username, firstName, lastName, email, updatedAt };
    console.log(UPDATE_STUDENT);
    await POOL.query(UPDATE, [UPDATE_STUDENT, id]);
    res.redirect('/admin/students');
};

module.exports = CONTROLLER;