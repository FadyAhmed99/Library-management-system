/*
const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../app');
const expect = chai.expect;
chai.use(chaiHttp);


describe("GET /users", () => {
    it("should return status 200", async()=>{
        let res = await chai.request(server)
        .get('/users/profile')

        expect(res.status).to.equal(401);
    });

});
*/

const User = require('../models/usersSchema');
const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../app');
const request = require('supertest');
chai.should();
chai.use(chaiHttp);


describe.only("sign up", ()=>{
    it("should signup users", (done)=>{
        request(server)
        .post('/users/signup')
        .send({username: "abdoHanyx", password: "meow1"})
        .end((err, res)=>{
            res.should.have.status(200);
            res.body.should.be.a('object');
            res.body.should.have.property("success",true);
            res.body.should.have.property("status", "Registeration Successful");
            done();
        });
    });
    
    afterEach(async()=>{
       await User.deleteOne({username: "abdoHanyx"});
    });
    /*it("should login users", (done)=>{
        chai.request(server)
        .post('/users/login')
        .send({username: "Abdoxxxqvxd", password: "meow1"})
        .end((err, res)=>{
            res.should.have.status(200);
            done();
        });
    });*/
});
