import 'package:ia_mobile/src/commons/config.dart';
import 'dart:convert';

import 'package:ia_mobile/src/models/people.dart';
import 'package:ia_mobile/src/services/mi_api/api_response.dart';

class PeopleModule {
  String baseUrl = Config.baseUrl;
  String modulePath = '/api/personas';
  ApiResponse apiResponse = ApiResponse();
  // GET
  getListPeople() async {
    String path = '';

    // Map<String, String> header = {
    //   'Authorization': 'Bearer ' + _prefs.getString('token'),
    // };

    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);

    var jsonResult = json.decode(response.body);
    return People().listFromJson(jsonResult);
  }
}
