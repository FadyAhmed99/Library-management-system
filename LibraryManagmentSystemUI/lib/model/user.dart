import 'package:LibraryManagmentSystem/model/favorite.dart';
import 'package:LibraryManagmentSystem/model/subscribed_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String profilePhoto;
  final String username;
  final String facebookId;
  final bool librarian;
  final String id;
  bool canBorrowItems;
  bool canEvaluateItems;
  List<SubscribedLibrary> subscribedLibraries;
  List<Favorite> favorites = new List();

  User(
      {this.facebookId,
      this.librarian,
      this.subscribedLibraries,
      this.favorites,
      this.firstname,
      this.lastname,
      this.email,
      this.phoneNumber,
      this.profilePhoto,
      this.username,
      this.id,
      this.canBorrowItems,
      this.canEvaluateItems});

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  void addFav(dynamic fav) {
    this.favorites.add(Favorite.fromJson(fav));
  }
}
