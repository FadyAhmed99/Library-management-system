/*
In a shell, run:
-----------------
mongod --dbpath=data --bind_ip 127.0.0.1

In another shell, run these lines one by one:
-------------------------------------------------
mongo
use LibraryManagementSystem

db.libraries.insertOne({"_id":ObjectId("5fd53f880f2d076ac295de1d"), "name":"library1", "librarian":ObjectId("5ff86dbc85361e52dc5ba275"), "available":[]})
db.libraries.insertOne({"_id":ObjectId("5fd53f8e0f2d076ac295de1e"), "name":"library2", "librarian":ObjectId("5ff86dbc85361e52dc5ba276"), "available":[]})
db.libraries.insertOne({"_id":ObjectId("5fd53f910f2d076ac295de1f"), "name":"library3", "librarian":ObjectId("5ff86dbc85361e52dc5ba277"), "available":[]})

db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba275"),"username":"librarian1", "librarian":true, "subscribedLibraries":[] ,"salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba276"),"username":"librarian2", "librarian":true, "subscribedLibraries":[] ,"salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba277"),"username":"librarian3", "librarian":true, "subscribedLibraries":[] ,"salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba279"), "username":"member", "subscribedLibraries":[{"_id":ObjectId("5fd53f880f2d076ac295de1d"), "member": true}, {"_id":ObjectId("5fd53f8e0f2d076ac295de1e"), "member": true},{"_id":ObjectId("5fd53f910f2d076ac295de1f"), "member": true}], "salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})

db.items.insertOne({"_id":ObjectId("5ff7e5c246f9159e445c50b7"), "name":"item1Book", "genre": "wow", "type":"book", "author":"cat", "language":"arabic", "ISBN":"24323232", "available":[{"_id":ObjectId("5fd53f880f2d076ac295de1d"), "location":"shelf-3", "lateFees":5, "inLibrary":false, "image":"imagelink", "amount" : 99999999999999999},{"_id":ObjectId("5fd53f8e0f2d076ac295de1e"),"amount":99999999999999999, "location":"shelf-3", "lateFees":5, "inLibrary":true, "image":"imagelink"}, {"_id":ObjectId("5fd53f910f2d076ac295de1f"),"amount":99999999999999999, "location":"shelf-3", "lateFees":5, "inLibrary":true, "image":"imagelink"}]})
db.items.insertOne({"_id":ObjectId("5ff7e5c246f9159e445c50b8"), "name":"item1Book", "genre": "wow", "type":"ebook", "author":"cat", "language":"arabic", "ISBN":"24323232", "available":[{"_id":ObjectId("5fd53f880f2d076ac295de1d"), "location":"shelf-3", "lateFees":5, "inLibrary":false, "image":"imagelink", "itemLink":"link"},{"_id":ObjectId("5fd53f8e0f2d076ac295de1e"),"location":"shelf-3", "lateFees":5, "inLibrary":false, "image":"imagelink", "itemLink":"link"}, {"_id":ObjectId("5fd53f910f2d076ac295de1f"), "lateFees":5, "inLibrary":false, "image":"imagelink", "itemLink":"link"}]})

db.transactions.insertOne({"_id":ObjectId("5ffb09fa1fc3602ec41d8bf2"),"user":ObjectId("5ff86dbc85361e52dc5ba279"), "borrowedFrom": ObjectId("5fd53f880f2d076ac295de1d"), "item":ObjectId("5ff7e5c246f9159e445c50b7"), "returnedTo":ObjectId("5fd53f8e0f2d076ac295de1e"), "lateFees": 5, "requestedToReturn": true, "returned": true, "hasFees": true})
db.fees.insertOne({"_id":ObjectId("5ffb0ae01fc3602ec41d8bf2"),"user":ObjectId("5ff86dbc85361e52dc5ba279"), "transactionId": ObjectId("5ffb09fa1fc3602ec41d8bf2"), "item":ObjectId("5ff7e5c246f9159e445c50b7"), "fees": 5, "paid": false})
*/

const fs = require('fs');
const path = require('path');
const User = require('../models/usersSchema');
const chai = require('chai');
const chaiHttp = require('chai-http');
const server = require('../app');
const request = require('supertest');
chai.should();
chai.use(chaiHttp);
const PhysicalBorrowRequests = require('../models/physicalBorrowRequestSchema');
const Transaction = require('../models/transactionSchema');
const mongoose = require('mongoose');

var user = "userTest";  // regarding sign up/in
var item = {name: "itemTest", type: "magazine" , genre: "sci-fi", author: "eng", language:"ar", inLibrary: true, lateFees: 12, location:"s-5"} // regarding item
var itemMod = {name: "test1mod", type: "magazine" , genre: "sci-fi", author: "eng", language:"en", inLibrary: true, lateFees: 12, location:"s-5"};
var token = "";
var adminToken = "";
var admin2Token = "";
var admin3Token = "";
var userId = "";
var itemId = "";
var myItemId = "5ff7e5c246f9159e445c50b7";
var myNonItemId = "5ff7e5c246f9159e445c50b8";
var library1Id = "5fd53f880f2d076ac295de1d";
var library2Id = "5fd53f8e0f2d076ac295de1e";
var library3Id = "5fd53f910f2d076ac295de1f";
var review = "good";
var rating = 4;
var memToken = "";
var bReq3Id = "";
var bReq2Id = "";
var bReq1Id = "";
var feeId = "5ffb0ae01fc3602ec41d8bf2";
var transactionId = "5ffb09fa1fc3602ec41d8bf2";

describe("Users API Tests", ()=>{
    describe("Sign up", ()=>{
        it("should signup user correctly by speicfying username and password only", (done)=>{
            request(server)
            .post('/users/signup')
            .send({username: user, password: "meow1"})
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("status", "Registeration Successful");
                done();
            });
        });
        it("should signup user correctly by speicfying other fields", (done)=>{
            request(server)
            .post('/users/signup')
            .send({username: user+"test", password: "meow1", firstname: "Abdo", lastname: "hany", email: "xx@gmail.com", phoneNumber: "02341749375"})
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("status", "Registeration Successful");
                done();
            });
        });
    });

    describe("Login", ()=>{
        it("should login user using username and password", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: user, password: "meow1"})
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("token");
                token = res.body.token;
                done();
            });
        });

        it("should login users using facebook", (done)=>{
            request(server)
            .get('/users/facebook/token')
            .query({access_token: "EAAMqCKh9cZBQBANmrmmtBriVyw72Dt7gnmHrbBIPGk8q4OFSZAKyAgk4TXlgbjh1FZCNPo3sGmLaaqxoTKjK0cBzY8GYFbVqe4kqc8ME6QGf8Vm3WiUoUwxbs8yC0LKYWBZBoGYRZB2nclkMCM4fVFY6NZBJY4LPtgQ5M0DPXirIeamwSPkZCf8BavkIgJV9ALKsNM8KFTq7HDeaCDTHc932lZCv70OXNldZBnMZAA2vjKvwZDZD"})   // todo: add facebook access token
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("token");
                done();
            });
        });
    });

    describe("Check the validty of JWT", ()=>{
        it("should confirm that token is valid", (done)=>{
            request(server)
            .get("/users/checkJWTToken")
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("status","JWT valid");
                done();
            });
        });
        it("should confirm that token is NOT valid", (done)=>{
            request(server)
            .get("/users/checkJWTToken")
            .set("Authorization", "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmY3YmI1OGU4NTg3NzI3NThjZGQxZjIiLCJpYXQiOjE2MTAwODE1NDksImV4cCI6MTYxMDExNzU0OX0._o5TJV7pXc0W8bZfX2xg63RizdthUYNcfikx4dnIJd1")
            .end((err,res)=>{
                res.should.have.status(401);
                res.body.should.be.a('object');
                res.body.should.have.property("success",false);
                res.body.should.have.property("status","JWT invalid");
                done();
            });
        });
    });

    describe("Logout", ()=>{
        it("should logout user", (done)=>{
            request(server)
            .get('/users/logout')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                done();
            });
        });
    });

    describe("User profile", ()=>{
        it("should get user profile", (done)=>{
            request(server)
            .get('/users/profile')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("profile");
                userId = res.body.profile._id;
                done();
            })
        });

        it("should NOT view the profile of a certain user to other users", (done)=>{
            request(server)
            .get('/users/profile')
            .end((err,res)=>{
                res.should.have.status(401);
                res.body.should.be.a('object');
                res.body.should.have.property("success",false);
                done();
            });
        });

        it("should modify user's profile details", (done)=>{
            request(server)
            .put("/users/profile")
            .set("Authorization", `bearer ${token}`)
            .send({firstname: "mod", lastname: "mod", email: "mod", phoneNumber: "mod"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success",true);
                res.body.should.have.property("profile");
                done();
            })
        });

        it("should upload new profile photo for the user", (done)=>{
            request(server)
            .put('/users/profile/profilePic')
            .set("Authorization", `bearer ${token}`)
            .set('content-type', 'multipart/form-data')
            .attach('profilePic', fs.readFileSync('test/pic.jpg'), 'pic.jpg')
            .end((err,res)=>{
                res.body.should.be.a('object');
                res.should.have.status(200);
                res.body.should.have.property("status", "Profile Pic Updated");
                res.body.should.have.property("success",true);
                done();
            })
        });

        it("should accept ONLY images", (done)=>{
            request(server)
            .put('/users/profile/profilePic')
            .set("Authorization", `bearer ${token}`)
            .set('content-type', 'multipart/form-data')
            .attach('profilePic', fs.readFileSync('test/untitled.m'), 'untitled.m')
            .end((err,res)=>{
                res.should.have.status(500);
                res.body.should.be.a('object');
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Upload Failed");
                res.body.should.have.property("err", "Unsupported Format");
                done();
            })
        });
    });

    describe("Subscribed libraries list", ()=>{
        it("should get user's subscribed libraries", (done)=>{
            request(server)
            .get('/users/myLibraries')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success", true);
                done();
            })
        });

        it("should NOT view the subscribed libraries of a certain user to other users", (done)=>{
            request(server)
            .get('/users/myLibraries')
            .end((err,res)=>{
                res.should.have.status(401);
                res.body.should.be.a('object');
                res.body.should.have.property("success", false);
                done();
            })
        });
    });

    describe("Favorites list", ()=>{
        it("should get user's favorites list", (done)=>{
            request(server)
            .get('/users/favorites')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success", true);
                done();
            });
        });

        it("should NOT view the favorites list of a certain user to other users", (done)=>{
            request(server)
            .get('/users/favorites')
            .end((err,res)=>{
                res.should.have.status(401);
                res.body.should.be.a('object');
                res.body.should.have.property("success", false);
                done();
            });
        });

        it("should add a certain item to the user's favorites list", (done)=>{
            request(server)
            .post('/users/favorites')
            .set("Authorization", `bearer ${token}`)
            .send({_id:"5ff7e5c246f9159e445c50b7", library:"5fd53f880f2d076ac295de1d"})     // todo add suitible item id and libraryId
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success", true);
                done();
            })
        });

        it("should NOT allow other users to add a certain item to the user's favorites list", (done)=>{
            request(server)
            .post('/users/favorites')
            .send({_id:"5ff7e5c246f9159e445c50b7", library:"5fd53f880f2d076ac295de1d"})     // todo add suitible item id and libraryId
            .end((err, res)=>{
                res.should.have.status(401);
                res.body.should.be.a('object');
                res.body.should.have.property("success", false);
                done();
            })
        });

        it("should delete a certain item in the user's favorites list", (done)=>{
            request(server)
            .put('/users/favorites')
            .set("Authorization", `bearer ${token}`)
            .send({_id:"5ff7e5c246f9159e445c50b7", library:"5fd53f880f2d076ac295de1d"})     
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.be.a('object');
                res.body.should.have.property("success", true);
                done();
            })
        });

        it("should NOT allow other users to delete a certain item in the user's favorites list", (done)=>{
            request(server)
            .put('/users/favorites')
            .send({_id:"5ff7e5c246f9159e445c50b7", library:"5fd53f880f2d076ac295de1d"}) 
            .end((err, res)=>{
                res.should.have.status(401);
                res.body.should.be.a('object');
                res.body.should.have.property("success", false);
                done();
            })
        });
    });
});


//---------------------------------------------------------------------------------


describe("Search API Tests", ()=>{
    it("should return error if the user searches for space character", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:" "})
        .end((err,res)=>{
            res.should.have.status(404);
            res.body.should.have.property("success", false);
            done();
        });
    });

    it("should search for an item by name", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:"x", by:"name"})
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("items");
            res.body.items.should.be.a('array');
            done();
        });
    });

    it("should search for an item by genre", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:"x", by:"genre"})
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("items");
            res.body.items.should.be.a('array');
            done();
        });
    });

    it("should search for an item by author", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:"x", by:"author"})
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("items");
            res.body.items.should.be.a('array');
            done();
        });
    });

    it("should search for an item by type", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:"x", by:"type"})
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("items");
            res.body.items.should.be.a('array');
            done();
        });
    });

    it("should search for an item by language", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:"x", by:"language"})
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("items");
            res.body.items.should.be.a('array');
            done();
        });
    });

    it("should search for an item by ISBN", (done)=>{
        request(server)
        .get('/search')
        .set("Authorization", `bearer ${token}`)
        .query({filter:"x", by:"ISBN"})
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("items");
            res.body.items.should.be.a('array');
            done();
        });
    });

});


//---------------------------------------------------------------------------------------


describe("Stats report API Tests", ()=>{
    describe("Get registered users", ()=>{
        it("should return all registered users in the system for admins ONLY", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "librarian1", password: "meow1"})
            .end((err,res)=>{
                adminToken = res.body.token;
                request(server)
                .get('/stats/users')
                .set('Authorization', `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("users");
                    res.body.users.should.be.a('array');
                    done();
                });
            });
            
        });

        it("should revoke access for non-admins", (done)=>{
            request(server)
            .get('/stats/users')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("Get statistical info about library 1", ()=>{
        it("should return the total number of items and the latest five additions in library1", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "librarian1", password: "meow1"})
            .end((err,res)=>{
                adminToken = res.body.token;
                request(server)
                .get('/stats/libraries/lib1')
                .set('Authorization', `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("num");
                    res.body.should.have.property("latest1");
                    done();
                });
            });
        });

        it("should revoke access for non-admins", (done)=>{
            request(server)
            .get('/stats/libraries/lib1')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("Get statistical info about library 2", ()=>{
        it("should return the total number of items and the latest five additions in library2", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "librarian1", password: "meow1"})
            .end((err,res)=>{
                adminToken = res.body.token;
                request(server)
                .get('/stats/libraries/lib2')
                .set('Authorization', `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("num");
                    res.body.should.have.property("latest2");
                    done();
                });
            });
        });

        it("should revoke access for non-admins", (done)=>{
            request(server)
            .get('/stats/libraries/lib2')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("Get statistical info about library 3", ()=>{
        it("should return the total number of items and the latest five additions in library3", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "librarian1", password: "meow1"})
            .end((err,res)=>{
                adminToken = res.body.token;
                request(server)
                .get('/stats/libraries/lib3')
                .set('Authorization', `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("num");
                    res.body.should.have.property("latest3");
                    done();
                });
            });
        });

        it("should revoke access for non-admins", (done)=>{
            request(server)
            .get('/stats/libraries/lib3')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });
});


//-------------------------------------------------------------------------------------------------


describe("Libraries API Tests", ()=>{
    describe("View all libraries", ()=>{
        it("should get all libraries", (done)=>{
            request(server)
            .get('/libraries')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("libraries");
                done();
            });
        });
    });

    describe("View info of a certain library", ()=>{
        it("should view info of a certain library (lib1) given its ID", (done)=>{
            request(server)
            .get('/libraries/5fd53f880f2d076ac295de1d/info')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("library");
                res.body.should.have.property("librarian");
                done();
            })
        });
    });

    describe("Modify info of a certain library", ()=>{
        it("should modify the info of the library (lib1) if the request owner is the librarian", (done)=>{
            request(server)
                .put('/libraries/5fd53f880f2d076ac295de1d/info')
                .send({name: "mod1", address: "modAddr", description: "moddes", phoneNumber: "0223232"})
                .set('Authorization', `bearer ${adminToken}`)
                .end((err, res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("library");
                    done();
                })
        });

        it("should NOT modify the the info of the library (lib1) if the request owner is NOT the librarian", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "librarian2", password: "meow1"})
            .end((err, res)=>{
                admin2Token = res.body.token;
                request(server)
                .put('/libraries/5fd53f880f2d076ac295de1d/info')
                .send({name: "mod1", address: "modAddr", description: "moddes", phoneNumber: "0223232"})
                .set('Authorization', `bearer ${admin2Token}`)
                .end((err, res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    res.body.should.have.property("err", "You Are Not A Librarian In This Library");
                    done();
                })
            })
        });

        it("should modify the info of the library (lib2) if the request owner is the librarian", (done)=>{
            request(server)
                .put('/libraries/5fd53f8e0f2d076ac295de1e/info')
                .send({name: "mod1", address: "modAddr", description: "moddes", phoneNumber: "0223232"})
                .set('Authorization', `bearer ${admin2Token}`)
                .end((err, res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("library");
                    done();
                })
        });

        it("should NOT modify the the info of the library (lib2) if the request owner is NOT the librarian", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "librarian3", password: "meow1"})
            .end((err, res)=>{
                admin3Token = res.body.token;
                request(server)
                .put('/libraries/5fd53f8e0f2d076ac295de1e/info')
                .send({name: "mod1", address: "modAddr", description: "moddes", phoneNumber: "0223232"})
                .set('Authorization', `bearer ${admin3Token}`)
                .end((err, res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    res.body.should.have.property("err", "You Are Not A Librarian In This Library");
                    done();
                })
            })
        });

        it("should modify the info of the library (lib3) if the request owner is the librarian", (done)=>{
            request(server)
                .put('/libraries/5fd53f910f2d076ac295de1f/info')
                .send({name: "mod1", address: "modAddr", description: "moddes", phoneNumber: "0223232"})
                .set('Authorization', `bearer ${admin3Token}`)
                .end((err, res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("library");
                    done();
                })
        });

        it("should NOT modify the the info of the library (lib3) if the request owner is NOT the librarian", (done)=>{
            request(server)
                .put('/libraries/5fd53f910f2d076ac295de1f/info')
                .send({name: "mod1", address: "modAddr", description: "moddes", phoneNumber: "0223232"})
                .set('Authorization', `bearer ${admin2Token}`)
                .end((err, res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    res.body.should.have.property("err", "You Are Not A Librarian In This Library");
                    done();
                })
        });
    });

    describe("Get the list of members and the list of join requests for a certain library", ()=>{
        it("should return all join requests to library 1 if the request owner is the librarian", (done)=>{
        request(server)
            .get('/libraries/5fd53f880f2d076ac295de1d')
            .query({option: "requests"})
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                done();
            });
        });
        it("should return all join requests to library 2 if the request owner is the librarian", (done)=>{
            request(server)
            .get('/libraries/5fd53f8e0f2d076ac295de1e')
            .query({option: "requests"})
            .set("Authorization", `bearer ${admin2Token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                done();
            });
        });
        it("should return all join requests to library 3 if the request owner is the librarian", (done)=>{
            request(server)
            .get('/libraries/5fd53f910f2d076ac295de1f')
            .query({option: "requests"})
            .set("Authorization", `bearer ${admin3Token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                done();
            });
        });

        it("should NOT return all join requests to library 1 if the request owner is NOT the librarian", (done)=>{
            request(server)
            .get('/libraries/5fd53f880f2d076ac295de1d')
            .query({option: "requests"})
            .set("Authorization", `bearer ${admin2Token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
        it("should NOT return all join requests to library 2 if the request owner is NOT the librarian", (done)=>{
            request(server)
            .get('/libraries/5fd53f8e0f2d076ac295de1e')
            .query({option: "requests"})
            .set("Authorization", `bearer ${admin3Token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
        it("should NOT return all join requests to library 3 if the request owner is NOT the librarian", (done)=>{
            request(server)
            .get('/libraries/5fd53f910f2d076ac295de1f')
            .query({option: "requests"})
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
        //------------------------------------------
        it("should return all Members in library 1 if the request owner is the librarian", (done)=>{
            request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d')
                .query({option: "members"})
                .set("Authorization", `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("members");
                    done();
                });
            });
            it("should return all members in library 2 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e')
                .query({option: "members"})
                .set("Authorization", `bearer ${admin2Token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("members");
                    done();
                });
            });
            it("should return all members in library 3 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f')
                .query({option: "members"})
                .set("Authorization", `bearer ${admin3Token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("members");
                    done();
                });
            });
    
            it("should NOT return all members in library 1 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d')
                .query({option: "members"})
                .set("Authorization", `bearer ${admin2Token}`)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });
            it("should NOT return all members in library 2 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e')
                .query({option: "members"})
                .set("Authorization", `bearer ${admin3Token}`)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });
            it("should NOT return all members in library 3 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f')
                .query({option: "members"})
                .set("Authorization", `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });
    });

    //---------------------------------------------


    describe("User sends a join request to a certain library", ()=>{
        it("should send a join request to library 1", (done)=>{
            request(server)
            .post('/libraries/5fd53f880f2d076ac295de1d/requests')
            .set("Authorization", `bearer ${token}`)
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "Join Request Sent");
                done();
            });
        });

        it("should send a join request to library 2", (done)=>{
            request(server)
            .post('/libraries/5fd53f8e0f2d076ac295de1e/requests')
            .set("Authorization", `bearer ${token}`)
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "Join Request Sent");
                done();
            });
        });

        it("should send a join request to library 3", (done)=>{
            request(server)
            .post('/libraries/5fd53f910f2d076ac295de1f/requests')
            .set("Authorization", `bearer ${token}`)
            .end((err, res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "Join Request Sent");
                done();
            });
        });
    });


    //---------------------------------------------
    
    describe("Accept incoming join requests", ()=>{
        it("should accept the incoming join request of a certain user to library 1", (done)=>{
            request(server)
            .put(`/libraries/5fd53f880f2d076ac295de1d/${userId}`)
            .set("Authorization", `bearer ${adminToken}`)
            .query({action: "approve"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "Request Approved Successfuly");
                done();
            });
        });

        it("should accept the incoming join request of a certain user to library 2", (done)=>{
            request(server)
            .put(`/libraries/5fd53f8e0f2d076ac295de1e/${userId}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .query({action: "approve"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "Request Approved Successfuly");
                done();
            });
        });

        it("should accept the incoming join request of a certain user to library 3", (done)=>{
            request(server)
            .put(`/libraries/5fd53f910f2d076ac295de1f/${userId}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .query({action: "approve"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "Request Approved Successfuly");
                done();
            });
        });
        it("should NOT allow the request owner to accept the incoming join request of a certain user to library 1", (done)=>{
            request(server)
            .put(`/libraries/5fd53f880f2d076ac295de1d/${userId}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .query({action: "approve"})
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });

        it("should NOT allow the request owner to accept the incoming join request of a certain user to library 2", (done)=>{
            request(server)
            .put(`/libraries/5fd53f8e0f2d076ac295de1e/${userId}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .query({action: "approve"})
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });

        it("should NOT allow the request owner to accept the incoming join request of a certain user to library 3", (done)=>{
            request(server)
            .put(`/libraries/5fd53f910f2d076ac295de1f/${userId}`)
            .set("Authorization", `bearer ${adminToken}`)
            .query({action: "approve"})
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });


    //---------------------------------
    
    
    describe("Feedbacks", ()=>{
        describe("Send feedbacks", ()=>{
            it("should send feedback to library 1", (done)=>{
                request(server)
                .post('/libraries/5fd53f880f2d076ac295de1d/feedback')
                .set("Authorization", `bearer ${token}`)
                .send({feedback: "Test Feedback"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Feedback Sent Successfully");
                    done();
                });
            });
    
            it("should send feedback to library 2", (done)=>{
                request(server)
                .post('/libraries/5fd53f8e0f2d076ac295de1e/feedback')
                .set("Authorization", `bearer ${token}`)
                .send({feedback: "Test Feedback"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Feedback Sent Successfully");
                    done();
                });
            });
    
            it("should send feedback to library 3", (done)=>{
                request(server)
                .post('/libraries/5fd53f910f2d076ac295de1f/feedback')
                .set("Authorization", `bearer ${token}`)
                .send({feedback: "Test Feedback"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Feedback Sent Successfully");
                    done();
                });
            });
        });

        describe("Receive feedbacks", ()=>{
            it("should view feedbacks for library 1 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d/feedback')
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("feedbacks");
                    done();
                });
            });

            it("should view feedbacks for library 2 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e/feedback')
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("feedbacks");
                    done();
                });
            });

            it("should view feedbacks for library 3 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f/feedback')
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("feedbacks");
                    done();
                });
            });
        });
    });


    //----------------------------------------------------------------------


    describe("Permissions", ()=>{
        describe("Get permissions", ()=>{
            it("should get all blocked users from borrowing items in library 1 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d/permissions/get')
                .set("Authorization", `bearer ${adminToken}`)
                .query({blockedFrom: "borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("blockedUsers");
                    done();
                })
            });

            it("should get all blocked users from borrowing items in library 2 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e/permissions/get')
                .set("Authorization", `bearer ${admin2Token}`)
                .query({blockedFrom: "borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("blockedUsers");
                    done();
                })
            });

            it("should get all blocked users from borrowing items in library 3 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f/permissions/get')
                .set("Authorization", `bearer ${admin3Token}`)
                .query({blockedFrom: "borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("blockedUsers");
                    done();
                })
            });

            // ---------

            it("should NOT get all blocked users from borrowing items in library 1 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d/permissions/get')
                .set("Authorization", `bearer ${token}`)
                .query({blockedFrom: "borrowing"})
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                })
            });

            it("should NOT get all blocked users from borrowing items in library 2 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e/permissions/get')
                .set("Authorization", `bearer ${token}`)
                .query({blockedFrom: "borrowing"})
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                })
            });

            it("should NOT get all blocked users from borrowing items in library 3 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f/permissions/get')
                .set("Authorization", `bearer ${token}`)
                .query({blockedFrom: "borrowing"})
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                })
            });

            //----------------------------------------------------eval

            it("should get all blocked users from evaluating items in library 1 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d/permissions/get')
                .set("Authorization", `bearer ${adminToken}`)
                .query({blockedFrom: "evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("blockedUsers");
                    done();
                })
            });

            it("should get all blocked users from evaluating items in library 2 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e/permissions/get')
                .set("Authorization", `bearer ${admin2Token}`)
                .query({blockedFrom: "evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("blockedUsers");
                    done();
                })
            });

            it("should get all blocked users from evaluating items in library 3 if the request owner is the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f/permissions/get')
                .set("Authorization", `bearer ${admin3Token}`)
                .query({blockedFrom: "evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("blockedUsers");
                    done();
                })
            });

            // ---------

            it("should NOT get all blocked users from evaluating items in library 1 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f880f2d076ac295de1d/permissions/get')
                .set("Authorization", `bearer ${token}`)
                .query({blockedFrom: "evaluating"})
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                })
            });

            it("should NOT get all blocked users from evaluating items in library 2 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f8e0f2d076ac295de1e/permissions/get')
                .set("Authorization", `bearer ${token}`)
                .query({blockedFrom: "evaluating"})
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                })
            });

            it("should NOT get all blocked users from evaluating items in library 3 if the request owner is NOT the librarian", (done)=>{
                request(server)
                .get('/libraries/5fd53f910f2d076ac295de1f/permissions/get')
                .set("Authorization", `bearer ${token}`)
                .query({blockedFrom: "evaluating"})
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                })
            });
        });

        describe("Set permissions", ()=>{
            it("should block a certain user from borrowing items in library 1", (done)=>{
                request(server)
                .put(`/libraries/5fd53f880f2d076ac295de1d/permissions/${userId}/set`)
                .set("Authorization", `bearer ${adminToken}`)
                .query({action: "block", from:"borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should block a certain user from evaluating items in library 1", (done)=>{
                request(server)
                .put(`/libraries/5fd53f880f2d076ac295de1d/permissions/${userId}/set`)
                .set("Authorization", `bearer ${adminToken}`)
                .query({action: "block", from:"evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should unblock a certain user from borrowing items in library 1", (done)=>{
                request(server)
                .put(`/libraries/5fd53f880f2d076ac295de1d/permissions/${userId}/set`)
                .set("Authorization", `bearer ${adminToken}`)
                .query({action: "unblock", from:"borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should unblock a certain user from evaluating items in library 1", (done)=>{
                request(server)
                .put(`/libraries/5fd53f880f2d076ac295de1d/permissions/${userId}/set`)
                .set("Authorization", `bearer ${adminToken}`)
                .query({action: "unblock", from:"evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            // -------------------

            it("should block a certain user from borrowing items in library 2", (done)=>{
                request(server)
                .put(`/libraries/5fd53f8e0f2d076ac295de1e/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin2Token}`)
                .query({action: "block", from:"borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should block a certain user from evaluating items in library 2", (done)=>{
                request(server)
                .put(`/libraries/5fd53f8e0f2d076ac295de1e/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin2Token}`)
                .query({action: "block", from:"evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should unblock a certain user from borrowing items in library 2", (done)=>{
                request(server)
                .put(`/libraries/5fd53f8e0f2d076ac295de1e/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin2Token}`)
                .query({action: "unblock", from:"borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should unblock a certain user from evaluating items in library 2", (done)=>{
                request(server)
                .put(`/libraries/5fd53f8e0f2d076ac295de1e/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin2Token}`)
                .query({action: "unblock", from:"evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            // -----------------------------

            it("should block a certain user from borrowing items in library 3", (done)=>{
                request(server)
                .put(`/libraries/5fd53f910f2d076ac295de1f/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin3Token}`)
                .query({action: "block", from:"borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should block a certain user from evaluating items in library 3", (done)=>{
                request(server)
                .put(`/libraries/5fd53f910f2d076ac295de1f/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin3Token}`)
                .query({action: "block", from:"evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should unblock a certain user from borrowing items in library 3", (done)=>{
                request(server)
                .put(`/libraries/5fd53f910f2d076ac295de1f/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin3Token}`)
                .query({action: "unblock", from:"borrowing"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            it("should unblock a certain user from evaluating items in library 3", (done)=>{
                request(server)
                .put(`/libraries/5fd53f910f2d076ac295de1f/permissions/${userId}/set`)
                .set("Authorization", `bearer ${admin3Token}`)
                .query({action: "unblock", from:"evaluating"})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("user");
                    done();
                });
            });

            
        });
    });


    describe("Working with items", ()=>{
        describe("Adding a new item", ()=>{
            it("should add an item to library 1", (done)=>{
                request(server)
                .post(`/libraries/${library1Id}/items`)
                .set("Authorization", `bearer ${adminToken}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Item Added Successfully");
                    done();
                });
            });

            it("should add an item to library 2", (done)=>{
                request(server)
                .post(`/libraries/${library2Id}/items`)
                .set("Authorization", `bearer ${admin2Token}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Item Added Successfully");
                    done();
                });
            });

            it("should add an item to library 3", (done)=>{
                request(server)
                .post(`/libraries/${library3Id}/items`)
                .set("Authorization", `bearer ${admin3Token}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Item Added Successfully");
                    done();
                });
            });
        });

        describe("Adding an existing item", ()=>{
            it("should NOT add the item to library 1", (done)=>{
                request(server)
                .post(`/libraries/${library1Id}/items`)
                .set("Authorization", `bearer ${adminToken}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Process Failed");
                    res.body.should.have.property("err", "This Item Already Exists In This Library");
                    done();
                });
            });

            it("should NOT add the item to library 2", (done)=>{
                request(server)
                .post(`/libraries/${library2Id}/items`)
                .set("Authorization", `bearer ${admin2Token}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Process Failed");
                    res.body.should.have.property("err", "This Item Already Exists In This Library");
                    done();
                });
            });

            it("should NOT add the item to library 3", (done)=>{
                request(server)
                .post(`/libraries/${library3Id}/items`)
                .set("Authorization", `bearer ${admin3Token}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Process Failed");
                    res.body.should.have.property("err", "This Item Already Exists In This Library");
                    done();
                });
            });
        });

        describe("Adding items by non-librarian of the respective library", ()=>{
            it("should NOT add the item to library 1", (done)=>{
                request(server)
                .post(`/libraries/${library1Id}/items`)
                .set("Authorization", `bearer ${admin2Token}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });

            it("should NOT add the item to library 2", (done)=>{
                request(server)
                .post(`/libraries/${library2Id}/items`)
                .set("Authorization", `bearer ${admin3Token}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });

            it("should NOT add the item to library 3", (done)=>{
                request(server)
                .post(`/libraries/${library3Id}/items`)
                .set("Authorization", `bearer ${adminToken}`)
                .send(item)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });
        });

        describe("Get all items in a certain library", ()=>{
            it("should get all items in library 1", (done)=>{
                request(server)
                .get(`/libraries/${library1Id}/items`)
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("num");
                    res.body.should.have.property("items");
                    itemId = res.body.items[2]._id;
                    done();
                });
            });

            it("should get all items in library 2", (done)=>{
                request(server)
                .get(`/libraries/${library2Id}/items`)
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("num");
                    res.body.should.have.property("items");
                    done();
                });
            });

            it("should get all items in library 3", (done)=>{
                request(server)
                .get(`/libraries/${library3Id}/items`)
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("num");
                    res.body.should.have.property("items");
                    done();
                });
            });
        });

        describe("Get info about a certain item in a certain library", ()=>{
            it("should get the info of the item from library 1", (done)=>{
                request(server)
                .get(`/libraries/${library1Id}/items/${itemId}`)
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("item");
                    done();
                });
            });

            it("should get the info of the item from library 2", (done)=>{
                request(server)
                .get(`/libraries/${library2Id}/items/${itemId}`)
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("item");
                    done();
                });
            });

            it("should get the info of the item from library 3", (done)=>{
                request(server)
                .get(`/libraries/${library3Id}/items/${itemId}`)
                .set("Authorization", `bearer ${token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("item");
                    done();
                });
            });
        });

        describe("Modify the info of a certain item in a certain library", ()=>{
            it("should modify the item in library 1", (done)=>{
                request(server)
                .put(`/libraries/${library1Id}/items/${itemId}`)
                .set("Authorization", `bearer ${adminToken}`)
                .send(itemMod)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true); 
                    res.body.should.have.property("status", "Item Modified Successfully");
                    res.body.should.have.property("modifiedItem");
                    done();
                });
            });

            it("should modify the item in library 2", (done)=>{
                request(server)
                .put(`/libraries/${library2Id}/items/${itemId}`)
                .set("Authorization", `bearer ${admin2Token}`)
                .send(itemMod)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true); 
                    res.body.should.have.property("status", "Item Modified Successfully");
                    res.body.should.have.property("modifiedItem");
                    done();
                });
            });

            it("should modify the item in library 3", (done)=>{
                request(server)
                .put(`/libraries/${library3Id}/items/${itemId}`)
                .set("Authorization", `bearer ${admin3Token}`)
                .send(itemMod)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true); 
                    res.body.should.have.property("status", "Item Modified Successfully");
                    res.body.should.have.property("modifiedItem");
                    done();
                });
            });
        });

        describe("Modify an item by non-librarian of the respective library", ()=>{
            it("should NOT modify the item in library 1", (done)=>{
                request(server)
                .put(`/libraries/${library1Id}/items`)
                .set("Authorization", `bearer ${admin3Token}`)
                .send(itemMod)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });

            it("should NOT modify the item in library 2", (done)=>{
                request(server)
                .put(`/libraries/${library2Id}/items`)
                .set("Authorization", `bearer ${admin3Token}`)
                .send(itemMod)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });

            it("should NOT modify the item in library 3", (done)=>{
                request(server)
                .put(`/libraries/${library3Id}/items`)
                .set("Authorization", `bearer ${admin2Token}`)
                .send(itemMod)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });
        });


        describe("Review an item", ()=>{
            it("should review an item from library 1", (done)=>{
                request(server)
                .post(`/libraries/${library1Id}/items/${itemId}/reviews`)
                .set("Authorization", `bearer ${token}`)
                .send({rating: rating, review: review})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Review Posted Successfully");
                    done();
                });
            });

            it("should review an item from library 2", (done)=>{
                request(server)
                .post(`/libraries/${library2Id}/items/${itemId}/reviews`)
                .set("Authorization", `bearer ${token}`)
                .send({rating: rating, review: review})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Review Posted Successfully");
                    done();
                });
            });

            it("should review an item from library 3", (done)=>{
                request(server)
                .post(`/libraries/${library3Id}/items/${itemId}/reviews`)
                .set("Authorization", `bearer ${token}`)
                .send({rating: rating, review: review})
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true);
                    res.body.should.have.property("status", "Review Posted Successfully");
                    done();
                });
            });
        });

        describe("Delete a certain item in a certain library", ()=>{
            it("should delete the item in library 1", (done)=>{
                request(server)
                .delete(`/libraries/${library1Id}/items/${itemId}`)
                .set("Authorization", `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true); 
                    res.body.should.have.property("status", "Item Deleted Successfully");
                    done();
                });
            });

            it("should delete the item in library 2", (done)=>{
                request(server)
                .delete(`/libraries/${library2Id}/items/${itemId}`)
                .set("Authorization", `bearer ${admin2Token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true); 
                    res.body.should.have.property("status", "Item Deleted Successfully");
                    done();
                });
            });

            it("should delete the item in library 3", (done)=>{
                request(server)
                .delete(`/libraries/${library3Id}/items/${itemId}`)
                .set("Authorization", `bearer ${admin3Token}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("success", true); 
                    res.body.should.have.property("status", "Item Deleted Successfully");
                    done();
                });
            });
        });

        describe("Delete an item by non-librarian of the respective library", ()=>{
            it("should NOT delete the item from library 1", (done)=>{
                request(server)
                .delete(`/libraries/${library1Id}/items/${itemId}`)
                .set("Authorization", `bearer ${admin2Token}`)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });

            it("should NOT delete the item from library 2", (done)=>{
                request(server)
                .delete(`/libraries/${library2Id}/items/${itemId}`)
                .set("Authorization", `bearer ${admin3Token}`)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });

            it("should NOT delete the item from library 3", (done)=>{
                request(server)
                .delete(`/libraries/${library3Id}/items/${itemId}`)
                .set("Authorization", `bearer ${adminToken}`)
                .end((err,res)=>{
                    res.should.have.status(403);
                    res.body.should.have.property("success", false);
                    res.body.should.have.property("status", "Access Denied");
                    done();
                });
            });
        });
    });

    describe("Reject Incoming join request or delete the user from the library if he is a member", ()=>{
        it("should reject the incoming join request of a certain user to library 1 or delete him if he exists", (done)=>{
            request(server)
            .put(`/libraries/5fd53f880f2d076ac295de1d/${userId}`)
            .set("Authorization", `bearer ${adminToken}`)
            .query({action: "reject"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "User Rejected Successfuly");
                done();
            });
        });

        it("should reject the incoming join request of a certain user to library 2 or delete him if he exists", (done)=>{
            request(server)
            .put(`/libraries/5fd53f8e0f2d076ac295de1e/${userId}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .query({action: "reject"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "User Rejected Successfuly");
                done();
            });
        });

        it("should reject the incoming join request of a certain user to library 3 or delete him if he exists", (done)=>{
            request(server)
            .put(`/libraries/5fd53f910f2d076ac295de1f/${userId}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .query({action: "reject"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status", "User Rejected Successfuly");
                done();
            });
        });
        it("should NOT allow the request owner to reject the incoming join request of a certain user to library 1 nor delete him if he exists", (done)=>{
            request(server)
            .put(`/libraries/5fd53f880f2d076ac295de1d/${userId}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .query({action: "reject"})
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });

        it("should NOT allow the request owner to reject the incoming join request of a certain user to library 2 nor delete him if he exists", (done)=>{
            request(server)
            .put(`/libraries/5fd53f8e0f2d076ac295de1e/${userId}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .query({action: "reject"})
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });

        it("should NOT allow the request owner to reject the incoming join request of a certain user to library 3 nor delete him if he exists", (done)=>{
            request(server)
            .put(`/libraries/5fd53f910f2d076ac295de1f/${userId}`)
            .set("Authorization", `bearer ${adminToken}`)
            .query({action: "reject"})
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });
    
});

describe("Borrow requests", ()=>{
    describe("User sends borrow requests", ()=>{
        it("should send a borrow request to library 1 in order to borrow a physical item (book, magazine, audioMaterial)", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library1Id}/${myItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("status", "Requested Successfully");
                    done();
                });
            });
        });

        it("should send a borrow request to library 2 in order to borrow a physical item (book, magazine, audioMaterial)", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library2Id}/${myItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("status", "Requested Successfully");
                    done();
                });
            });
        });

        it("should send a borrow request to library 3 in order to borrow a physical item (book, magazine, audioMaterial)", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library3Id}/${myItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("status", "Requested Successfully");
                    done();
                });
            });
        });
    
        it("should borrow a non-physical item (ebook, article) from library 1", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library1Id}/${myNonItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("status", "Borrowed Successfully");
                    done();
                });
            });
        });

        it("should borrow a non-physical item (ebook, article) from library 2", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library2Id}/${myNonItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("status", "Borrowed Successfully");
                    done();
                });
            });
        });

        it("should borrow a non-physical item (ebook, article) from library 3", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library3Id}/${myNonItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    res.should.have.status(200);
                    res.body.should.have.property("status", "Borrowed Successfully");
                    done();
                });
            });
        });
    
        it("should NOT make the borrow request for the user if (the number of borrow requests + number of borrowed but not returned items) equal to the maximum allowed borrowings from any library", (done)=>{
            request(server)
            .post('/users/login')
            .send({username: "member", password: "meow1"})
            .end((err, res)=>{
                memToken = res.body.token;
                request(server)
                .post(`/borrowRequests/request/${library1Id}/${myItemId}`)
                .set("Authorization", `bearer ${memToken}`)
                .end((err,res)=>{
                    request(server)
                    .post(`/borrowRequests/request/${library2Id}/${myItemId}`)
                    .set("Authorization", `bearer ${memToken}`)
                    .end((err, res)=>{
                        request(server)
                        .post(`/borrowRequests/request/${library3Id}/${myItemId}`)
                        .set("Authorization", `bearer ${memToken}`)
                        .end((err, res)=>{
                            request(server)
                            .post(`/borrowRequests/request/${library1Id}/${myItemId}`)
                            .set("Authorization", `bearer ${memToken}`)
                            .end((err, res)=>{
                                res.should.have.status(403);
                                res.body.should.have.property("success", false);
                                res.body.should.have.property("status", "Request Failed");
                                res.body.should.have.property("err", "Limit Reached");
                                done();
                            });
                        });
                    });
                });
            });
        });
    });

    describe("Librarian gets all borrow requests from his/her library", ()=>{
        it("should get all borrow requests from library 1", (done)=>{
            request(server)
            .get(`/borrowRequests/libraryRequests/${library1Id}`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                bReq1Id = res.body.requests[0]._id;
                done();
            });
        });

        it("should get all borrow requests from library 2", (done)=>{
            request(server)
            .get(`/borrowRequests/libraryRequests/${library2Id}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                bReq2Id = res.body.requests[0]._id;
                done();
            });
        });

        it("should get all borrow requests from library 3", (done)=>{
            request(server)
            .get(`/borrowRequests/libraryRequests/${library3Id}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                bReq3Id = res.body.requests[0]._id;
                done();
            });
        });

        it("should NOT get borrow requests from library 1 when the request owner is not the librarian", (done)=>{
            request(server)
            .get(`/borrowRequests/libraryRequests/${library1Id}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });

        it("should NOT get borrow requests from library 2 when the request owner is not the librarian", (done)=>{
            request(server)
            .get(`/borrowRequests/libraryRequests/${library2Id}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });

        it("should NOT get borrow requests from library 3 when the request owner is not the librarian", (done)=>{
            request(server)
            .get(`/borrowRequests/libraryRequests/${library3Id}`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("User gets all his/her pending borrow requests", ()=>{
        it("should get all pending borrow requests for the request owner", (done)=>{
            request(server)
            .get('/borrowRequests/myRequests')
            .set("Authorization", `bearer ${token}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("requests");
                done();
            });
        });
    });

    describe("Librarian accepts a borrow request in his/her library", ()=>{
        it("should accept the borrow request in library 1 if the request owner is the librarian", (done)=>{
            request(server)
            .put(`/borrowRequests/accept/${library1Id}/${bReq1Id}`)
            .set("Authorization", `bearer ${adminToken}`)
            .end(async(err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status","Accepted Successfully");
                await PhysicalBorrowRequests.deleteOne({_id: bReq1Id});
                done();
            });
        });

        it("should accept the borrow request in library 2 if the request owner is the librarian", (done)=>{
            request(server)
            .put(`/borrowRequests/accept/${library2Id}/${bReq2Id}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .end(async(err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status","Accepted Successfully");
                await PhysicalBorrowRequests.deleteOne({_id: bReq2Id});
                done();
            });
        });

        it("should accept the borrow request in library 3 if the request owner is the librarian", (done)=>{
            request(server)
            .put(`/borrowRequests/accept/${library3Id}/${bReq3Id}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .end(async(err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status","Accepted Successfully");
                await PhysicalBorrowRequests.deleteOne({_id: bReq3Id});
                done();
            });
        });

        it("should NOT accept the borrow request in library 1 if the request owner is NOT the librarian", (done)=>{
            request(server)
            .put(`/borrowRequests/accept/${library1Id}/${bReq1Id}`)
            .set("Authorization", `bearer ${admin2Token}`)
            .end(async(err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status","Access Denied");
                await PhysicalBorrowRequests.deleteOne({_id: bReq1Id});
                done();
            });
        });

        it("should NOT accept the borrow request in library 2 if the request owner is NOT the librarian", (done)=>{
            request(server)
            .put(`/borrowRequests/accept/${library2Id}/${bReq2Id}`)
            .set("Authorization", `bearer ${admin3Token}`)
            .end(async(err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status","Access Denied");
                await PhysicalBorrowRequests.deleteOne({_id: bReq2Id});
                done();
            });
        });

        it("should NOT accept the borrow request in library 3 if the request owner is NOT the librarian", (done)=>{
            request(server)
            .put(`/borrowRequests/accept/${library3Id}/${bReq3Id}`)
            .set("Authorization", `bearer ${adminToken}`)
            .end(async(err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status","Access Denied");
                await PhysicalBorrowRequests.deleteOne({_id: bReq3Id});
                done();
            });
        });

        afterEach(async()=>{
            await Transaction.deleteMany({});
        });
    });
});


describe("Working with transactions", ()=>{
    describe("User gets all of his/her transactions", ()=>{
        it("should get all user's transactions", (done)=>{
            request(server)
            .get(`/transactions/myTransactions`)
            .set("Authorization", `bearer ${token}`)
            .query({requestedToReturn: "null"})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("bRequests"); 
                res.body.should.have.property("transactions");
                done();
            });
        });
    });

    describe("User gets all of his/her returnings", ()=>{
        it("should get all user's returnings", (done)=>{
            request(server)
            .get(`/transactions/myTransactions`)
            .set("Authorization", `bearer ${token}`)
            .query({requestedToReturn: true})
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("transactions");
                done();
            });
        });
    });

    describe("User gets information about a specific transaction", ()=>{

        beforeEach(async()=>{
           await Transaction.create({"_id":"5ffb09fa1fc3602ec41d8bf2","user":"5ff86dbc85361e52dc5ba279", "borrowedFrom": "5fd53f880f2d076ac295de1d", "item":"5ff7e5c246f9159e445c50b7", "returnedTo":"5fd53f8e0f2d076ac295de1e", "lateFees": 5, "requestedToReturn": false, "returned": true, "hasFees": true});
        });

        it("should get info about a specific transaction of his/her", (done)=>{
            request(server)
            .get(`/transactions/transaction/${transactionId}`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("transaction");
                done();
            });
        })
    });   


    describe("User gets all his/her borrowed items", ()=>{
        it("should get user's borrowed items", (done)=>{
            request(server)
            .get(`/transactions/borrowed`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("borrowedItems");
                done();
            });
        });
    });

    describe("Admin gets all transactions in the system",()=>{
        it("should get all transactions", (done)=>{
            request(server)
            .get(`/transactions/allTransactions`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("transactions");
                done();
            });
        });

        it("should NOT get all transactions if the request owner is NOT a librarian", (done)=>{
            request(server)
            .get(`/transactions/allTransactions`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("User sends a return request to return a physical item", ()=>{
        it("should send a return request", (done)=>{
            request(server)
            .put(`/transactions/requestToReturn/${transactionId}`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status","Transaction Requested To Return");
                done();
            });
        });
    });

    describe("Librarian accepts a specific return request", ()=>{
        it("should accept the return request if the request owner is a librarian", (done)=>{
            request(server)
            .put(`/transactions/recive/${transactionId}`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("status","Transaction Returned");
                done();
            });
        });

        it("should NOT accept the return request if the request owner is NOT a librarian", (done)=>{
            request(server)
            .put(`/transactions/recive/${transactionId}`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("Librarian gets all non-returned transactions", ()=>{
        it("should return all non-returned transactions", (done)=>{
            request(server)
            .get(`/transactions/allTransactions/nonReturned`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("transactions");
                done();
            });
        });

        it("should NOT return all non-returned transactions if the request owner is NOT a librarian", (done)=>{
            request(server)
            .get(`/transactions/allTransactions/nonReturned`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("Librarian gets all requested to return transactions", ()=>{
        it("should return all non-returned transactions", (done)=>{
            request(server)
            .get(`/transactions/allTransactions/requestedToReturn`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("transactions");
                done();
            });
        });

        it("should NOT return all non-returned transactions if the request owner is NOT a librarian", (done)=>{
            request(server)
            .get(`/transactions/allTransactions/requestedToReturn`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });

    describe("Librarian gets all returnings", ()=>{
        it("should get all returnings", (done)=>{
            request(server)
            .get(`/transactions/admin/returned`)
            .set("Authorization", `bearer ${adminToken}`)
            .end((err,res)=>{
                res.should.have.status(200);
                res.body.should.have.property("success", true);
                res.body.should.have.property("transactions");
                done();
            });
        });

        it("should NOT get all returnings if the request owner is not a librarian", (done)=>{
            request(server)
            .get(`/transactions/admin/returned`)
            .set("Authorization", `bearer ${memToken}`)
            .end((err,res)=>{
                res.should.have.status(403);
                res.body.should.have.property("success", false);
                res.body.should.have.property("status", "Access Denied");
                done();
            });
        });
    });
});



describe("Fees", ()=>{
    it("should get all fees for the request owner", (done)=>{
        request(server)
        .get('/fees/myFees')
        .set("Authorization", `bearer ${token}`)
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("status", "Request Succeed");
            res.body.should.have.property("fees");
            done();
        });
    });

    it("should get all fees in the system if the request owner is a librarian", (done)=>{
        request(server)
        .get('/fees/admin/fees')
        .set("Authorization", `bearer ${adminToken}`)
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("status", "Request Succeed");
            res.body.should.have.property("fees");
            done();
        });
    });

    it("should NOT get the fees in the system if the request owner is NOT a librarian", (done)=>{
        request(server)
        .get('/fees/admin/fees')
        .set("Authorization", `bearer ${memToken}`)
        .end((err,res)=>{
            res.should.have.status(403);
            res.body.should.have.property("success", false);
            res.body.should.have.property("status", "Access Denied");
            done();
        });
    });

    it("should pay the fees of the request owner", (done)=>{
        request(server)
        .put(`/fees/pay/${feeId}`)
        .set("Authorization", `bearer ${memToken}`)
        .end((err,res)=>{
            res.should.have.status(200);
            res.body.should.have.property("success", true);
            res.body.should.have.property("status", "Paid Successfully");
            res.body.should.have.property("fee");
            done();
        });
    });
});
