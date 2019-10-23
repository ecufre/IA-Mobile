// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
      id: json['id'] as int,
      type: json['tipo'] as String,
      amount: (json['monto'] as num)?.toDouble());
}

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'id': instance.id,
      'tipo': instance.type,
      'monto': instance.amount
    };
