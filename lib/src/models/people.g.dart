// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) {
  return People(
      name: json['nombre'] as String,
      lastName: json['apellido'] as String,
      dni: json['dni'] as int,
      email: json['email'] as String);
}

Map<String, dynamic> _$PeopleToJson(People instance) => <String, dynamic>{
      'nombre': instance.name,
      'apellido': instance.lastName,
      'dni': instance.dni,
      'email': instance.email
    };
