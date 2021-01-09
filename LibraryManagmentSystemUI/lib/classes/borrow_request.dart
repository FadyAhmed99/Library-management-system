import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../config.dart';
import 'item.dart';
import 'library.dart';

part '../serializers/borrow_request.g.dart';

@JsonSerializable(explicitToJson: true)
class BorrowRequestSerializer {
  final String id;
  final UserSerializer user;
  final String deadline;
  final bool borrowed;
  final ItemSerializer item;
  final LibrarySerializer library;

  BorrowRequestSerializer(
      {this.id,
      this.user,
      this.deadline,
      this.borrowed,
      this.item,
      this.library});

  factory BorrowRequestSerializer.fromJson(Map<String, dynamic> data) =>
      _$BorrowRequestSerializerFromJson(data);
  Map<String, dynamic> toJson() => _$BorrowRequestSerializerToJson(this);
}

class BorrowRequest with ChangeNotifier {
  List<BorrowRequestSerializer> _libraryRequests = [];
  List<BorrowRequestSerializer> get requests {
    return _libraryRequests.reversed.toList() ;
  }

  List<BorrowRequestSerializer> _userBorrowRequests = [];
  List<BorrowRequestSerializer> get borrowRequests {
    return _userBorrowRequests.reversed.toList() ;
  }

  Future<String> requestToBorrow({String libraryId, String itemId}) async {
    try {
      final _url = '$apiStart/borrowRequests/request/$libraryId/$itemId';
      final response = await http.post(
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

  Future<dynamic> getLibraryBorrowRequests({String libraryId}) async {
    try {
      final _url = '$apiStart/borrowRequests/libraryRequests/$libraryId';
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
          _libraryRequests.clear();
          extractedData['requests'].forEach((request) {
            _libraryRequests.add(BorrowRequestSerializer.fromJson(request));
          });
          notifyListeners();
        }
        return null;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> grantLibraryBorrowRequest(
      {String libraryId, String requestId}) async {
    try {
      final _url = '$apiStart/borrowRequests/accept/$libraryId/$requestId';
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

  Future<dynamic> getUserBorrowRequests() async {
    try {
      final _url = '$apiStart/borrowRequests/myRequests';
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
          if (extractedData['requests'] != null) {
            _userBorrowRequests.clear();
            if (extractedData['requests'].length != 0) {
              extractedData['requests'].forEach((req) {
                _userBorrowRequests.add(BorrowRequestSerializer.fromJson(req));
              });
            }
          }
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
