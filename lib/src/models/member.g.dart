// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(tipo: json['tipo'] as String, sueldo: json['sueldo'] as int)
    ..name = json['nombre'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'nombre': instance.name,
      'id': instance.id,
      'tipo': instance.tipo,
      'sueldo': instance.sueldo
    };
