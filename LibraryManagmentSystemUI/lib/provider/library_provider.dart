import 'dart:convert';
import 'dart:io';

import 'package:LibraryManagmentSystem/model/library.dart';
import 'package:LibraryManagmentSystem/provider/user-provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class LibraryProvider extends ChangeNotifier {
  List<Library> _libraries = [];
  List<Library> get libraries {
    return _libraries;
  }

  Future<String> getLibraries({String token}) async {
    try {
      final _url = '$apiStart/libraries';
      final response = await http.get(
        _url,
        headers: {HttpHeaders.authorizationHeader: "bearer $token"},
      );

      final extractedData = jsonDecode(response.body);
      print(extractedData['libraries']);
      if (extractedData == null) {
        return 'Error';
      } else {
        if (response.statusCode != 200)
          return extractedData['err'];
        else {
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
}
