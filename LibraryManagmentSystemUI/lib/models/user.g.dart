// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    facebookId: json['facebookId'] as String,
    librarian: json['librarian'] as bool,
    subscribedLibraries: (json['subscribedLibraries'] as List)
        ?.map((e) => e == null
            ? null
            : SubscribedLibrary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    favorites: (json['favorites'] as List)
        ?.map((e) =>
            e == null ? null : Favorite.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    firstname: json['firstname'] as String,
    id: json['_id'] as String,
    lastname: json['lastname'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    canBorrowItems: json['canBorrowItems'] as bool,
    canEvaluateItems: json['canEvaluateItems'] as bool,
    profilePhoto: json['profilePhoto'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstname': instance.firstname,
      '_id': instance.id,
      'lastname': instance.lastname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profilePhoto': instance.profilePhoto,
      'username': instance.username,
      'facebookId': instance.facebookId,
      'librarian': instance.librarian,
      'canBorrowItems': instance.canBorrowItems,
      'canEvaluateItems': instance.canEvaluateItems,
      'subscribedLibraries':
          instance.subscribedLibraries?.map((e) => e?.toJson())?.toList(),
      'favorites': instance.favorites?.map((e) => e?.toJson())?.toList(),
    };
