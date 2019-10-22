import 'package:json_annotation/json_annotation.dart';
part 'class.g.dart';

@JsonSerializable()
class Class {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'nombre')
  String name;

  Class({this.id, this.name});

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);

  Map<String, dynamic> toJson() => _$ClassToJson(this);

  List<Class> listFromJson(List<dynamic> json) {
    List<Class> list = List<Class>();
    for (var item in json) {
      list.add(Class.fromJson(item));
    }
    return list;
  }
}
