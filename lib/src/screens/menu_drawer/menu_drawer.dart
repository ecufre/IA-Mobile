import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';

class MenuDrawer extends StatefulWidget {
  @override
  _MenuDrawerState createState() => new _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _body(),
    );
  }

  Widget _body() {
    return Container(
      color: Ui.primaryColor,
      child: Column(
        children: <Widget>[
          _header(),
          _button(LocaleSingleton.strings.paySalaries),
          Divider(color: Colors.grey[700], thickness: 0.5),
          _button(LocaleSingleton.strings.billSubscription),
          Divider(color: Colors.grey[700], thickness: 0.5),
          // Expanded(child: SizedBox()),
          // Divider(color: Colors.black),
          // _logOutButton(),
        ],
      ),
    );
  }

  Widget _header() {
    return DrawerHeader(
      child: null,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/drawer_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _button(String text) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: 'WorkSans Regular',
        ),
      ),
    );
  }
}
