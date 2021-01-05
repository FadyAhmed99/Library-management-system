// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSerializer _$UserFromJson(Map<String, dynamic> json) {
  return UserSerializer(
    facebookId: json['facebookId'] as String,
    librarian: json['librarian'] as bool,
    subscribedLibraries: (json['subscribedLibraries'] as List)
        ?.map((e) => e == null
            ? null
            : LibrarySerializer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    favorites: (json['favorites'] as List)
        ?.map((e) => e == null
            ? null
            : FavoriteSerializer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    profilePhoto: json['profilePhoto'] as String,
    username: json['username'] as String,
    id: json['_id'] as String,
    canBorrowItems: json['canBorrowItems'] as bool,
    canEvaluateItems: json['canEvaluateItems'] as bool,
    borrowedItems: (json['borrowedItems'] as List)
        ?.map((e) => e == null
            ? null
            : ItemSerializer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(UserSerializer instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profilePhoto': instance.profilePhoto,
      'username': instance.username,
      'facebookId': instance.facebookId,
      'librarian': instance.librarian,
      '_id': instance.id,
      'canBorrowItems': instance.canBorrowItems,
      'canEvaluateItems': instance.canEvaluateItems,
      'subscribedLibraries':
          instance.subscribedLibraries?.map((e) => e?.toJson())?.toList(),
      'borrowedItems':
          instance.borrowedItems?.map((e) => e?.toJson())?.toList(),
      'favorites': instance.favorites?.map((e) => e?.toJson())?.toList(),
    };
