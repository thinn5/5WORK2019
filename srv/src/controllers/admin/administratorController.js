const CONTROLLER = {};
const PATH = require('path');
const POOL = require(PATH.join(__dirname, '..', '..', 'database'));
const MY_ADMINISTRATOR = require('../../models/user');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'admin', 'administrators');

const TABLE = 'users';
const FIELD_ID = 'id';
const ROLE = 'administrator';
const LIST = 'SELECT * FROM ' + TABLE + ' WHERE role = "' + ROLE + '"';
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const DELETE = 'DELETE FROM ' + TABLE + ' WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.list = async (req, res) => {
    const administrators = await POOL.query(LIST);
    res.render(VIEW, { administrators });
};

CONTROLLER.add = async (req, res) => {
    req.body.role = ROLE;
    MY_ADMINISTRATOR.User(req.body.username, req.body.password, req.body.firstName, req.body.lastName, req.body.email, req.body.role);
    await POOL.query(INSERT, [MY_ADMINISTRATOR]);
    req.flash('success', 'Administrator successfully saved');
    res.redirect('/admin/administrators');    
};

CONTROLLER.delete = async (req, res) => {
    const { id } = req.params;
    await POOL.query(DELETE, [id]);
    req.flash('success', 'Administrator successfully saved');
    res.redirect('/admin/administrators');
};

CONTROLLER.update = async (req, res) => {
    const { id } = req.params;
    req.body.updatedAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { username, firstName, lastName, email, updatedAt } = req.body;
    const UPDATE_ADMINISTRATOR = { username, firstName, lastName, email, updatedAt };
    await POOL.query(UPDATE, [UPDATE_ADMINISTRATOR, id]);
    req.flash('success', 'Administrator successfully updated');
    res.redirect('/admin/administrators');
};

module.exports = CONTROLLER;