// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
      fileNumber: json['legajo'] as String,
      dateAdded: json['fechaAlta'] == null
          ? null
          : DateTime.parse(json['fechaAlta'] as String),
      state: json['estado'] as bool)
    ..name = json['nombre'] as String
    ..lastName = json['apellido'] as String
    ..dni = json['dni'] as int
    ..email = json['email'] as String;
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'nombre': instance.name,
      'apellido': instance.lastName,
      'dni': instance.dni,
      'email': instance.email,
      'legajo': instance.fileNumber,
      'fechaAlta': instance.dateAdded?.toIso8601String(),
      'estado': instance.state
    };
