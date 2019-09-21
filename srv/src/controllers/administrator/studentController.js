const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "administrator/layout/main"
const POOL = require('../../database');
const MY_STUDENT = require('../../models/user');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'administrator');
const PASSPORT = require('passport');

const TABLE = 'users';
const FIELD_ID = 'id';
const ROLE = 'student';
const LIST = 'SELECT * FROM ' + TABLE + ' WHERE role = "' + ROLE + '" AND deletedAt IS NULL';
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const SOFT_DELETE = 'UPDATE ' + TABLE + ' SET deletedAt = ? WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.students = async(req, res) => {
    const students = await POOL.query(LIST);
    res.locals.metaTags = {
        title: "Students Maintainer",
        description: "Students Maintainer"
    };
    res.render(PATH.join(VIEW, 'students'), { students: students, layout: LAYOUT });
};

CONTROLLER.addStudent = async(req, res, next) => {
    req.body.role = ROLE;
    await PASSPORT.authenticate('local.signup', {
        successRedirect: '/admin/users/students',
        failureRedirect: '/admin/users/students',
        failureFlash: true
    })(req, res, next);
    res.locals.metaTags = {
        title: "Students Maintainer",
        description: "Students Maintainer"
    };
    req.flash('success', 'Student saved successfully!');
};

CONTROLLER.deleteStudent = async(req, res) => {
    const { id } = req.params;
    req.body.deleteddAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { deleteddAt } = req.body;
    await POOL.query(SOFT_DELETE, [deleteddAt, id]);
    res.locals.metaTags = {
        title: "Students Maintainer",
        description: "Students Maintainer"
    };
    req.flash('success', 'Student soft-deleted successfully!');
    res.redirect('/admin/users/students');
};

CONTROLLER.updateStudent = async(req, res) => {
    const { id } = req.params;
    req.body.updatedAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { username, firstName, lastName, email, updatedAt } = req.body;
    const UPDATE_STUDENT = { username, firstName, lastName, email, updatedAt };
    await POOL.query(UPDATE, [UPDATE_STUDENT, id]);
    res.locals.metaTags = {
        title: "Students Maintainer",
        description: "Students Maintainer"
    };
    req.flash('success', 'Student updated successfully!');
    res.redirect('/admin/users/students');
};

module.exports = CONTROLLER;