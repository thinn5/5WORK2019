const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "administrator/layout/main"
const POOL = require('../../database');
const MY_COMPETENCY = require('../../models/competency');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'administrator');

const TABLE = 'competencies';
const FIELD_ID = 'id';
const LIST = 'SELECT * FROM ' + TABLE + ' WHERE deletedAt IS NULL';
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const SOFT_DELETE = 'UPDATE ' + TABLE + ' SET deletedAt = ? WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.competencies = async(req, res) => {
    const competencies = await POOL.query(LIST);
    res.locals.metaTags = {
        title: "Competencies Maintainer",
        description: "Competencies Maintainer"
    };
    res.render(PATH.join(VIEW, 'competencies'), { competencies: competencies, layout: LAYOUT });
};

CONTROLLER.addCompetency = async(req, res, next) => {
    MY_COMPETENCY.Competency(req.body.name, req.body.description);
    const result = await POOL.query(INSERT, [MY_COMPETENCY]);
    res.locals.metaTags = {
        title: "Competencies Maintainer",
        description: "Competencies Maintainer"
    };
    req.flash('success', 'Competency saved successfully!');
    res.redirect('/admin/courses/competencies');
};

CONTROLLER.deleteCompetency = async(req, res) => {
    const { id } = req.params;
    req.body.deleteddAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { deleteddAt } = req.body;
    await POOL.query(SOFT_DELETE, [deleteddAt, id]);
    res.locals.metaTags = {
        title: "Competencies Maintainer",
        description: "Competencies Maintainer"
    };
    req.flash('success', 'Competency soft-deleted successfully!');
    res.redirect('/admin/courses/competencies');
};

CONTROLLER.updateCompetency = async(req, res) => {
    const { id } = req.params;
    req.body.updatedAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { name, description, updatedAt } = req.body;
    const UPDATE_COURSE = { name, description, updatedAt };
    await POOL.query(UPDATE, [UPDATE_COURSE, id]);
    res.locals.metaTags = {
        title: "Competencies Maintainer",
        description: "Competencies Maintainer"
    };
    req.flash('success', 'Competency updated successfully!');
    res.redirect('/admin/courses/competencies');
};

module.exports = CONTROLLER;