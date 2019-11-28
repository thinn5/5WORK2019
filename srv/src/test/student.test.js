var request = require('supertest');
var app = require('../index');
var expect = require('chai').expect;

var time = Date.now();

const userStudentCredentials = {
    email: 'gonzalo.soto@darkom.cl',
    password: 'tafesa'
}

const newUserStudentCredentials = {
    userId: '777777777',
    givenName: 'test',
    lastName: 'tested',
    emailAddress: 'test@test.com',
    password: 'tafesa',
    role: 'student'
}

const updateUserStudentCredentials = {
    emailAddress: 'UPDATE-test@test.com',
    givenName: 'UPDATE-test',
    lastName: 'UPDATE-tested',
    updatedAt: time
}

const deleteuserStudentCredentials = {
    id: '777777777',
    deletedAt: time
}

var authenticatedUser = request.agent(app);

before(function (done) {
    authenticatedUser
        .post('/')
        .send(userStudentCredentials)
        .end(function (err, response) {
            expect(response.statusCode).to.equal(302);
            expect('Location', '/admin/dashboard');
            done();
        });
});

describe('GET /admin/dashboard', function () {
    it('Should return a 200 response if the user is logged in', function (done) {
        authenticatedUser.get('/admin/dashboard')
            .expect(200, done);
    });
});

describe('GET /admin/users/students', function () {
    it('Should return a 200 response if the user is able to READ Students Maintainer', function (done) {
        authenticatedUser.get('/admin/users/students')
            .expect(200, done);
    });
});

describe('POST /admin/users/students/add', function () {
    it('Should return a 302 response if the user is able to CREATE a Student', function (done) {
        authenticatedUser.post('/admin/users/students/add')
            .send(newUserStudentCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/students');
                done();
            });
    });
});

describe('POST /admin/users/students/update/:id', function () {
    it('Should return a 302 response if the user is able to UPDATE a Student', function (done) {
        authenticatedUser.post('/admin/users/students/update/777777777')
            .send(updateUserStudentCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/students');
                done();
            });
    });
});

describe('POST /admin/users/students/delete/:id', function () {
    it('Should return a 302 response if the user is able to SOFT-DELETE a Student', function (done) {
        authenticatedUser.post('/admin/users/students/delete/777777777')
            .send(deleteuserStudentCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/students');
                done();
            });
    });
});