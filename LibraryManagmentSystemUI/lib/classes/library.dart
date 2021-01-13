import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/classes/feedback.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part '../serializers/library.g.dart';

@JsonSerializable(explicitToJson: true)
class LibrarySerializer {
  final String id;
  String name;
  final String address;
  final String description;
  final String phoneNumber;
  final String image;
  final String librarian;
  List<FeedbackSerializer> feedback;
  String status;

  LibrarySerializer(
      {this.status,
      this.name,
      this.id,
      this.address,
      this.description,
      this.phoneNumber,
      this.image,
      this.librarian,
      this.feedback});
  factory LibrarySerializer.fromJson(Map<String, dynamic> data) =>
      _$LibraryFromJson(data);
  Map<String, dynamic> toJson() => _$LibraryToJson(this);

  void changeName(String newName) {
    name = newName;
  }
}

class Library extends ChangeNotifier {
  List<LibrarySerializer> _loadedLibraries = [];
  List<LibrarySerializer> get libraries {
    return _loadedLibraries.reversed.toList();
  }

  List<UserSerializer> _members = [];
  List<UserSerializer> get members {
    return _members.reversed.toList();
  }

  List<UserSerializer> _requests = [];
  List<UserSerializer> get requests {
    return _requests.reversed.toList();
  }

  List<UserSerializer> _blockedFromReviewing = [];
  List<UserSerializer> get blockedFromReviewing {
    return _blockedFromReviewing.reversed.toList();
  }

  List<UserSerializer> _blockedFromBorrowing = [];
  List<UserSerializer> get blockedFromBorrowing {
    return _blockedFromBorrowing.reversed.toList();
  }

  UserSerializer _librarian;
  UserSerializer get librarian {
    return _librarian;
  }

  LibrarySerializer _loadedLibrary;
  LibrarySerializer get library {
    return _loadedLibrary;
  }

  List<ItemSerializer> _items = [];
  List<ItemSerializer> get items {
    return _items.reversed.toList();
  }

  List<ItemSerializer> _libraryItems = [];
  List<ItemSerializer> get libraryItems {
    return _libraryItems.reversed.toList();
  }

  Future<String> getLibrary() async {
    try {
      final _url = '$apiStart/libraries';
      final response = await http.get(
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
          _loadedLibraries.clear();
          extractedData['libraries'].forEach((library) {
            _loadedLibraries.add(LibrarySerializer.fromJson(library));
          });
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> getLibraryInfo({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/info';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return "extractedData['err']";
        else {
          _librarian = UserSerializer.fromJson(extractedData['librarian']);
          _loadedLibrary = LibrarySerializer.fromJson(extractedData['library']);
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getLibraryMembers({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId?option=members';
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
          _members.clear();
          extractedData['members'].forEach((member) {
            _members.add(UserSerializer.fromJson(member));
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

  Future<dynamic> getLibraryJoinRequests({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId?option=requests';
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
          _requests.clear();
          extractedData['requests'].forEach((request) {
            _requests.add(UserSerializer.fromJson(request));
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

  Future<dynamic> librarianAcceptRequest(
      {String libraryId, String userId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/$userId?action=approve';
      final response = await http.put(
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
          return extractedData['status'];
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> librarianRejectRequest(
      {String libraryId, String userId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/$userId?action=reject';
      final response = await http.put(
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
          return extractedData['err'];
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> setUserPermissions(
      {String libraryId, String userId, String action, String from}) async {
    try {
      final _url =
          '$apiStart/libraries/$libraryId/permissions/$userId/set?action=$action&from=$from';
      final response = await http.put(
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
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> getBlockedUsersFromReviewing({String libraryId}) async {
    try {
      final _url =
          '$apiStart/libraries/$libraryId/permissions/get?blockedFrom=evaluating';
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
          _blockedFromReviewing.clear();
          extractedData['blockedUsers'].forEach((user) {
            _blockedFromReviewing.add(UserSerializer.fromJson(user));
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

  Future<dynamic> getBlockedUsersFromBorrowing({String libraryId}) async {
    try {
      final _url =
          '$apiStart/libraries/$libraryId/permissions/get?blockedFrom=borrowing';
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
          _blockedFromBorrowing.clear();
          extractedData['blockedUsers'].forEach((user) {
            _blockedFromBorrowing.add(UserSerializer.fromJson(user));
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
    try {
      final _url = '$apiStart/libraries/$libraryId/info';
      final response = await http.put(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
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
          getLibrary();
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
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['status'] + ' ' + extractedData['err'];
        else {
          _libraryItems.clear();
          extractedData['items'].forEach((item) {
            _libraryItems.add(ItemSerializer.fromJson(item));
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

  Future<dynamic> latestAddition(int i) async {
    try {
      final _url = '$apiStart/stats/libraries/lib$i';
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
          _items.clear();
          extractedData['latest$i'].forEach((item) {
            _items.add(ItemSerializer.fromJson(item));
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

  Future<List<ItemSerializer>> search({String by, String filter}) async {
    try {
      final _url = '$apiStart/search?by=$by&filter=$filter';
      final response = await http.get(
        _url,
        headers: {
          HttpHeaders.authorizationHeader: "bearer $globalToken",
          "Content-Type": "application/json"
        },
      );

      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return null;
      } else {
        if (response.statusCode != 200)
          return null;
        else {
          List<ItemSerializer> it = [];
          extractedData['items'].forEach((item) {
            try {
              it.add(ItemSerializer.fromJson(item));
            } catch (e) {
              print(e);
            }
          });
          return it;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
