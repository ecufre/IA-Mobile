import 'package:json_annotation/json_annotation.dart';
part 'people.g.dart';

@JsonSerializable()
class People {
  @JsonKey(name: 'nombre')
  String name;
  @JsonKey(name: 'apellido')
  String lastName;
  @JsonKey(name: 'dni')
  String dni;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'sexo')
  String sex;
  @JsonKey(name: 'fechaNacimiento')
  DateTime birthDate;
  @JsonKey(name: 'fechaAlta')
  DateTime dateAdded;

  People({
    this.name,
    this.lastName,
    this.dni,
    this.email,
    this.sex,
    this.birthDate,
    this.dateAdded,
  });

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleToJson(this);

  List<People> listFromJson(List<dynamic> json) {
    List<People> list = List<People>();
    for (var item in json) {
      list.add(People.fromJson(item));
    }
    return list;
  }
}
