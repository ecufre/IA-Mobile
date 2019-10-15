import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ia_mobile/src/app.dart';
import 'package:ia_mobile/src/commons/prefs_singleton.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/locales/spanish_strings.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ),
  );

  PrefsSingleton.prefs = await SharedPreferences.getInstance();

  // Intl.defaultLocale = 'es_AR';
  String myLocale = Intl.getCurrentLocale();
  print(myLocale);
  LocaleSingleton.strings = SpanishStrings();

  runApp(IAApp());
}
