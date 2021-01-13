import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

import 'package:json_annotation/json_annotation.dart';

import 'favorite.dart';
import 'fee.dart';
import 'item.dart';

part '../serializers/user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSerializer {
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  String profilePhoto;
  final String username;
  final String facebookId;
  final bool librarian;
  final String id;
  bool canBorrowItems;
  bool canEvaluateItems;
  List<LibrarySerializer> subscribedLibraries = new List();
  List<ItemSerializer> borrowedItems = new List();
  List<FavoriteSerializer> favorites = new List();

  UserSerializer(
      {this.facebookId,
      this.librarian,
      this.subscribedLibraries,
      this.favorites,
      this.firstname,
      this.lastname,
      this.email,
      this.phoneNumber,
      this.profilePhoto,
      this.username,
      this.id,
      this.canBorrowItems,
      this.canEvaluateItems,
      this.borrowedItems});

  factory UserSerializer.fromJson(Map<String, dynamic> data) =>
      _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  void addFav(dynamic fav) {
    this.favorites.add(FavoriteSerializer.fromJson(fav));
  }

  bool isLibrarian(String librarianId) {
    return id == librarianId;
  }
}

class User with ChangeNotifier {
  final facebookLogin = FacebookLogin();

  UserSerializer _loadedUser;
  UserSerializer get user {
    return _loadedUser;
  }

  List<LibrarySerializer> _subscribedLibraries = [];
  List<LibrarySerializer> get subs {
    return _subscribedLibraries.reversed.toList();
  }

  List<TransactionSerializer> _systemBorrowingsItems = [];
  List<TransactionSerializer> get allBorrowedItems {
    return _systemBorrowingsItems.reversed.toList();
  }

  List<TransactionSerializer> _systemReturnings = [];
  List<TransactionSerializer> get systemReturnings {
    return _systemReturnings.reversed.toList();
  }

  List<FeeSerializer> _systemFees = [];
  List<FeeSerializer> get allFees {
    return _systemFees.reversed.toList();
  }

  Future<String> signUp({
    String firstName,
    String lastName,
    String userName,
    String email,
    String phoneNum,
    String password,
  }) async {
    try {
      final _url = '$apiStart/users/signup';
      final response = await http.post(
        _url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": userName,
          "password": password,
          "firstname": firstName,
          "lastname": lastName,
          "email": email,
          "phoneNumber": phoneNum
        }),
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200) {
          return extractedData['err']['message'];
        } else {
          await logIn(userName, password);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> logIn(String userName, String password) async {
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
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          await _prefs.setString('token', extractedData['token']);
          await _prefs.setBool('facebook', false);

          globalToken = extractedData['token'];

          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getSubscribedLibraries() async {
    try {
      final _url = '$apiStart/users/myLibraries';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200) {
          return 'Error';
        } else {
          _subscribedLibraries.clear();
          extractedData['subscribedLibraries'].forEach((library) {
            _subscribedLibraries.add(LibrarySerializer.fromJson(library));
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getProfile() async {
    try {
      final _url = '$apiStart/users/profile';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return extractedData['err']['message'];
        else {
          _loadedUser = UserSerializer.fromJson(extractedData['profile']);

          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> logOut() async {
    try {
      final _url = '$apiStart/users/logout';
      await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );
      await logOutFacebook();
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.remove('token');
      await _prefs.setBool('facebook', false);

      globalToken = null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// get user jwt token
  Future<void> logInByFacebook(String token) async {
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
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          await _prefs.setString('token', extractedData['token']);
          await _prefs.setBool('facebook', true);

          globalToken = extractedData['token'];
        }
      }
    } catch (e) {
      print(e);
    }
  }

// facebook access token
  Future<String> signInByFacebook() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        await logInByFacebook(result.accessToken.token);
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

  Future<Null> logOutFacebook() async {
    await facebookLogin.logOut().then((value) async {
      globalToken = null;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.remove('token');
      await _prefs.setBool('facebook', false);
      notifyListeners();
    });
  }

// get all users list
  Future<dynamic> getSystemUsersList() async {
    try {
      final _url = '$apiStart/stats/users';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          List<UserSerializer> _loadedUsers = [];
          extractedData['users'].forEach((user) {
            _loadedUsers.add(UserSerializer.fromJson(user));
          });
          return _loadedUsers;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> editProfile(
      {String firstname,
      String lastanme,
      String phoneNum,
      String email}) async {
    try {
      final _url = '$apiStart/users/profile';
      final response = await http.put(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "firstname": firstname,
            "lastname": lastanme,
            "phoneNumber": phoneNum,
            "email": email
          }));

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> changeProfileImage({
    String image,
  }) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.authorizationHeader: "bearer $globalToken"
      };

      //create multipart request for POST or PATCH method
      var request = http.MultipartRequest(
          "PUT", Uri.parse("$apiStart/users/profile/profilePic"));
      request.headers.addAll(headers);

      var pic = await http.MultipartFile.fromPath("profilePic", image);

      request.files.add(pic);

      var response = await request.send();
      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      await getProfile();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> sendJoinRequest({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/requests';
      final response = await http.post(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);

      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['err'];
        else {
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getSystemFees() async {
    try {
      final _url = '$apiStart/fees/admin/fees';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          _systemFees.clear();
          extractedData['fees'].forEach((fee) {
            _systemFees.add(FeeSerializer.fromJson(fee));
          });
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

// librarian system returnings log
  Future<dynamic> getSystemReturnings() async {
    try {
      final _url = '$apiStart/transactions/admin/returned';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          _systemReturnings.clear();
          extractedData['transactions'].forEach((trans) {
            _systemReturnings.add(TransactionSerializer.fromJson(trans));
          });
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

// admin get all borrowed items
  Future<dynamic> getSystemBorrowedItems() async {
    try {
      final _url = '$apiStart/transactions/allTransactions/nonReturned';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          _systemBorrowingsItems.clear();
          extractedData['transactions'].forEach((trans) {
            _systemBorrowingsItems.add(TransactionSerializer.fromJson(trans));
          });

          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
