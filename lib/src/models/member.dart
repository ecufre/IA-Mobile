import 'package:json_annotation/json_annotation.dart';
import 'package:ia_mobile/src/models/people.dart';
part 'member.g.dart';

@JsonSerializable()
class Member extends People {
  @JsonKey(name: 'habilitadoDesde')
  DateTime authorizedSince;
  @JsonKey(name: 'habilitadoHasta')
  DateTime authorizedUpTo;

  Member({this.authorizedSince, this.authorizedUpTo}) : super();

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
