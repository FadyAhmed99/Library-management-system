import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/models/subscribed_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/user.dart';

String globalToken = '';

class UserProvider with ChangeNotifier {
  final facebookLogin = FacebookLogin();

  User _user;
  User get user {
    return _user;
  }

  String _token;
  String get token {
    return _token;
  }

  Future<String> signUpUser(String userName, String password) async {
    try {
      final _url = '$apiStart/users/signup';
      final response = await http.post(
        _url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": userName, "password": password}),
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200) {
          return extractedData['err']['message'];
        } else {
          logInUser(userName, password);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> logInUser(String userName, String password) async {
    try {
      final _url = '$apiStart/users/login';
      final response = await http.post(
        _url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": userName, "password": password}),
      );

      final extractedData = jsonDecode(response.body);

      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return extractedData['err']['message'];
        else {
          _token = extractedData['token'];
          globalToken = _token;
          getUserProfile();

          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserProfile() async {
    try {
      final _url = '$apiStart/users/profile';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $_token"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return extractedData['err']['message'];
        else {
          _user = User.fromJson(extractedData['profile']);
          myLibraries();
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> logoutUser(String token) async {
    try {
      final _url = '$apiStart/users/logout';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );
      await facebookLogout();
      _user = null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInFacebookUser(String token) async {
    try {
      final _url = '$apiStart/users/facebook/token';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      final extractedData = jsonDecode(response.body);

      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return extractedData['err']['message'];
        else {
          _token = extractedData['token'];
          globalToken = _token;
          getUserProfile();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> facebookSignin() async {
    final result = await facebookLogin.logIn(['email']);
    print(result.errorMessage);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        logInFacebookUser(result.accessToken.token);
        return null;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return 'Canceled by user';
        break;
      case FacebookLoginStatus.error:
        return 'Error!!';
        break;
    }
  }

  Future<Null> facebookLogout() async {
    await facebookLogin.logOut().then((value) {
      _user = null;
      notifyListeners();
    });
  }

  Future<dynamic> myLibraries() async {
    try {
      final _url = '$apiStart/users/myLibraries';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $_token"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return 'Error';
        else {
          _user.subscribedLibraries = [];
          extractedData['subscribedLibraries'].forEach((library) {
            _user.subscribedLibraries.add(SubscribedLibrary.fromJson(library));
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> myFavourites() async {
    try {
      final _url = '$apiStart/users/favorites';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $_token"},
      );
      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error!';
      } else {
        if (response.statusCode != 200)
          return extractedData['err'];
        else {
          if (extractedData['items'].length != 0) {
            extractedData['items'].forEach((item) {
              _user.addFav(item);
            });
          }
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> addToMyFavourites({String itemId, String libraryId}) async {
    try {
      final _url = '$apiStart/users/favorites';
      final response = await http.post(
        _url,
        headers: {
          HttpHeaders.authorizationHeader: "bearer $_token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"_id": itemId, "library": libraryId}),
      );
      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error!';
      } else {
        if (response.statusCode != 200) {
          return extractedData['err'];
        } else {
          return extractedData['status'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteFromMyFavourites(
      {String itemId, String libraryId}) async {
    try {
      final _url = '$apiStart/users/favorites';
      final response = await http.put(
        _url,
        headers: {
          HttpHeaders.authorizationHeader: "bearer $_token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"_id": itemId, "library": libraryId}),
      );
      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error!';
      } else {
        if (response.statusCode != 200) {
          return extractedData['err'];
        } else {
          return extractedData['status'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> sendJoinRequest({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/requests';
      final response = await http.post(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );

      final extractedData = jsonDecode(response.body);

      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          return extractedData['status'];
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
