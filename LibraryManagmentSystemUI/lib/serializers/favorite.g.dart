// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteSerializer _$FavoriteSerializerFromJson(Map<String, dynamic> json) {
  return FavoriteSerializer(
    libraryId: json['libraryId'] as String,
    id: json['_id'] as String,
    type: json['type'] as String,
    name: json['name'] as String,
    genre: json['genre'] as String,
    language: json['language'] as String,
    author: json['author'] as String,
    isbn: json['ISBN'] as String,
    image: json['image'] as String,
    inLibrary: json['inLibrary'] as bool,
    lateFees: json['lateFees'] as int,
    location: json['location'] as String,
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$FavoriteSerializerToJson(FavoriteSerializer instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'genre': instance.genre,
      'language': instance.language,
      'author': instance.author,
      'ISBN': instance.isbn,
      'image': instance.image,
      'inLibrary': instance.inLibrary,
      'lateFees': instance.lateFees,
      'location': instance.location,
      'libraryId': instance.libraryId,
      'amount': instance.amount,
    };
