import 'package:ia_mobile/src/commons/general_regex.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';

class Validator {
  String emailValidator(String input) {
    if (input.isEmpty) {
      return LocaleSingleton.strings.emailEmptyError;
    } else if (!GeneralRegex.regexEmail.hasMatch(input)) {
      return LocaleSingleton.strings.emailError;
    } else {
      return null;
    }
  }

  String passwordValidator(String input) {
    if (input.isEmpty) {
      return LocaleSingleton.strings.passwordError;
    } else {
      return null;
    }
  }
}
