import 'package:json_annotation/json_annotation.dart';
part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'descripcion')
  String description;
  @JsonKey(name: 'valor')
  String value;

  PaymentMethod({this.id, this.description, this.value});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);

  List<PaymentMethod> listFromJson(List<dynamic> json) {
    List<PaymentMethod> list = List<PaymentMethod>();
    for (var item in json) {
      list.add(PaymentMethod.fromJson(item));
    }
    return list;
  }
}
