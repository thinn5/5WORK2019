'use strict';
var crypto = require('crypto');

const CONTROLLER = {};
const PATH = require('path');
const POOL = require(PATH.join(__dirname, '..', 'config', 'database'));

const TABLE = 'users';
const FIELD_ID = 'id';
const LIST = 'SELECT * FROM ' + TABLE;
const INSERT = 'INSERT INTO ' + TABLE + ' SET ?';
const LIST_BY_ID = 'SELECT * FROM ' + TABLE + ' WHERE ' + FIELD_ID + ' = ?';
const UPDATE = 'UPDATE ' + TABLE + ' SET ? WHERE ' + FIELD_ID + ' = ?';
const DELETE = 'DELETE FROM ' + TABLE + ' WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.list = (req, res) => {
    req.getConnection((err, conn) => {
        conn.query(LIST, (err, results) => {
            if (err) {
                next(err);
            }
            res.render(PATH.join(__dirname, '..', 'views', 'admin', 'users', 'users'), {
                data: results
            });
        });
    });
};

CONTROLLER.add = (req, res) => {
    const data = req.body;
    var salt = genRandomString(16); /** Gives us salt of length 16 */
    var hashedPass = sha512(data.password, salt);
    data.password = hashedPass.passwordHash;
    req.getConnection((err, conn) => {
        conn.query(INSERT, [data], (err, results) => {
            if (err) {
                next(err);
            }
            res.redirect('/');
        });
    });
};

CONTROLLER.edit = (req, res) => {
    const id = req.params.id;
    req.getConnection((err, conn) => {
        conn.query(LIST_BY_ID, [id], (err, result) => {
            if (err) {
                next(err);
            }
            res.render('user_edit', {
                data: result[0]
            });
        });
    });
};

CONTROLLER.update = (req, res) => {
    const id = req.params.id;
    const newUser = req.body;
    var salt = genRandomString(16); /** Gives us salt of length 16 */
    var hashedPass = sha512(newUser.password, salt);
    newUser.password = hashedPass.passwordHash;
    console.log(newUser.password);
    req.getConnection((err, conn) => {
        conn.query(UPDATE, [newUser, id], (err, results) => {
            console.log(req);
            if (err) {
                next(err);
            }
            res.redirect('/');
        });
    });
};

CONTROLLER.delete = (req, res) => {
    const id = req.params.id;
    req.getConnection((err, conn) => {
        conn.query(DELETE, [id], (err, results) => {
            if (err) {
                next(err);
            }
            res.redirect('/');
        })
    })
};

var genRandomString = function (length) {
    return crypto.randomBytes(Math.ceil(length / 2))
        .toString('hex') /** convert to hexadecimal format */
        .slice(0, length);   /** return required number of characters */
};

var sha512 = function (password, salt) {
    var hash = crypto.createHmac('sha512', salt); /** Hashing algorithm sha512 */
    hash.update(password);
    var value = hash.digest('hex');
    return {
        salt: salt,
        passwordHash: value
    };
};

module.exports = CONTROLLER;