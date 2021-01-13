// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSerializer _$ItemFromJson(Map<String, dynamic> json) {
  return ItemSerializer(
    libraryId: json['libraryId'] as String,
    id: json['_id'] as String,
    type: json['type'] as String,
    genre: json['genre'] as String,
    name: json['name'] as String,
    author: json['author'] as String,
    language: json['language'] as String,
    isbn: json['ISBN'] as String,
    image: json['image'] as String??'',
    inLibrary: json['inLibrary'] as bool ?? true,
    lateFees: json['lateFees'] as num ?? 0.0,
    location: json['location'] as String,
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    amount: json['amount'] as num,
    averageRating: json['averageRating'],
    isNew: json['isNew'] as bool ?? false,
    itemLink: json['itemLink'] as String,
    available: (json['available'] as List)
        ?.map((e) => e == null
            ? null
            : AvailableSerializer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    transaction: json['transaction'] == null
        ? null
        : TransactionSerializer.fromJson(
            json['transaction'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ItemToJson(ItemSerializer instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'genre': instance.genre,
      'name': instance.name,
      'libraryId': instance.libraryId,
      'author': instance.author,
      'language': instance.language,
      'ISBN': instance.isbn,
      'image': instance.image,
      'inLibrary': instance.inLibrary,
      'lateFees': instance.lateFees,
      'location': instance.location,
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
      'amount': instance.amount,
      'averageRating': instance.averageRating,
      'isNew': instance.isNew,
      'itemLink': instance.itemLink,
      'available': instance.available?.map((e) => e?.toJson())?.toList(),
      'transaction': instance.transaction?.toJson(),
    };
