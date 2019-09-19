const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "administrator/layout/main"
const POOL = require('../../database');
const MY_ADMINISTRATOR = require('../../models/user');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'administrator');
const PASSPORT = require('passport');

const TABLE = 'users';
const FIELD_ID = 'id';
const ROLE = 'administrator';
const LIST = 'SELECT * FROM ' + TABLE + ' WHERE role = "' + ROLE + '" AND deletedAt IS NULL';
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const SOFT_DELETE = 'UPDATE ' + TABLE + ' SET deletedAt = ? WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.dashboard = (req, res) => {
    res.locals.metaTags = {
        title: "Dashboard",
        description: "Dashboard"
    };
    res.render(PATH.join(VIEW, 'index'), { layout: LAYOUT });
};

CONTROLLER.administrators = async(req, res) => {
    const administrators = await POOL.query(LIST);
    res.locals.metaTags = {
        title: "Administrators Maintainer",
        description: "Administrators Maintainer"
    };
    res.render(PATH.join(VIEW, 'administrators'), { administrators: administrators, layout: LAYOUT });
};

CONTROLLER.addAdministrator = async(req, res, next) => {
    req.body.role = ROLE;
    await PASSPORT.authenticate('local.signup', {
        successRedirect: '/admin/users/administrators',
        failureRedirect: '/admin/users/administrators',
        failureFlash: true
    })(req, res, next);
    res.locals.metaTags = {
        title: "Administrators Maintainer",
        description: "Administrators Maintainer"
    };
    req.flash('success', 'Administrator saved successfully! Well done!');
};

CONTROLLER.deleteAdministrator = async(req, res) => {
    const { id } = req.params;
    req.body.deleteddAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { deleteddAt } = req.body;
    await POOL.query(SOFT_DELETE, [deleteddAt, id]);
    res.locals.metaTags = {
        title: "Administrators Maintainer",
        description: "Administrators Maintainer"
    };
    req.flash('success', 'Administrator soft-deleted successfully! Well done!');
    res.redirect('/admin/users/administrators');
};

CONTROLLER.updateAdministrator = async(req, res) => {
    const { id } = req.params;
    req.body.updatedAt = require('moment')().format('YYYY-MM-DD HH:mm:ss');
    const { username, firstName, lastName, email, updatedAt } = req.body;
    const UPDATE_ADMINISTRATOR = { username, firstName, lastName, email, updatedAt };
    await POOL.query(UPDATE, [UPDATE_ADMINISTRATOR, id]);
    res.locals.metaTags = {
        title: "Administrators Maintainer",
        description: "Administrators Maintainer"
    };
    req.flash('success', 'Administrator updated successfully! Well done!');
    res.redirect('/admin/users/administrators');
};

module.exports = CONTROLLER;