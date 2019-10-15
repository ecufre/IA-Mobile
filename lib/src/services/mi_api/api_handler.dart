import 'dart:convert';
import 'package:ia_mobile/src/locales/locale_singleton.dart';

class ApiHandler {
  handlerResponse(var response) {
    if (_isOk(response)) {
      return _checkResponse(response);
    } else if (_isUnauthorized(response)) {
      return _unauthorizedError(response);
    } else {
      _generalError(response);
    }
    throw Exception(LocaleSingleton.strings.apiGenericError);
  }

  bool _isOk(var response) {
    return response.statusCode >= 200 && response.statusCode < 299;
  }

  bool _isUnauthorized(var response) {
    return response.statusCode == 401;
  }

  _checkResponse(var response) {
    String message;
    try {
      var jsonResult = json.decode(utf8.decode(response.bodyBytes));
      if (_jsonIsEmpty(jsonResult)) {
        return response;
      } else if (_dataNotFound(jsonResult)) {
        message = LocaleSingleton.strings.emptyBody;
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

  bool _dataNotFound(var jsonResult) {
    return jsonResult[0] == "NotFound" || jsonResult[0] == "Not Found";
  }

  _unauthorizedError(var response) {
    if (_hasTokenExpiredAndNotEmptyBody(response)) {
      throw Exception(_getUnauthorizedMessage(response));
    } else if (_hasTokenExpiredAndEmptyBody(response)) {
      return response.statusCode;
    } else if (_hasNotTokenExpiredAndNotEmptyBody(response)) {
      throw Exception(_getUnauthorizedMessage(response));
    }
    throw Exception(LocaleSingleton.strings.apiGenericError);
  }

  bool _hasTokenExpiredAndNotEmptyBody(var response) {
    return response.headers['token-expired'] != 'true' && response.body != '';
  }

  bool _hasTokenExpiredAndEmptyBody(var response) {
    return response.headers['token-expired'] == 'true' && response.body == '';
  }

  bool _hasNotTokenExpiredAndNotEmptyBody(var response) {
    return response.headers['token-expired'] == null && response.body != '';
  }

  String _getUnauthorizedMessage(var response) {
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    return _parseUnauthorizedErrorMessage(jsonResult[0]['mensaje']);
  }

  _generalError(var response) {
    var jsonResult = json.decode(utf8.decode(response.bodyBytes));
    String errorMessage = _parseErrorMessage(jsonResult);
    if (errorMessage == 'Invalid refresh token') {
      errorMessage = LocaleSingleton.strings.sectionError;
    }
    throw Exception(errorMessage);
  }

  String _parseUnauthorizedErrorMessage(var jsonResult) {
    if (jsonResult != '') {
      return jsonResult;
    } else {
      return LocaleSingleton.strings.apiGenericError;
    }
  }

  String _parseErrorMessage(var jsonResult) {
    if (jsonResult != '') {
      if (jsonResult['Message'] != null) {
        return jsonResult['Message'];
      } else {
        return jsonResult;
      }
    } else {
      return LocaleSingleton.strings.apiGenericError;
    }
  }
}
