import 'package:ia_mobile/src/commons/config.dart';
import 'package:ia_mobile/src/models/bill.dart';
import 'package:ia_mobile/src/models/class.dart';
import 'package:ia_mobile/src/models/employee.dart';
import 'package:ia_mobile/src/models/employeeType.dart';
import 'package:ia_mobile/src/models/member.dart';
import 'package:ia_mobile/src/models/passes_type.dart';
import 'package:ia_mobile/src/models/payment_method.dart';
import 'package:ia_mobile/src/models/people.dart';
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

  // GET
  getEmployees() async {
    String path = 'empleados';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return Employee().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getPeople() async {
    String path = 'personas';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return People().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getMembers() async {
    String path = 'socios';
    var uri = new Uri.http(baseUrl, modulePath + path);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return Member().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getLiquidationEmployees(int month, int year) async {
    String path = 'liquidaciones';
    Map<String, String> _query = {
      'mes': month.toString(),
      'anio': year.toString(),
    };
    var uri = new Uri.http(baseUrl, modulePath + path, _query);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return Employee().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // GET
  getLiquidatedEmployees(int month, int year) async {
    String path = 'liquidaciones/pagar';
    Map<String, String> _query = {
      'mes': month.toString(),
      'anio': year.toString(),
    };
    var uri = new Uri.http(baseUrl, modulePath + path, _query);
    var response = await apiResponse.getJson(uri);
    var jsonResult = json.decode(response.body);
    if (jsonResult['successful']) {
      return Employee().listFromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  createMember(String name, String lastName, String dni, String email,
      String sex, DateTime birthDate) async {
    String path = 'socios';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "nombre": name,
      "apellido": lastName,
      "dni": dni,
      "email": email,
      "sexo": "Masculino",
      "fechaNacimiento": birthDate.toIso8601String(),
      "fechaAlta": DateTime.now().toIso8601String(),
      "cbu": null,
      "cuit": null
    };

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return Member.fromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  createEmployee(
      String name,
      String lastName,
      String dni,
      String email,
      String sex,
      String cbu,
      String cuit,
      DateTime birthDate,
      double salaryPerHour,
      EmployeeType employeeType) async {
    String path = 'empleados';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "persona": {
        "nombre": name,
        "apellido": lastName,
        "dni": dni,
        "email": email,
        "sexo": "Masculino",
        "fechaNacimiento": birthDate.toIso8601String(),
        "fechaAlta": DateTime.now().toIso8601String(),
        "cbu": cbu,
        "cuit": cuit
      },
      "idTipoEmpleado": employeeType.id,
      "sueldoBasicoCostoHora": salaryPerHour,
    };

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return Employee.fromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  createBill(
    int idPeople,
    int idPass,
  ) async {
    String path = 'pases';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {"idPersona": idPeople, "idPase": idPass};

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return Bill.fromJson(jsonResult['content']);
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  payBill(int idBill, int idPaymentMethod, String card, String expiryDate,
      String cvvCode, String dni) async {
    String path = 'movimientos';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "idFactura": idBill,
      "idMedioDePago": idPaymentMethod,
      "nroTarjeta": card,
      "fechaVencimiento": expiryDate,
      "codSeguridad": cvvCode,
      "dni": dni
    };

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return true;
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  createLiquidation(
    int idEmployee,
    int month,
    int year,
  ) async {
    String path = 'liquidaciones';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      "idEmpleado": idEmployee,
      "mes": month,
      "anio": year,
    };

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return true;
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  arrivalRequest(
    int idPeople,
    String idRol,
  ) async {
    String path = 'fichero/ingreso';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {"idPersona": idPeople, "idRol": idRol};

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return true;
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // POST
  departureRequest(
    int idPeople,
    String idRol,
  ) async {
    String path = 'fichero/egreso';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {"idPersona": idPeople, "idRol": idRol};

    var response = await apiResponse.postJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return true;
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // PATCH
  paySalaries(
    int month,
    int year,
  ) async {
    String path = 'liquidaciones';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {'mes': month, 'anio': year};

    var response = await apiResponse.patchJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return true;
    } else {
      throw Exception(jsonResult['message']);
    }
  }

  // PATCH
  payroll(
    int month,
    int year,
  ) async {
    String path = 'liquidaciones/nominas';
    var uri = new Uri.http(baseUrl, modulePath + path);
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {'mes': month, 'anio': year};

    var response = await apiResponse.patchJson(uri, header, body);
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    if (jsonResult['successful']) {
      return jsonResult['message'];
    } else {
      throw Exception(jsonResult['message']);
    }
  }
}
