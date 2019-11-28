var request = require('supertest');
var app = require('../index');

const userAdminCredentials = {
    email: 'gonzalo.soto@darkom.cl',
    password: 'tafesa'
}

const userLecturerCredentials = {
    email: "kym.bond@tafesa.edu.au",
    password: "tafesa"
}

const userStudentCredentials = {
    email: "m_perez@hotmail.com",
    password: "tafesa"
}

describe("Homepage", function () {
    it("Shows login form", function (done) {
        request(app).get("/")
            .expect(200)
            .expect(/Login/, done)
    })
});

describe("Post login form Students", function () {
    it("Redirects students to hub when success", function (done) {
        request(app).post("/")
            .send(userStudentCredentials)
            .expect(302)
            .expect('Location', '/hub', done)
    })
});

describe("Post login form Lecturers", function () {
    it("Redirects lecturers to hub when success", function (done) {
        request(app).post("/")
            .send(userLecturerCredentials)
            .expect(302)
            .expect('Location', '/hub', done)
    })
});

describe("Post login form Administrators", function () {
    it("Redirects lecturers to hub when success", function (done) {
        request(app).post("/")
            .send(userAdminCredentials)
            .expect(302)
            .expect('Location', '/hub', done)
    })
});

