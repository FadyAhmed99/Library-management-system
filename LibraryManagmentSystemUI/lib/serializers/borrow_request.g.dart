// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/borrow_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BorrowRequestSerializer _$BorrowRequestSerializerFromJson(
    Map<String, dynamic> json) {
  return BorrowRequestSerializer(
    id: json['_id'] as String,
    user: json['user'] == null
        ? null
        : UserSerializer.fromJson(json['user'] as Map<String, dynamic>),
    deadline: json['deadline'] as String,
    borrowed: json['borrowed'] as bool,
    item: json['item'] == null
        ? null
        : ItemSerializer.fromJson(json['item'] as Map<String, dynamic>),
    library: json['library'] == null
        ? null
        : LibrarySerializer.fromJson(json['library'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BorrowRequestSerializerToJson(
        BorrowRequestSerializer instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user?.toJson(),
      'deadline': instance.deadline,
      'borrowed': instance.borrowed,
      'item': instance.item?.toJson(),
      'library': instance.library?.toJson(),
    };
