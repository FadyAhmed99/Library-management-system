// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribed_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribedLibrary _$SubscribedLibraryFromJson(Map<String, dynamic> json) {
  return SubscribedLibrary(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    image: json['image'] as String,
    phoneNumber: json['phoneNumber'] as String,
    description: json['description'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$SubscribedLibraryToJson(SubscribedLibrary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'image': instance.image,
      'phoneNumber': instance.phoneNumber,
      'description': instance.description,
      'status': instance.status,
    };
