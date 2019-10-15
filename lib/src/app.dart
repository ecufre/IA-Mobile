import 'package:flutter/material.dart';
import 'package:ia_mobile/src/providers/app_change_notifier.dart';
import 'package:ia_mobile/src/providers/connectivity_service.dart';
import 'package:ia_mobile/src/screens/root_page.dart';
import 'package:provider/provider.dart';

class IAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppGeneralNotifier>(
          builder: (_) => AppGeneralNotifier(),
        ),
        ChangeNotifierProvider<ConnectivityServiceNotifier>(
          builder: (_) => ConnectivityServiceNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IA_Mobile',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}
