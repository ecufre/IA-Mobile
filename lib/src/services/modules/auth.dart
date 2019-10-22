import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/config.dart';
import 'package:http/http.dart' as http;
import 'package:ia_mobile/src/commons/prefs_singleton.dart';
import 'package:ia_mobile/src/services/mi_api/api_response.dart';

class AuthModule {
  String baseUrl = Config.baseUrl;
  String modulePath = 'account/';
  ApiResponse apiResponse = ApiResponse();

  // POST
  login(String username, String password) async {
    String path = 'login';
    String fullPath = baseUrl + modulePath + path;
    Map<String, dynamic> body = {'username': username, 'password': password};
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http
        .post(fullPath, headers: headers, body: json.encode(body))
        .timeout(Config.timeout);
    //final result = apiResponseHandler.handlerResponse(response);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));

    PrefsSingleton.prefs.setString("Token", "hdjkashd");

    return true;
  }
}
