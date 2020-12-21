// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
    id: json['_id'] as String,
    type: json['type'] as String,
    name: json['name'] as String,
    genre: json['genre'] as String,
    language: json['language'] as String,
    author: json['author'] as String,
    isbn: json['isbn'] as String,
    image: json['image'] as String,
    inLibrary: json['inLibrary'] as bool,
    lateFees: json['lateFees'] as int,
    location: json['location'] as String,
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'genre': instance.genre,
      'language': instance.language,
      'author': instance.author,
      'isbn': instance.isbn,
      'image': instance.image,
      'inLibrary': instance.inLibrary,
      'lateFees': instance.lateFees,
      'location': instance.location,
      'amount': instance.amount,
    };
