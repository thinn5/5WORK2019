const PASSPORT = require('passport');
const LOCAL_STRATEGY = require('passport-local').Strategy;

const POOL = require('../database');
const HELPERS = require('./helpers');

const MY_ADMINISTRATOR = require('../models/user');
const TABLE = 'users';
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const SELECT = 'SELECT * FROM ' + TABLE + ' WHERE username = ?';

PASSPORT.use('local.signin', new LOCAL_STRATEGY({
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
}, async(req, username, password, done) => {
    const rows = await POOL.query(SELECT, [username]);
    if (rows.length > 0) {
        const user = rows[0];
        const validPassword = await HELPERS.matchPassword(password, user.password)
        if (validPassword) {
            done(null, user, req.flash('success', ' Welcome ' + user.username));
        } else {
            done(null, false, req.flash('message', 'Incorrect Password'));
        }
    } else {
        return done(null, false, req.flash('message', 'The Username does not exists.'));
    }
}));

PASSPORT.use('local.signup', new LOCAL_STRATEGY({
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
}, async(req, username, password, done) => {
    req.body.password = await HELPERS.encryptPassword(password);
    MY_ADMINISTRATOR.User(req.body.username, req.body.password, req.body.firstName, req.body.lastName, req.body.email, req.body.role);
    const result = await POOL.query(INSERT, [MY_ADMINISTRATOR]);
    MY_ADMINISTRATOR.id = result.insertId;
    return done(null, MY_ADMINISTRATOR);
}));

PASSPORT.serializeUser((user, done) => {
    done(null, user.id);
});

PASSPORT.deserializeUser(async(id, done) => {
    const rows = await POOL.query('SELECT * FROM users WHERE id = ?', [id]);
    done(null, rows[0]);
});