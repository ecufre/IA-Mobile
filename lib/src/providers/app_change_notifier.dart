import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/prefs_singleton.dart';

class AppGeneralNotifier with ChangeNotifier {
  bool _isLogged;

  AppGeneralNotifier() {
    var accessToken = PrefsSingleton.prefs.getString('accessToken');
    bool hasTokens = accessToken != null;
    this._isLogged = hasTokens;
  }

  getLogged() => _isLogged;
  setLoggedState(bool isLogged) => _isLogged = isLogged;

  void login() {
    _isLogged = true;
    notifyListeners();
  }

  void logout() {
    _isLogged = false;
    _removeUserData();
    notifyListeners();
  }

  _removeUserData() {
    PrefsSingleton.prefs.remove('accessToken');
    PrefsSingleton.prefs.remove('rol');
    PrefsSingleton.prefs.remove('username');
    PrefsSingleton.prefs.remove('surname');
    PrefsSingleton.prefs.remove('email');
    PrefsSingleton.prefs.remove('name');
    PrefsSingleton.prefs.remove('pending_uploads');
    PrefsSingleton.prefs.remove('data_saved');
  }
}
