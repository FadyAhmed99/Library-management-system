import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part '../serializers/fee.g.dart';

@JsonSerializable(explicitToJson: true)
class FeeSerializer {
  final String transactionId;
  final UserSerializer user;
  final String creditCardInfo;
  final int ccv;
  final ItemSerializer item;
  final double fees;
  final bool paid;
  final DateTime paymentDate;
  final String id;

  FeeSerializer(
      {this.id,
      this.transactionId,
      this.user,
      this.creditCardInfo,
      this.ccv,
      this.item,
      this.fees,
      this.paid,
      this.paymentDate});

  factory FeeSerializer.fromJson(Map<String, dynamic> data) =>
      _$FeeFromJson(data);
  Map<String, dynamic> toJson() => _$FeeToJson(this);
}

class Fee extends ChangeNotifier {
  List<FeeSerializer> _loadedFees = [];
  List<FeeSerializer> get fees {
    return _loadedFees.reversed.toList();
  }

  Future<dynamic> getFees() async {
    try {
      final _url = '$apiStart/fees/myFees';
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
          _loadedFees.clear();
          extractedData['fees'].forEach((fee) {
            _loadedFees.add(FeeSerializer.fromJson(fee));
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

  Future<dynamic> payFee({String feeId, String creditCardInfo, int ccv}) async {
    try {
      final _url = '$apiStart/fees/pay/$feeId';
      final response = await http.put(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"creditCardInfo": creditCardInfo, "ccv": ccv}));
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
