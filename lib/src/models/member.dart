import 'package:json_annotation/json_annotation.dart';
import 'package:ia_mobile/src/models/people.dart';
part 'member.g.dart';

@JsonSerializable()
class Member extends People {
  @JsonKey(name: 'tipo')
  String tipo;
  @JsonKey(name: 'sueldo')
  int sueldo;

  Member({this.tipo, this.sueldo}) : super();

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  List<Member> listFromJson(List<dynamic> json) {
    List<Member> list = List<Member>();
    for (var item in json) {
      list.add(Member.fromJson(item));
    }
    return list;
  }
}
