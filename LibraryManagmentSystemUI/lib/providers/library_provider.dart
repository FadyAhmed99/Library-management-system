import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/models/feedback.dart';
import 'package:LibraryManagmentSystem/models/item.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart'
    as userProvider;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

String token = userProvider.globalToken;

class LibraryProvider extends ChangeNotifier {
  List<Feedback> _feedbacks = [];
  List<Feedback> get feedbacks {
    return _feedbacks;
  }

  List<Library> _libraries = [];
  List<Library> get libraries {
    return _libraries;
  }

  List<User> _members = [];
  List<User> get members {
    return _members;
  }

  List<User> _requests = [];
  List<User> get requests {
    return _requests;
  }

  List<User> _blockedFromReviewing = [];
  List<User> get blockedFromReviewing {
    return _blockedFromReviewing;
  }

  List<User> _blockedFromBorrowing = [];
  List<User> get blockedFromBorrowing {
    return _blockedFromBorrowing;
  }

  User _librarian;
  User get librarian {
    return _librarian;
  }

  Library _library;
  Library get library {
    return _library;
  }

  List<Item> _items = [];
  List<Item> get items {
    return _items;
  }

  Future<String> getLibraries() async {
    try {
      final _url = '$apiStart/libraries';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['err'];
        else {
          _libraries.clear();
          extractedData['libraries'].forEach((library) {
            _libraries.add(Library.fromJson(library));
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getLibrary({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/info';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['err'];
        else {
          _librarian = User.fromJson(extractedData['librarian']);
          _library = Library.fromJson(extractedData['library']);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> sendFeedback({String libraryId, String feedback}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/feedback';
      final response = await http.post(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"feedback": feedback}));

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + extractedData['err'];
        else {
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getFeedbacks({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/feedback';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );

      final extractedData = jsonDecode(response.body);
      print(extractedData);

      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          _feedbacks.clear();
          extractedData['feedbacks'].forEach((feed) {
            _feedbacks.add(Feedback.fromJson(feed));
            return null;
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getLibraryMembers({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId?option=members';
      final response = await http.get(
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
          _members.clear();
          extractedData['members'].forEach((member) {
            _members.add(User.fromJson(member));
            return null;
          });
          print(_members);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getLibraryRequests({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId?option=requests';
      final response = await http.get(
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
          _requests.clear();
          extractedData['requests'].forEach((request) {
            _requests.add(User.fromJson(request));
            return null;
          });
          print(_requests);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> libraryAcceptRequest(
      {String libraryId, String userId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/$userId?action=approve';
      final response = await http.put(
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

  Future<dynamic> libraryRejectRequest(
      {String libraryId, String userId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/$userId?action=reject';
      final response = await http.put(
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

  Future<dynamic> setPermissions(
      {String libraryId, String userId, String action, String from}) async {
    try {
      final _url =
          '$apiStart/libraries/$libraryId/permissions/$userId/set?action=$action&from=$from';
      final response = await http.put(
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
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getBlockedFromReviewing({String libraryId}) async {
    try {
      final _url =
          '$apiStart/libraries/$libraryId/permissions/get?blockedFrom=evaluating';
      final response = await http.get(
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
          _blockedFromReviewing.clear();
          extractedData['blockedUsers'].forEach((user) {
            _blockedFromReviewing.add(User.fromJson(user));
            return null;
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getBlockedFromBorrowing({String libraryId}) async {
    print('object');
    try {
      final _url =
          '$apiStart/libraries/$libraryId/permissions/get?blockedFrom=borrowing';
      final response = await http.get(
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
          _blockedFromBorrowing.clear();
          extractedData['blockedUsers'].forEach((user) {
            _blockedFromBorrowing.add(User.fromJson(user));
            return null;
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> editLibraryInfo(
      {String libraryId,
      String name,
      String desc,
      String phoneNum,
      String address}) async {
    print('object');
    try {
      final _url = '$apiStart/libraries/$libraryId/info';
      final response = await http.put(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $token",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": name,
            "address": address,
            "description": desc,
            "phoneNumber": phoneNum
          }));

      final extractedData = jsonDecode(response.body);

      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          getLibraries();
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getLibraryItems({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/items';
      final response = await http.get(
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
          _items.clear();
          print(extractedData['items']);
          extractedData['items'].forEach((item) {
            _items.add(Item.fromJson(item));
            return null;
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
