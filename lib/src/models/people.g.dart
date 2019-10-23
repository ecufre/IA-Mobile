// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) {
  return People(
      name: json['nombre'] as String,
      lastName: json['apellido'] as String,
      dni: json['dni'] as String,
      email: json['email'] as String,
      sex: json['sexo'] as String,
      birthDate: json['fechaNacimiento'] == null
          ? null
          : DateTime.parse(json['fechaNacimiento'] as String),
      dateAdded: json['fechaAlta'] == null
          ? null
          : DateTime.parse(json['fechaAlta'] as String),
      rols: (json['roles'] as List)?.map((e) => e as String)?.toList())
    ..id = json['id'] as int;
}

Map<String, dynamic> _$PeopleToJson(People instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.name,
      'apellido': instance.lastName,
      'dni': instance.dni,
      'email': instance.email,
      'sexo': instance.sex,
      'fechaNacimiento': instance.birthDate?.toIso8601String(),
      'fechaAlta': instance.dateAdded?.toIso8601String(),
      'roles': instance.rols
    };
