import 'dart:convert';
import 'dart:io';

import '../model/user.dart';
import '../config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserProvider with ChangeNotifier {
  User _user;
  final facebookLogin = FacebookLogin();

  User get user {
    return _user;
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
          getUserProfile(extractedData['token']);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserProfile(String token) async {
    try {
      final _url = '$apiStart/users/profile';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return extractedData['err']['message'];
        else {
          _user = User.fromJson(extractedData['profile']);
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
          getUserProfile(extractedData['token']);
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
}
