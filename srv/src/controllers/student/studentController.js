const CONTROLLER = {};
const PATH = require('path');
const LAYOUT = "student/layout/main"
const POOL = require('../../database');
const VIEW = PATH.join(__dirname, '..', '..', 'views', 'student');


const FIELD_ID = 'UserID';
const TABLE_STUDENT_GRADE = 'student_grade';
const TABLE_STUDENT_STUDY_PLAN = 'student_studyplan s';
const TABLE_QUALIFICATION = 'qualification q';
const TABLE_USER = 'user u';

const FIELDS_CRN = 'UserID, CRN, TafeCompCode, TermCode, TermYear, Grade, UNIX_TIMESTAMP(GradeDate) AS GradeDate';
const FIELDS = 'u.UserID, u.GivenName, u.LastName, u.EmailAddress, s.QualCode, q.QualName';

const FIRST_INNER_ON = 'u.UserID = s.UserID';
const SECOND_INNER_ON = 's.QualCode = q.QualCode';

const ROLE = 'student';

const LIST_CRN = 'SELECT ' + FIELDS_CRN + ' FROM ' + TABLE_STUDENT_GRADE + ' WHERE ' + FIELD_ID + ' = ?';
const LIST_PROGRESS = 'SELECT ROUND(((AVG(Grade = "PA")) * 100),2) AS Average FROM ' + TABLE_STUDENT_GRADE + ' WHERE ' + FIELD_ID + ' = ?';
const LIST = 'SELECT ' + FIELDS + ' FROM ' + TABLE_USER +
    ' INNER JOIN ' + TABLE_STUDENT_STUDY_PLAN + ' ON ' + FIRST_INNER_ON +
    ' INNER JOIN ' + TABLE_QUALIFICATION + ' ON ' + SECOND_INNER_ON +
    ' WHERE Role = "' + ROLE + '" AND DeletedAt IS NULL AND u.' + FIELD_ID + ' = ?';

CONTROLLER.index = async(req, res) => {
    const myUserId = req.user.UserID;
    const crns = await POOL.query(LIST_CRN, myUserId);
    const progress = await POOL.query(LIST_PROGRESS, myUserId);
    const studentData = await POOL.query(LIST, myUserId);
    res.locals.metaTags = {
        title: "Main",
        description: "Main"
    };
    res.render(PATH.join(VIEW, 'index'), { crns: crns, progress: progress, studentData: studentData, layout: LAYOUT });
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