// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibrarySerializer _$LibraryFromJson(Map<String, dynamic> json) {
  return LibrarySerializer(
    status: json['status'] as String,
    name: json['name'] as String,
    id: json['_id'] as String,
    address: json['address'] as String,
    description: json['description'] as String,
    phoneNumber: json['phoneNumber'] as String,
    image: json['image'] as String,
    librarian: json['librarian'] as String,
    feedback: (json['feedback'] as List)
        ?.map((e) => e == null
            ? null
            : FeedbackSerializer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LibraryToJson(LibrarySerializer instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'librarian': instance.librarian,
      'status': instance.status,
      'feedback': instance.feedback?.map((e) => e?.toJson())?.toList(),
    };
