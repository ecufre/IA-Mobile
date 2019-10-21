import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => new _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        CustomRaisedButton(),
      ],
    );
  }

  Widget _button(String text) {
    return CustomRaisedButton(
      text: text,
      function: () => _validateAndSubmit(),
      context: context,
      buttonColor: Ui.primaryColor,
      textColor: Colors.white,
      elevation: 0.0,
      fontFamily: 'WorkSans Regular',
    );
  }
}
