import 'package:LibraryManagmentSystem/model/feedback.dart';
import 'package:flutter/cupertino.dart';

class Library {
  String name;
  String address = '';
  String description = '';
  String phoneNumber = '';
  String image = '';
  String librarian;
  List<Feedback> feedback;

  Library(
      {@required this.name,
      this.address,
      this.description,
      this.phoneNumber,
      this.image,
      this.librarian,
      this.feedback});
      
}
