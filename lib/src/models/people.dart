import 'package:json_annotation/json_annotation.dart';
part 'people.g.dart';

@JsonSerializable()
class People {
  @JsonKey(name: 'nombre')
  String name;
  @JsonKey(name: 'id')
  int id;

  People({this.name, this.id});
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
