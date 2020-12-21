// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) {
  return Library(
    name: json['name'] as String,
    address: json['address'] as String,
    description: json['description'] as String,
    phoneNumber: json['phoneNumber'] as String,
    image: json['image'] as String,
    librarian: json['librarian'] as String,
    feedback: (json['feedback'] as List)
        ?.map((e) =>
            e == null ? null : Feedback.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'librarian': instance.librarian,
      'feedback': instance.feedback?.map((e) => e?.toJson())?.toList(),
    };
