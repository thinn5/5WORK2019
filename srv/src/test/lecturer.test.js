var request = require('supertest');
var app = require('../index');
var expect = require('chai').expect;

var time = Date.now();

const userLecturerCredentials = {
    email: 'gonzalo.soto@darkom.cl',
    password: 'tafesa'
}

const newUserLecturerCredentials = {
    userId: '888888888',
    givenName: 'test',
    lastName: 'tested',
    emailAddress: 'test@test.com',
    password: 'tafesa',
    role: 'lecturer'
}

const updateUserLecturerCredentials = {
    emailAddress: 'UPDATE-test@test.com',
    givenName: 'UPDATE-test',
    lastName: 'UPDATE-tested',
    updatedAt: time
}

const deleteUserLecturerCredentials = {
    id: '888888888',
    deletedAt: time
}

var authenticatedUser = request.agent(app);

before(function (done) {
    authenticatedUser
        .post('/')
        .send(userLecturerCredentials)
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

describe('GET /admin/users/lecturers', function () {
    it('Should return a 200 response if the user is able to READ Lecturers Maintainer', function (done) {
        authenticatedUser.get('/admin/users/lecturers')
            .expect(200, done);
    });
});

describe('POST /admin/users/lecturers/add', function () {
    it('Should return a 302 response if the user is able to CREATE a Lecturer', function (done) {
        authenticatedUser.post('/admin/users/lecturers/add')
            .send(newUserLecturerCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/lecturers');
                done();
            });
    });
});

describe('POST /admin/users/lecturers/update/:id', function () {
    it('Should return a 302 response if the user is able to UPDATE a Lecturer', function (done) {
        authenticatedUser.post('/admin/users/lecturers/update/888888888')
            .send(updateUserLecturerCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/lecturers');
                done();
            });
    });
});

describe('POST /admin/users/lecturers/delete/:id', function () {
    it('Should return a 302 response if the user is able to SOFT-DELETE a Lecturer', function (done) {
        authenticatedUser.post('/admin/users/lecturers/delete/888888888')
            .send(deleteUserLecturerCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/lecturers');
                done();
            });
    });
});