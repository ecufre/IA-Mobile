// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
      salaryPerHour: (json['sueldoBasicoCostoHora'] as num)?.toDouble(),
      employeeType: json['tipoEmpleado'] == null
          ? null
          : EmployeeType.fromJson(json['tipoEmpleado'] as Map<String, dynamic>))
    ..name = json['nombre'] as String
    ..lastName = json['apellido'] as String
    ..dni = json['dni'] as int
    ..email = json['email'] as String
    ..sex = json['sexo'] as String
    ..birthDate = json['fechaNacimiento'] == null
        ? null
        : DateTime.parse(json['fechaNacimiento'] as String)
    ..dateAdded = json['fechaAlta'] == null
        ? null
        : DateTime.parse(json['fechaAlta'] as String);
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'nombre': instance.name,
      'apellido': instance.lastName,
      'dni': instance.dni,
      'email': instance.email,
      'sexo': instance.sex,
      'fechaNacimiento': instance.birthDate?.toIso8601String(),
      'fechaAlta': instance.dateAdded?.toIso8601String(),
      'sueldoBasicoCostoHora': instance.salaryPerHour,
      'tipoEmpleado': instance.employeeType
    };
