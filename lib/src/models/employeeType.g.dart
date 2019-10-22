// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeeType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeType _$EmployeeTypeFromJson(Map<String, dynamic> json) {
  return EmployeeType(
      id: json['id'] as int,
      description: json['descripcion'] as String,
      active: json['activo'] as bool);
}

Map<String, dynamic> _$EmployeeTypeToJson(EmployeeType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'descripcion': instance.description,
      'activo': instance.active
    };
