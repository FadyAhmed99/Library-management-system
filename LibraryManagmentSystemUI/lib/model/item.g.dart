// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    name: json['name'] as String,
    genre: json['genre'] as String,
    author: json['author'] as String,
    language: json['language'] as String,
    isbn: json['isbn'] as String,
    available: (json['available'] as List)
        ?.map((e) =>
            e == null ? null : Available.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'genre': instance.genre,
      'author': instance.author,
      'language': instance.language,
      'isbn': instance.isbn,
      'available': instance.available?.map((e) => e?.toJson())?.toList(),
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
    };
