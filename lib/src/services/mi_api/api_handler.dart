import 'dart:convert';
import 'package:ia_mobile/src/locales/locale_singleton.dart';

class ApiHandler {
  handlerResponse(var response) {
    if (_isOk(response)) {
      return _checkResponse(response);
    } else {
      _generalError(response);
    }
    throw Exception(LocaleSingleton.strings.apiGenericError);
  }

  bool _isOk(var response) {
    return response.statusCode >= 200 && response.statusCode < 299;
  }

  _checkResponse(var response) {
    String message;
    try {
      var jsonResult = json.decode(utf8.decode(response.bodyBytes));
      if (_jsonIsEmpty(jsonResult)) {
        return response;
      } else {
        return response;
      }
    } catch (_) {
      message = LocaleSingleton.strings.emptyBody;
    }
    throw Exception(message);
  }

  bool _jsonIsEmpty(var jsonResult) {
    return jsonResult.length == 0;
  }

  _generalError(var response) {
    String errorMessage;
    if (response.statusCode == 404) {
      errorMessage = LocaleSingleton.strings.apiNotFoundError;
    }
    if (response.statusCode == 500) {
      errorMessage = LocaleSingleton.strings.apiGenericError;
    } else {
      var jsonResult = json.decode(utf8.decode(response.bodyBytes));
      errorMessage = _parseErrorMessage(jsonResult);
    }
    throw Exception(errorMessage);
  }

  String _parseErrorMessage(var jsonResult) {
    if (jsonResult != '') {
      if (jsonResult['message'] != null) {
        return jsonResult['message'];
      } else {
        return jsonResult;
      }
    } else {
      return LocaleSingleton.strings.apiGenericError;
    }
  }
}
