import 'package:ia_mobile/src/locales/strings.dart';

class LocaleSingleton {
  static final LocaleSingleton _singleton = LocaleSingleton._internal();

  static Strings strings;

  factory LocaleSingleton() {
    return _singleton;
  }

  LocaleSingleton._internal();
}
