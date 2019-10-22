import 'package:json_annotation/json_annotation.dart';
part 'passes_type.g.dart';

@JsonSerializable()
class PassesType {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'nombre')
  String name;
  @JsonKey(name: 'precio')
  double price;

  PassesType({this.id, this.name, this.price});

  factory PassesType.fromJson(Map<String, dynamic> json) =>
      _$PassesTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PassesTypeToJson(this);

  List<PassesType> listFromJson(List<dynamic> json) {
    List<PassesType> list = List<PassesType>();
    for (var item in json) {
      list.add(PassesType.fromJson(item));
    }
    return list;
  }
}
