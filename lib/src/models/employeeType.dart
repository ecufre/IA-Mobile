import 'package:json_annotation/json_annotation.dart';
part 'employeeType.g.dart';

@JsonSerializable()
class EmployeeType {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'descripcion')
  String description;
  @JsonKey(name: 'costoHora')
  String amountPerHour;

  EmployeeType({this.id, this.description, this.amountPerHour});

  factory EmployeeType.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeTypeToJson(this);

  List<EmployeeType> listFromJson(List<dynamic> json) {
    List<EmployeeType> list = List<EmployeeType>();
    for (var item in json) {
      list.add(EmployeeType.fromJson(item));
    }
    return list;
  }
}
