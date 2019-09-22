const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "administrator/layout/main"
const POOL = require('../../database');
const MY_COURSE = require('../../models/course');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'administrator');

const TABLE = 'courses';
const FIELD_ID = 'id';
const LIST = 'SELECT * FROM ' + TABLE + ' WHERE deletedAt IS NULL';
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const SOFT_DELETE = 'UPDATE ' + TABLE + ' SET deletedAt = ? WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.courses = async(req, res) => {
    const courses = await POOL.query(LIST);
    res.locals.metaTags = {
        title: "Courses Maintainer",
        description: "Courses Maintainer"
    };
    res.render(PATH.join(VIEW, 'courses'), { courses: courses, layout: LAYOUT });
};

CONTROLLER.addCourse = async(req, res, next) => {
    MY_COURSE.Course(req.body.name, req.body.description);
    const result = await POOL.query(INSERT, [MY_COURSE]);
    res.locals.metaTags = {
        title: "Courses Maintainer",
        description: "Courses Maintainer"
    };
    req.flash('success', 'Course saved successfully!');
    res.redirect('/admin/courses/courses');
};

CONTROLLER.deleteCourse = async(req, res) => {
    const { id } = req.params;
    req.body.deleteddAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { deleteddAt } = req.body;
    await POOL.query(SOFT_DELETE, [deleteddAt, id]);
    res.locals.metaTags = {
        title: "Courses Maintainer",
        description: "Courses Maintainer"
    };
    req.flash('success', 'Course soft-deleted successfully!');
    res.redirect('/admin/courses/courses');
};

CONTROLLER.updateCourse = async(req, res) => {
    const { id } = req.params;
    req.body.updatedAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { name, description, updatedAt } = req.body;
    const UPDATE_COURSE = { name, description, updatedAt };
    await POOL.query(UPDATE, [UPDATE_COURSE, id]);
    res.locals.metaTags = {
        title: "Courses Maintainer",
        description: "Courses Maintainer"
    };
    req.flash('success', 'Course updated successfully!');
    res.redirect('/admin/courses/courses');
};

module.exports = CONTROLLER;