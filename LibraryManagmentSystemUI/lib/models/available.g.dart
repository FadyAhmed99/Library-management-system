// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Available _$AvailableFromJson(Map<String, dynamic> json) {
  return Available(
    id: json['id'] as String,
    image: json['image'] as String,
    inLibrary: json['inLibrary'] as bool,
    itemLink: json['itemLink'] as String,
    lateFees: (json['lateFees'] as num)?.toDouble(),
    amount: json['amount'] as int,
    location: json['location'] as String,
  );
}

Map<String, dynamic> _$AvailableToJson(Available instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'inLibrary': instance.inLibrary,
      'itemLink': instance.itemLink,
      'lateFees': instance.lateFees,
      'amount': instance.amount,
      'location': instance.location,
    };
