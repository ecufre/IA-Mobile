import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';

class SuccessfulPage extends StatefulWidget {
  @override
  _SuccessfulPageState createState() => new _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ui.primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 150.0),
        Image.asset(
          'assets/icons/icono_check.png',
          color: Colors.white,
          scale: 0.5,
        ),
        _bodyMessage(),
        Expanded(
          child: SizedBox(),
        ),
        _buttonCancel(),
      ],
    );
  }

  Widget _bodyMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        "Se realizó el pago",
        style: TextStyle(
          fontFamily: 'WorkSans Bold',
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  _finishOperation() {
    Navigator.pop(context);
  }

  Widget _buttonCancel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
      child: CustomRaisedButton(
        text: LocaleSingleton.strings.accept.toUpperCase(),
        function: () => _finishOperation(),
        context: context,
        fontSize: 17.5,
        buttonColor: Colors.white,
        textColor: Colors.black,
        fontFamily: 'WorkSans Bold',
        circularRadius: 3.5,
      ),
    );
  }
}
