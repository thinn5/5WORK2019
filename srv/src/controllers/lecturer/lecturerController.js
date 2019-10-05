const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "lecturer/layout/main"
const POOL = require('../../database');
const MY_ADMINISTRATOR = require('../../models/user');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'lecturer');
const PASSPORT = require('passport');

const FIELDS = 'u.UserID, u.GivenName, u.LastName, u.EmailAddress, s.QualCode, q.QualName, ROUND(( SELECT AVG( Grade = "PA" ) FROM student_grade WHERE UserID = u.UserID ), 2) * 100 AS Average';
const TABLE_USER = 'user u';
const TABLE_STUDENT_STUDY_PLAN = 'student_studyplan s';
const TABLE_QUALIFICATION = 'qualification q';
const TABLE_STUDENT_GRADE = 'student_grade';
const FIRST_INNER_ON = 'u.UserID = s.UserID';
const SECOND_INNER_ON = 's.QualCode = q.QualCode';
const FIELD_ID = 'UserID';
const ROLE = 'student';
const LIST = 'SELECT DISTINCT ' + FIELDS + ' FROM ' + TABLE_USER +
    ' INNER JOIN ' + TABLE_STUDENT_STUDY_PLAN + ' ON ' + FIRST_INNER_ON +
    ' INNER JOIN ' + TABLE_QUALIFICATION + ' ON ' + SECOND_INNER_ON +
    ' WHERE Role = "' + ROLE + '" AND DeletedAt IS NULL';
const FIELDS_CRN = 'UserID, CRN, TafeCompCode, TermCode, TermYear, Grade, UNIX_TIMESTAMP(GradeDate) AS GradeDate';
const LIST_CRN = 'SELECT ' + FIELDS_CRN + ' FROM ' + TABLE_STUDENT_GRADE + ' WHERE ' + FIELD_ID + ' = ?';

CONTROLLER.index = async(req, res) => {
    const students = await POOL.query(LIST);
    res.locals.metaTags = {
        title: "Main",
        description: "Main"
    };
    res.render(PATH.join(VIEW, 'index'), { students: students, layout: LAYOUT });
};

CONTROLLER.viewDetails = async(req, res) => {
    const crns = await POOL.query(LIST_CRN, req.params.id);
    res.locals.metaTags = {
        title: "Details",
        description: "Details"
    };
    res.render(PATH.join(VIEW, 'viewDetails'), { crns: crns, layout: LAYOUT });
};

module.exports = CONTROLLER;