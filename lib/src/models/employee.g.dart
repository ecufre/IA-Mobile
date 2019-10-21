// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(tipo: json['tipo'] as String, sueldo: json['sueldo'] as int)
    ..name = json['nombre'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'nombre': instance.name,
      'id': instance.id,
      'tipo': instance.tipo,
      'sueldo': instance.sueldo
    };
