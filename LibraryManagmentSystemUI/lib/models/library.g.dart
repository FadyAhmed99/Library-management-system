// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) {
  return Library(
    name: json['name'] as String,
    address: json['address'] as String,
    librarian: json['librarian'] as String,
  );
}

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'librarian': instance.librarian,
    };
