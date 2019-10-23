import 'package:json_annotation/json_annotation.dart';
part 'bill.g.dart';

@JsonSerializable()
class Bill {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'tipo')
  String type;
  @JsonKey(name: 'monto')
  double amount;

  Bill({this.id, this.type, this.amount});

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);

  List<Bill> listFromJson(List<dynamic> json) {
    List<Bill> list = List<Bill>();
    for (var item in json) {
      list.add(Bill.fromJson(item));
    }
    return list;
  }
}
