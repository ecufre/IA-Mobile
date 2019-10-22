import 'package:ia_mobile/src/models/employeeType.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ia_mobile/src/models/people.dart';
part 'employee.g.dart';

@JsonSerializable()
class Employee extends People {
  @JsonKey(name: 'sueldoBasicoCostoHora')
  double salaryPerHour;
  @JsonKey(name: 'tipoEmpleado')
  EmployeeType employeeType;

  Employee({this.salaryPerHour, this.employeeType}) : super();

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  List<Employee> listFromJson(List<dynamic> json) {
    List<Employee> list = List<Employee>();
    for (var item in json) {
      list.add(Employee.fromJson(item));
    }
    return list;
  }
}
