// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passes_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassesType _$PassesTypeFromJson(Map<String, dynamic> json) {
  return PassesType(
      id: json['id'] as int,
      name: json['nombre'] as String,
      price: (json['precio'] as num)?.toDouble());
}

Map<String, dynamic> _$PassesTypeToJson(PassesType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.name,
      'precio': instance.price
    };
