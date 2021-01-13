import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'package:json_annotation/json_annotation.dart';

part '../serializers/feedback.g.dart';

@JsonSerializable()
class FeedbackSerializer {
  String firstname;
  String lastname;
  String profilePhoto;
  String userId;
  String feedback;

  FeedbackSerializer(
      {this.firstname,
      this.lastname,
      this.profilePhoto,
      this.userId,
      this.feedback});

  factory FeedbackSerializer.fromJson(Map<String, dynamic> data) =>
      _$FeedbackFromJson(data);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}

class Feedback extends ChangeNotifier {
  List<FeedbackSerializer> _loadedFeedbacks = [];
  List<FeedbackSerializer> get feedbacks {
    return _loadedFeedbacks.reversed.toList();
  }

  Future<String> sendFeedback({String libraryId, String feedback}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/feedback';
      final response = await http.post(_url,
          headers: {
            HttpHeaders.authorizationHeader: "bearer $globalToken",
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

  Future<dynamic> getLibraryFeedbacks({String libraryId}) async {
    try {
      final _url = '$apiStart/libraries/$libraryId/feedback';
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
          _loadedFeedbacks.clear();
          extractedData['feedbacks'].forEach((feed) {
            _loadedFeedbacks.add(FeedbackSerializer.fromJson(feed));
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
