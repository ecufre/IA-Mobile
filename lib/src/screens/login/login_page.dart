import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ia_mobile/src/commons/enums/ConnectivityStatus.dart';
import 'package:ia_mobile/src/commons/prefs_singleton.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/providers/app_change_notifier.dart';
import 'package:ia_mobile/src/providers/connectivity_service.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/loading_popup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  static final formLoginKey = GlobalKey<FormState>();
  String _user;
  String _password;
  FocusNode textFirstFocusNode = FocusNode();
  FocusNode textSecondFocusNode = FocusNode();
  bool _obscureText = true;
  IconData _passwordIcon = Icons.visibility_off;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    super.initState();
  }

  void _resetTextFocus() {
    textFirstFocusNode.unfocus();
    textSecondFocusNode.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _resetTextFocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _body(),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _logo(),
        _message(),
        _loginWidgets(),
        _loginButton(),
      ],
    );
  }

  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image(
            image: AssetImage('assets/images/logo_uade.png'),
            width: MediaQuery.of(context).size.width * 0.70,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      ),
    );
  }

  Widget _message() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Text(
            LocaleSingleton.strings.welcome,
            style: TextStyle(
              color: Ui.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            LocaleSingleton.strings.insertYourAccount,
            style: TextStyle(
              fontSize: 15.0,
              color: Ui.primaryColor,
              fontFamily: 'Cera Pro Regular',
            ),
          )
        ],
      ),
    );
  }

  Widget _loginWidgets() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Form(
        key: formLoginKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                key: Key('user'),
                style: new TextStyle(color: Ui.primaryColor),
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(textSecondFocusNode);
                },
                focusNode: textFirstFocusNode,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                    color: Ui.primaryColor,
                  ),
                  labelText: LocaleSingleton.strings.user,
                  counterStyle: TextStyle(
                    color: Ui.primaryColor,
                  ),
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Ui.primaryColor,
                    ),
                  ),
                ),
                autocorrect: false,
                validator: (val) =>
                    val.isEmpty ? LocaleSingleton.strings.userError : null,
                onSaved: (val) => _user = val,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                key: Key('password'),
                style: new TextStyle(color: Ui.primaryColor),
                focusNode: textSecondFocusNode,
                decoration: InputDecoration(
                  labelText: LocaleSingleton.strings.password,
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                    color: Ui.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordIcon,
                      color: Ui.primaryColor,
                    ),
                    onPressed: () => _toggle(),
                  ),
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Ui.primaryColor,
                    ),
                  ),
                ),
                autocorrect: false,
                obscureText: _obscureText,
                validator: (val) =>
                    val.isEmpty ? LocaleSingleton.strings.passwordError : null,
                onSaved: (val) => _password = val,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText) {
        _passwordIcon = Icons.visibility_off;
      } else {
        _passwordIcon = Icons.visibility;
      }
    });
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: CustomRaisedButton(
        text: "Iniciar sesión",
        function: () => _validateAndSubmit(),
        context: context,
        buttonColor: Ui.primaryColor,
        textColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }

  bool _validateAndSave() {
    final form = formLoginKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _resetTextFocus();
    if (_validateAndSave()) {
      try {
        _checkConnectivity(_loginAction);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _checkConnectivity(function) async {
    var connectionStatus =
        Provider.of<ConnectivityServiceNotifier>(context).getConnectivityStatus;
    if (connectionStatus != ConnectivityStatus.Offline) {
      function();
    } else {
      print("No hay internet");
    }
    // else {
    //   var result = await showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) => NoConnectionPopup(context: context),
    //   );
    //   if (result) {
    //     function();
    //   }
    // }
  }

  void _loginAction() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => LoadingPopup(
        future: () async {
          PrefsSingleton.prefs.setString('accessToken', "1111");
          // var result = await AuthModule().login(_ci, _password);
          // return result;
        },
        successFunction: () => Provider.of<AppGeneralNotifier>(context).login(),
        failFunction: () => {},
      ),
    );
  }
}
