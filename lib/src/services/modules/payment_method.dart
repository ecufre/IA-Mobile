import 'dart:convert';

import 'package:ia_mobile/src/commons/config.dart';
import 'package:http/http.dart' as http;
import 'package:ia_mobile/src/models/payment_method.dart';

import 'package:ia_mobile/src/services/mi_api/api_response.dart';

class PaymentMethodModule {
  String baseUrl = Config.baseUrl;
  String modulePath = '/api/';
  ApiResponse apiResponse = ApiResponse();

  // GET
  getPeymentMethods() async {
    String path = 'movimientos';

    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);

    var jsonResult = json.decode(response.body);
    return PaymentMethod().listFromJson(jsonResult);
  }
}
