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
    ..id = json['id'] as int
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
        : DateTime.parse(json['fechaAlta'] as String)
    ..rols = (json['roles'] as List)?.map((e) => e as String)?.toList()
    ..cbu = json['cbu'] as String
    ..cuit = json['cuit'] as String;
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.name,
      'apellido': instance.lastName,
      'dni': instance.dni,
      'email': instance.email,
      'sexo': instance.sex,
      'fechaNacimiento': instance.birthDate?.toIso8601String(),
      'fechaAlta': instance.dateAdded?.toIso8601String(),
      'roles': instance.rols,
      'cbu': instance.cbu,
      'cuit': instance.cuit,
      'sueldoBasicoCostoHora': instance.salaryPerHour,
      'tipoEmpleado': instance.employeeType
    };
