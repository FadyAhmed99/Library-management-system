import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/serializers/available.dart';
import 'package:LibraryManagmentSystem/serializers/review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

import 'package:json_annotation/json_annotation.dart';

part '../serializers/item.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemSerializer {
  final String id;
  final String type;
  final String genre;
  final String name;
  final String libraryId;
  final String author;
  final String language;
  final String isbn;
  final String image;
  final bool inLibrary;
  final num lateFees;
  final String location;
  final List<Review> reviews;
  final num amount;
  final dynamic averageRating;
  final bool isNew;
  final String itemLink;
  final List<AvailableSerializer> available;
  final TransactionSerializer transaction;
  ItemSerializer(
      {this.libraryId,
      this.id,
      this.type,
      this.genre,
      this.name,
      this.author,
      this.language,
      this.isbn,
      this.image,
      this.inLibrary,
      this.lateFees,
      this.location,
      this.reviews,
      this.amount,
      this.averageRating,
      this.isNew,
      this.itemLink,
      this.available,
      this.transaction});

  factory ItemSerializer.fromJson(Map<String, dynamic> data) =>
      _$ItemFromJson(data);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

class Item extends ChangeNotifier {
  ItemSerializer _loadedItem;
  ItemSerializer get item {
    return _loadedItem;
  }

  List<ItemSerializer> _loadedItems = [];
  List<ItemSerializer> get items {
    return _loadedItems.reversed.toList();
  }

  Future<dynamic> reviewItem(
      {String libraryId, String itemId, double rating, String review}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/items/$itemId/reviews';
      final response = await http.post(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"rating": rating, "review": review}));
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

  Future<String> getItemDetails({String itemId, String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/items/$itemId';
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
          _loadedItem = ItemSerializer.fromJson(extractedData['item']);
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> deleteItem({String itemId, String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/items/$itemId';
      final response = await http.delete(
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
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> editItemInfo(
      {String libraryId,
      String itemId,
      String name,
      String location,
      int amount,
      String language,
      double lateFees,
      String link,
      String image,
      bool inLibrary}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/items/$itemId';
      final response = await http.put(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": name,
            "amount": amount,
            "location": location,
            "lateFees": lateFees,
            "inLibrary": inLibrary,
            "image": image,
            "language": language,
            "itemLink": link,
          }));

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

  Future<dynamic> addItem({
    String isbn,
    String language,
    String libraryId,
    String name,
    String location,
    String amount,
    double lateFees,
    String link,
    String image,
    String author,
    String genre,
    String type,
    bool inLibrary,
  }) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/items';
      final response = await http.post(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "name": name,
            "amount": amount,
            "location": location,
            "lateFees": lateFees,
            "inLibrary": inLibrary,
            "image": image,
            "itemLink": link,
            "author": author,
            "genre": genre,
            "type": type == 'audio' ? 'audioMaterial' : type,
            "language": language,
            "ISBN": isbn
          }));

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
