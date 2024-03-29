import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/screens/arrivals_and_departures/arrival_departure_page.dart';
import 'package:ia_mobile/src/screens/create_users/create_user_page.dart';
import 'package:ia_mobile/src/screens/home_page.dart';
import 'package:ia_mobile/src/screens/transactions/liquidate_salaries_page.dart';

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
          _button(LocaleSingleton.strings.start, _goToHomePage),
          Divider(color: Colors.grey[700], thickness: 0.5),
          _button(
              LocaleSingleton.strings.peopleManagement, _goToPeopleManagement),
          Divider(color: Colors.grey[700], thickness: 0.5),
          _button(LocaleSingleton.strings.liquidateSalaries, _goToPaySalaries),
          Divider(color: Colors.grey[700], thickness: 0.5),
          _button(LocaleSingleton.strings.arrivalsAndDepartures,
              _goToArrivalsAndDepartures),
          Divider(color: Colors.grey[700], thickness: 0.5),
        ],
      ),
    );
  }

  Widget _header() {
    return DrawerHeader(
      child: Center(
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage("assets/images/the_rock_image.png"),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/drawer_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _goToPaySalaries() {
    Navigator.pop(context);
    GeneralNavigator(context, LiquidateSalariesPage()).replaceNavigate();
  }

  _goToHomePage() {
    Navigator.pop(context);
    GeneralNavigator(context, HomePage()).replaceNavigate();
  }

  _goToPeopleManagement() {
    Navigator.pop(context);
    GeneralNavigator(context, CreateUserPage()).replaceNavigate();
  }

  _goToArrivalsAndDepartures() {
    Navigator.pop(context);
    GeneralNavigator(context, ArrivalAndDeparturePage()).replaceNavigate();
  }

  Widget _button(String text, function) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: 'WorkSans Regular',
        ),
      ),
      onTap: () => function(),
    );
  }
}
