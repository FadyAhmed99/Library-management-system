// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['_id'] as String,
    type: json['type'] as String,
    genre: json['genre'] as String,
    name: json['name'] as String,
    author: json['author'] as String,
    language: json['language'] as String,
    isbn: json['isbn'] as String,
    image: json['image'] as String,
    inLibrary: json['inLibrary'] as bool,
    lateFees: json['lateFees'] as int,
    location: json['location'] as String,
    amount: json['amount'] as int,
    averageRating: json['averageRating'] as int,
    isNew: json['isNew'] as bool,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'genre': instance.genre,
      'name': instance.name,
      'author': instance.author,
      'language': instance.language,
      'isbn': instance.isbn,
      'image': instance.image,
      'inLibrary': instance.inLibrary,
      'lateFees': instance.lateFees,
      'location': instance.location,
      'amount': instance.amount,
      'isNew': instance.isNew,
      'averageRating': instance.averageRating
    };
