// store some configuration information

module.exports = {
    'secretKey': '12345-67890-09876-54321',
    // 'mongoUrl' : 'mongodb+srv://librica:librica1234@cluster0.hkday.mongodb.net/LibraryManagementSystem?retryWrites=true&w=majority',
    'mongoUrl' : 'mongodb://localhost:27017/LibraryManagementSystem',
    'facebook' : {
        clientId: '890641605030884',     
        clientSecret:'4b24c394967b30382ad7193e8b81e4be'
    },
    'duration': 10,
    'lib1': '5fd53f880f2d076ac295de1d',
    'lib2': '5fd53f8e0f2d076ac295de1e',
    'lib3': '5fd53f910f2d076ac295de1f',
    'maxNumOfBorrowings': 3,
    'jwtDuration': 36000,
    'startPoint':"https://156.213.70.91:3443/",
};