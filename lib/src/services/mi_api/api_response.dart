import 'package:http/http.dart' as http;
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'dart:convert';
import 'package:ia_mobile/src/services/mi_api/api_handler.dart';

class ApiResponse {
  ApiHandler apiHandler = ApiHandler();

  Future<dynamic> getJson(Uri uri) async {
    var response;
    try {
      response = await http.get(uri);
    } catch (error) {
      throw Exception(LocaleSingleton.strings.apiGenericError);
    }
    return _parseResponse(response);
  }

  Future<dynamic> postJson(
    Uri uri,
    Map<String, dynamic> header,
    Map<String, dynamic> body,
  ) async {
    var response =
        await http.post(uri, headers: header, body: json.encode(body));

    return _parseResponse(response);
  }

  Future<dynamic> putJson(
    Uri uri,
    Map<String, dynamic> header,
    Map<String, dynamic> body,
  ) async {
    var response =
        await http.put(uri, headers: header, body: json.encode(body));

    return _parseResponse(response);
  }

  _parseResponse(var response) {
    return apiHandler.handlerResponse(response);
  }
}
