import 'package:ia_mobile/src/commons/config.dart';
import 'package:ia_mobile/src/models/class.dart';
import 'package:ia_mobile/src/models/employeeType.dart';
import 'package:ia_mobile/src/models/member.dart';
import 'package:ia_mobile/src/models/passes_type.dart';
import 'package:ia_mobile/src/models/payment_method.dart';
import 'package:ia_mobile/src/services/mi_api/api_response.dart';
import 'dart:convert';

class ApiModule {
  String baseUrl = Config.baseUrl;
  String modulePath = '/api/';
  ApiResponse apiResponse = ApiResponse();

  // GET
  getPassesType() async {
    String path = 'pases';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return PassesType().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getClasses() async {
    String path = 'clases';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return Class().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getPaymentMethods() async {
    String path = 'mediosDePago';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return PaymentMethod().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getEmployeeTypes() async {
    String path = 'tiposEmpleado';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return EmployeeType().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  createMember(Member member) async {
    String path = 'request/dasa';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, dynamic> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      'nombre': member.name,
      'apellido': member.lastName,
      'dni': member.dni,
      'email': member.email,
      'sexo': member.sex,
      'fechaNacimiento': member.birthDate,
      'fechaAlta': DateTime.now(),
    };

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return Member().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }
}
