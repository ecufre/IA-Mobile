import 'package:ia_mobile/src/providers/app_change_notifier.dart';
import 'package:ia_mobile/src/screens/home_page.dart';
import 'package:ia_mobile/src/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppGeneralNotifier>(
      builder: (context, appGeneralNotifier, _) {
        return appGeneralNotifier.getLogged() ? HomePage() : LoginPage();
      },
    );
  }
}
