import 'package:flutter/widgets.dart';
import 'package:LibraryManagmentSystem/model/available.dart';
import 'package:LibraryManagmentSystem/model/review.dart';

class Item {
  String name;
  String genre;
  String author;
  String language;
  String isbn = '';
  List<Available> available;
  List<Review> review;
  
  Item(
      {@required this.name,
      @required this.genre,
      @required this.author,
      @required this.language,
      this.isbn,
      this.available,
      this.review});
}
