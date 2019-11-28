var request = require('supertest');
var app = require('../index');
var expect = require('chai').expect;

var time = Date.now();

const userAdminCredentials = {
    email: 'gonzalo.soto@darkom.cl',
    password: 'tafesa'
}

const newUserAdminCredentials = {
    userId: '999999999',
    givenName: 'test',
    lastName: 'tested',
    emailAddress: 'test@test.com',
    password: 'tafesa',
    role: 'administrator'
}

const updateUserAdminCredentials = {
    emailAddress: 'UPDATE-test@test.com',
    givenName: 'UPDATE-test',
    lastName: 'UPDATE-tested',
    updatedAt: time
}

const deleteUserAdminCredentials = {
    id: '999999999',
    deletedAt: time
}

var authenticatedUser = request.agent(app);

before(function (done) {
    authenticatedUser
        .post('/')
        .send(userAdminCredentials)
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

describe('GET /admin/users/administrators', function () {
    it('Should return a 200 response if the user is able to READ Administrators Maintainer', function (done) {
        authenticatedUser.get('/admin/users/administrators')
            .expect(200, done);
    });
});

describe('POST /admin/users/administrators/add', function () {
    it('Should return a 302 response if the user is able to CREATE an Administrator', function (done) {
        authenticatedUser.post('/admin/users/administrators/add')
            .send(newUserAdminCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/administrators');
                done();
            });
    });
});

describe('POST /admin/users/administrators/update/:id', function () {
    it('Should return a 302 response if the user is able to UPDATE an Administrator', function (done) {
        authenticatedUser.post('/admin/users/administrators/update/999999999')
            .send(updateUserAdminCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/administrators');
                done();
            });
    });
});

describe('POST /admin/users/administrators/delete/:id', function () {
    it('Should return a 302 response if the user is able to SOFT-DELETE an Administrator', function (done) {
        authenticatedUser.post('/admin/users/administrators/delete/999999999')
            .send(deleteUserAdminCredentials)
            .end(function (err, response) {
                expect(response.statusCode).to.equal(302);
                expect('Location', '/admin/users/administrators');
                done();
            });
    });
});