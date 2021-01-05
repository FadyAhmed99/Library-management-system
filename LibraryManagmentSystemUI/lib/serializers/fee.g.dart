// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeSerializer _$FeeFromJson(Map<String, dynamic> json) {
  return FeeSerializer(
    id: json['_id'] as String,
    transactionId: json['transactionId'] as String,
    user: json['user'] == null
        ? null
        : UserSerializer.fromJson(json['user'] as Map<String, dynamic>),
    creditCardInfo: json['creditCardInfo'] as String,
    ccv: json['ccv'] as int,
    item: json['item'] == null
        ? null
        : ItemSerializer.fromJson(json['item'] as Map<String, dynamic>),
    fees: (json['fees'] as num)?.toDouble(),
    paid: json['paid'] as bool,
    paymentDate: json['paymentDate'] == null
        ? null
        : DateTime.parse(json['paymentDate'] as String),
  );
}

Map<String, dynamic> _$FeeToJson(FeeSerializer instance) => <String, dynamic>{
      'transactionId': instance.transactionId,
      'user': instance.user?.toJson(),
      'creditCardInfo': instance.creditCardInfo,
      'ccv': instance.ccv,
      'item': instance.item?.toJson(),
      'fees': instance.fees,
      'paid': instance.paid,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      '_id': instance.id,
    };
