// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
      authorizedSince: json['habilitadoDesde'] == null
          ? null
          : DateTime.parse(json['habilitadoDesde'] as String),
      authorizedUpTo: json['habilitadoHasta'] == null
          ? null
          : DateTime.parse(json['habilitadoHasta'] as String))
    ..name = json['nombre'] as String
    ..lastName = json['apellido'] as String
    ..dni = json['dni'] as String
    ..email = json['email'] as String
    ..sex = json['sexo'] as String
    ..birthDate = json['fechaNacimiento'] == null
        ? null
        : DateTime.parse(json['fechaNacimiento'] as String)
    ..dateAdded = json['fechaAlta'] == null
        ? null
        : DateTime.parse(json['fechaAlta'] as String);
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'nombre': instance.name,
      'apellido': instance.lastName,
      'dni': instance.dni,
      'email': instance.email,
      'sexo': instance.sex,
      'fechaNacimiento': instance.birthDate?.toIso8601String(),
      'fechaAlta': instance.dateAdded?.toIso8601String(),
      'habilitadoDesde': instance.authorizedSince?.toIso8601String(),
      'habilitadoHasta': instance.authorizedUpTo?.toIso8601String()
    };
