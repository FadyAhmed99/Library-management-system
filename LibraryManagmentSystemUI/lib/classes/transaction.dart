import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../config.dart';
import 'borrow_request.dart';
import 'item.dart';
import 'library.dart';

part '../serializers/transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionSerializer {
  final UserSerializer user;

  final ItemSerializer item;
  // final String type;
  // final String name;
  // final String itemId;
  // final String image;
  // final String itemLink;
  // final String author;

  final LibrarySerializer borrowedFrom;
  final LibrarySerializer returnedTo;
  // final String libraryId;
  // final String libraryName;

  final String id;
  final double lateFees;
  final DateTime borrowDate;
  final DateTime deadline;
  final DateTime returnDate;
  final DateTime createdAt;
  final bool requestedToReturn;
  final bool returned;
  final bool hasFees;

  TransactionSerializer(
      {this.returnedTo,
      this.hasFees,
      this.user,
      this.createdAt,
      this.item,
      this.returnDate,
      this.borrowedFrom,
      this.id,
      this.lateFees,
      this.borrowDate,
      this.deadline,
      this.requestedToReturn,
      this.returned});

  factory TransactionSerializer.fromJson(Map<String, dynamic> data) =>
      _$TransactionFromJson(data);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

class Transaction extends ChangeNotifier {
  TransactionSerializer _reciept;
  TransactionSerializer get reciept {
    return _reciept;
  }

  List<TransactionSerializer> _borrowedItems = [];
  List<TransactionSerializer> get borrowedItems {
    return _borrowedItems;
  }

  List<BorrowRequestSerializer> _borrowRequests = [];
  List<BorrowRequestSerializer> get borrowRequests {
    return _borrowRequests;
  }

  List<TransactionSerializer> _transactions = [];
  List<TransactionSerializer> get transactions {
    return _transactions;
  }

  List<TransactionSerializer> _retunings = [];
  List<TransactionSerializer> get retunings {
    return _retunings;
  }

// user get his borrowed items
  Future<dynamic> userBorrowings() async {
    try {
      final _url = '$apiStart/transactions/borrowed';
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
          _borrowedItems.clear();
          extractedData['borrowedItems'].forEach((item) {
            _borrowedItems.add(TransactionSerializer.fromJson(item));
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

// to show reciept
  Future<dynamic> exactTransaction({String transactionId}) async {
    try {
      final _url = '$apiStart/transactions/transaction/$transactionId';
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
          notifyListeners();
          _reciept =
              TransactionSerializer.fromJson(extractedData['transaction']);
          return null;
        }
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<dynamic> sendRequestToReturn({String transactionId}) async {
    try {
      final _url = '$apiStart/transactions/requestToReturn/$transactionId';
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

// user get his borrowing log requestedToReturn = false or returnings requestedToReturn = true
  Future<dynamic> getTransactions({bool requestedToReturn}) async {
    try {
      final _url =
          '$apiStart/transactions/myTransactions?requestedToReturn=$requestedToReturn';
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
          _transactions.clear();
          extractedData['transactions'].forEach((trans) {
            try {
              _transactions.add(TransactionSerializer.fromJson(trans));
            } catch (e) {
              print(e);
            }
          });
          _borrowRequests.clear();
          if (extractedData['bRequests'] != null) {
            extractedData['bRequests'].forEach((req) {
              _borrowRequests.add(BorrowRequestSerializer.fromJson(req));
            });
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

  Future<dynamic> getRequestedToReturn() async {
    try {
      final _url = '$apiStart/transactions/allTransactions/requestedToReturn';
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
          _retunings.clear();
          extractedData['transactions'].forEach((trans) {
            _retunings.add(TransactionSerializer.fromJson(trans));
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

  Future<dynamic> receiveItem({String transactionId}) async {
    try {
      final _url = '$apiStart/transactions/recive/$transactionId';
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
}
