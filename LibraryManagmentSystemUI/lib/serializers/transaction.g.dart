// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSerializer _$TransactionFromJson(Map<String, dynamic> json) {
  return TransactionSerializer(
    returnedTo: json['returnedTo'] == null
        ? null
        : LibrarySerializer.fromJson(
            json['returnedTo'] as Map<String, dynamic>),
    hasFees: json['hasFees'] as bool,
    user: json['user'] == null
        ? null
        : UserSerializer.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    item: json['item'] == null
        ? null
        : ItemSerializer.fromJson(json['item'] as Map<String, dynamic>),
    returnDate: json['returnDate'] == null
        ? null
        : DateTime.parse(json['returnDate'] as String),
    borrowedFrom: json['borrowedFrom'] == null
        ? null
        : LibrarySerializer.fromJson(
            json['borrowedFrom'] as Map<String, dynamic>),
    id: json['_id'] as String,
    lateFees: (json['lateFees'] as num)?.toDouble(),
    borrowDate: json['borrowDate'] == null
        ? null
        : DateTime.parse(json['borrowDate'] as String),
    deadline: json['deadline'] == null
        ? null
        : DateTime.parse(json['deadline'] as String),
    requestedToReturn: json['requestedToReturn'] as bool,
    returned: json['returned'] as bool,
  );
}

Map<String, dynamic> _$TransactionToJson(TransactionSerializer instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'item': instance.item?.toJson(),
      'borrowedFrom': instance.borrowedFrom?.toJson(),
      'returnedTo': instance.returnedTo?.toJson(),
      '_id': instance.id,
      'lateFees': instance.lateFees,
      'borrowDate': instance.borrowDate?.toIso8601String(),
      'deadline': instance.deadline?.toIso8601String(),
      'returnDate': instance.returnDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'requestedToReturn': instance.requestedToReturn,
      'returned': instance.returned,
      'hasFees': instance.hasFees,
    };
