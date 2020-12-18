import 'dart:convert';
import 'dart:io';

import '../model/user.dart';
import '../config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User _user = User();

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

      _user = null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
