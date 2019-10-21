import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _CreateUserPageState createState() => new _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          _button("Agregar Administrativo", () {}),
          SizedBox(height: 20.0),
          _button("Agregar Profesor", () {}),
          SizedBox(height: 20.0),
          _button("Agregar Socio", () {}),
        ],
      ),
    );
  }

  Widget _button(String text, function) {
    return CustomRaisedButton(
      text: text,
      function: () => function(),
      context: context,
      buttonColor: Ui.primaryColor,
      textColor: Colors.white,
      elevation: 0.0,
      fontSize: 17.0,
      fontFamily: 'WorkSans Regular',
      circularRadius: 5.0,
      height: 50.0,
    );
  }
}
