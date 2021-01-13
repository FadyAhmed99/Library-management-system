import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part '../serializers/favorite.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoriteSerializer {
  String id;
  String type;
  String name;
  String genre;
  String language;
  String author;
  String isbn;
  String image;
  bool inLibrary;
  int lateFees;
  String location;
  String libraryId;
  int amount;
  FavoriteSerializer(
      {this.libraryId,
      this.id,
      this.type,
      this.name,
      this.genre,
      this.language,
      this.author,
      this.isbn,
      this.image,
      this.inLibrary,
      this.lateFees,
      this.location,
      this.amount});

  factory FavoriteSerializer.fromJson(Map<String, dynamic> data) =>
      _$FavoriteSerializerFromJson(data);
  Map<String, dynamic> toJson() => _$FavoriteSerializerToJson(this);
}

class Favorite extends ChangeNotifier {
  List<ItemSerializer> _loadedFavItems = [];
  List<ItemSerializer> get favorites {
    return _loadedFavItems.reversed.toList();
  }

  Future<dynamic> getFavourites() async {
    try {
      final _url = '$apiStart/users/favorites';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $globalToken"},
      );
      final extractedData = jsonDecode(response.body);
      print(response.body);
      if (extractedData == null) {
        return 'Error!';
      } else {
        if (response.statusCode != 200)
          return extractedData['err'];
        else {
          _loadedFavItems.clear();
          if (extractedData['items'].length != 0) {
            extractedData['items'].forEach((item) {
              _loadedFavItems.add(ItemSerializer.fromJson(item));
            });
          }
          notifyListeners();
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> addToFavourites({String itemId, String libraryId}) async {
    try {
      final _url = '$apiStart/users/favorites';
      final response = await http.post(
        _url,
        headers: {
          HttpHeaders.authorizationHeader: "bearer $globalToken",
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
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteFromFavourites(
      {String itemId,@required String libraryId}) async {
    try {
      final _url = '$apiStart/users/favorites';
      final response = await http.put(
        _url,
        headers: {
          HttpHeaders.authorizationHeader: "bearer $globalToken",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"_id": itemId,"library":libraryId }),
      );
      final extractedData = jsonDecode(response.body);
      if (extractedData == null) {
        return 'Error!';
      } else {
        if (response.statusCode != 200) {
          return extractedData['err'];
        } else {
          _loadedFavItems.removeWhere((element) => element.id == itemId);
          notifyListeners();
          return extractedData['status'];
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
