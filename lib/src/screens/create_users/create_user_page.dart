import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/screens/create_users/add_employee_page.dart';
import 'package:ia_mobile/src/screens/create_users/add_member_page.dart';
import 'package:ia_mobile/src/screens/menu_drawer/menu_drawer.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => new _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: MenuDrawer(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        LocaleSingleton.strings.peopleManagement,
        style: TextStyle(
          fontSize: 22.0,
          fontFamily: 'WorkSans Bold',
        ),
      ),
      backgroundColor: Ui.primaryColor,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          _button(LocaleSingleton.strings.addEmployee, _goToAddEmployeePage,
              "assets/images/member_image.png"),
          SizedBox(height: 40.0),
          _button(LocaleSingleton.strings.addMember, _goToAddMemberPage,
              "assets/images/employee_image.png"),
        ],
      ),
    );
  }

  Widget _button(String text, function, String image) {
    return Container(
      height: 200.0,
      width: 300,
      child: RaisedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'WorkSans Bold',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              image,
              scale: 5.0,
            ),
          ],
        ),
        onPressed: () => function(),
        color: Ui.primaryColor,
        textColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }

  _goToAddMemberPage() {
    GeneralNavigator(context, AddMemberPage()).navigate();
  }

  _goToAddEmployeePage() {
    GeneralNavigator(context, AddEmployeePage()).navigate();
  }
}
