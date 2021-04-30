# Librica Project

Librica is a library management system application for mobile phones. The application is intended to help librarians and library patrons alike by making many virtual libraries accessible by users and moderated by librarians. Library patrons can now have an application they may call theirs, they can now browse, read, and search for books using their phones and pick them up later from the nearest library registered on the system. Users will be able to track their fees and pay them off online and also drop off the books they borrowed to the nearest library instead of going to where the books were originally borrowed from. Librarians can update their library's collection and keep tabs on statistical reports of items borrowed, returned and unpaid fees in addition to other library management options.
* [Project Figma Design](https://www.figma.com/file/j4l0kRmTTqGolQwCA9OsuR/Library-management-system?node-id=0%3A1)
* [Documentation & Demo](https://drive.google.com/drive/folders/1dEh-P75ZQnvZ5_kCbuavXvhr9cHDL4H9?usp=sharing)
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them to preform setup and testing.

Frontend:
* [Flutter](https://flutter.dev/docs/get-started/install) 
* [Android Studio](https://developer.android.com/studio)
* SDK tools which can be downloaded with android studio
* Connected device (either emulator downloaded from android studio or real device)
* To download emulator: 
  from Android Studio Navigation bar select AVD then select create a virtual device.
 

Backend:
* [NodeJs](https://nodejs.org/en/download/)
* [MongoDB](https://www.mongodb.com/try/download/community)


### Installing
#### Frontend:
* Clone the repository 
* Go to library-management-system/LibraryManagementSystemUI directory then right click and select open in android studio.
* inside the terminal of same directory run
 ``` 
 flutter pub get
 ```
* from android studio, run any emulator.
* for real device, enable developer options on your android device. 
* then from android studio select run then run without debugging (or Shift+F10).

#### Backend:
Note: in this part you need MongoDB and NodeJs installed.
The application's backend is already up and deployed on heroku online
The database is also up and deployed online on MongoDB Atlas(the link will be provided in the report)
If you want to connect to the online database, open the terminal and write this line:
```
mongo <the database link that will be provided in the report delivered>
```
Now, if you want to run the server offline do as follows:
* Clone the repository 
* inside the terminal change directory to library-management-system/LibraryManagementSystemServer then write the following line:
```
npm install
``` 
* Open a new terminal window and reach for library-management-system/LibraryManagementSystemServer then create a new directory call it "mongoDB".
* Open mongoDB directory then create a new directory called "data".
* in the directory library-management-system/LibraryManagementSystemServer/mongoDB write the following line:
```
mongod --dbpath=data --bind_ip 127.0.0.1
``` 
this will run a local mongoDB server on your device.
* Now, go up one folder(library-management-system/LibraryManagementSystemServer/) then write this command in your terminal:

```
npm start
```
Note: the UI will not interact with the offline server.

## Running the tests

#### Frontend:
* Go to library-management-system/LibraryManagementSystemUI/test directory.
* inside the terminal of same directory:
```
flutter test <filename_test.dart> 
```

#### Backend:
* First, make sure that mongoDB offline server is working.
* Open a new tab in terminal then write the following:
 ```
 mongo
 ```

 ```
 use LibraryManagementSystem 
 ```
Initial documents:
 ```
 db.libraries.insertOne({"_id":ObjectId("5fd53f880f2d076ac295de1d"), "name":"library1", "librarian":ObjectId("5ff86dbc85361e52dc5ba275"), "available":[]})  
 ```

 ```
 db.libraries.insertOne({"_id":ObjectId("5fd53f8e0f2d076ac295de1e"), "name":"library2", "librarian":ObjectId("5ff86dbc85361e52dc5ba276"), "available":[]})
  
 ```
 ```
  db.libraries.insertOne({"_id":ObjectId("5fd53f910f2d076ac295de1f"), "name":"library3", "librarian":ObjectId("5ff86dbc85361e52dc5ba277"), "available":[]})
 
 ```
 ```
 db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba275"),"username":"librarian1", "librarian":true, "subscribedLibraries":[] ,"salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
 ```
 ```
 db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba276"),"username":"librarian2", "librarian":true, "subscribedLibraries":[] ,"salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
 ```
 ```
 db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba277"),"username":"librarian3", "librarian":true, "subscribedLibraries":[] ,"salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
 ```

 ```
 db.users.insertOne({"_id":ObjectId("5ff86dbc85361e52dc5ba279"), "username":"member", "subscribedLibraries":[{"_id":ObjectId("5fd53f880f2d076ac295de1d"), "member": true}, {"_id":ObjectId("5fd53f8e0f2d076ac295de1e"), "member": true},{"_id":ObjectId("5fd53f910f2d076ac295de1f"), "member": true}], "salt":"79f2b1c9566a923de3994b92257083c2ee240a8b86e292d12e95c82809f2e343", "hash":"c1bda90783acf4c4b4ea322e33af24d671d4b63c0090c3d8d29bb7dc0d3412b4235004ba46d025eb345922e4876a34fee8133ce39cad4bb976f14bddab64ae3ee7584228099caea318fd140e220a395931395aa7a76490781080e6359eb0a2736463ffb60bb1be8c06206f27cbb95880841d61cf7765c545fb451dd7691b9036921455fa3b288a91f3f829d19f5a947461fe4b70b92c58bb763db91ca206d313236ed3c4f2948f34c0642b484b02fec77484111a326f18a1383be0ade85090b7cd96c355192d46820dd588f0c69115a9fb6179eedfc633a1b371d0ef923cd04aba8001293a9a81003e32a1c216d02f69b42d17155233bdc5280dea1bacc3e90dabc4bbd1aca76d11cfbd6d227686001a6a3135eba3ef17227b257a6e71660e06183d20a11549b514d3911e0ecd298e29ce62688c167db2dc4eff74c639a6cef5d6287833255727538e9c73344277d88ecbc12b8dc46197fb70361ef76b74138a71eba2ed53bf248e2d5b09f40466dc34bcab3c81e85edd272e624632d46217420801a1df9a3612ead812704892ef6dd9a6bbefb1427d71570ae46264772ab5812430e72ee0f5b12a08aa926ad9e72aafc62c167fc9168a6e6e7845c28a8921498e783d343db17f23f38e5dca35dda7dd8ca679225a8cf6eb3a4b8b7bbf3abb5e39734d94607e6364f9d7b5cc1df34a27029f6880f886f620ff2448b3df3c5ec1"})
 ```

 ```
 db.items.insertOne({"_id":ObjectId("5ff7e5c246f9159e445c50b7"), "name":"item1Book", "genre": "wow", "type":"book", "author":"cat", "language":"arabic", "ISBN":"24323232", "available":[{"_id":ObjectId("5fd53f880f2d076ac295de1d"), "location":"shelf-3", "lateFees":5, "inLibrary":false, "image":"imagelink", "amount" : 99999999999999999},{"_id":ObjectId("5fd53f8e0f2d076ac295de1e"),"amount":99999999999999999, "location":"shelf-3", "lateFees":5, "inLibrary":true, "image":"imagelink"}, {"_id":ObjectId("5fd53f910f2d076ac295de1f"),"amount":99999999999999999, "location":"shelf-3", "lateFees":5, "inLibrary":true, "image":"imagelink"}]})
 ```
 ```
 db.items.insertOne({"_id":ObjectId("5ff7e5c246f9159e445c50b8"), "name":"item1Book", "genre": "wow", "type":"ebook", "author":"cat", "language":"arabic", "ISBN":"24323232", "available":[{"_id":ObjectId("5fd53f880f2d076ac295de1d"), "location":"shelf-3", "lateFees":5, "inLibrary":false, "image":"imagelink", "itemLink":"link"},{"_id":ObjectId("5fd53f8e0f2d076ac295de1e"),"location":"shelf-3", "lateFees":5, "inLibrary":false, "image":"imagelink", "itemLink":"link"}, {"_id":ObjectId("5fd53f910f2d076ac295de1f"), "lateFees":5, "inLibrary":false, "image":"imagelink", "itemLink":"link"}]})

 ```
 ```
 db.transactions.insertOne({"_id":ObjectId("5ffb09fa1fc3602ec41d8bf2"),"user":ObjectId("5ff86dbc85361e52dc5ba279"), "borrowedFrom": ObjectId("5fd53f880f2d076ac295de1d"), "item":ObjectId("5ff7e5c246f9159e445c50b7"), "returnedTo":ObjectId("5fd53f8e0f2d076ac295de1e"), "lateFees": 5, "requestedToReturn": true, "returned": true, "hasFees": true})

 ```
 ```
 db.fees.insertOne({"_id":ObjectId("5ffb0ae01fc3602ec41d8bf2"),"user":ObjectId("5ff86dbc85361e52dc5ba279"), "transactionId": ObjectId("5ffb09fa1fc3602ec41d8bf2"), "item":ObjectId("5ff7e5c246f9159e445c50b7"), "fees": 5, "paid": false})
 ```

* Open a new terminal tab then change directory to LibraryManagementSystemServer then write the following commands:

```
git branch Beta-Testing
```
```
git checkout Beta-Testing
```

```
git pull origin Beta-Testing
```

```
npm install mocha --save-dev
```

```
npm install chai --save-dev
```

```
npm install chai-http --save-dev
```

```
npm install supertest --save-dev
```

```
npm test
```
* if you want to rerun the test again go to the terminal tab the one with database commands:

```
db.users.drop()
```

```
db.items.drop()
```

```
db.fees.drop()
```

```
db.borrowrequests.drop()
```

```
db.transactions.drop()
```

```
db.libraries.drop()
```
* Then redo the initial docmuents commands.

* Now, go back to the terminal tab with LibraryManagementSystemServer and type:
```
npm test
```






