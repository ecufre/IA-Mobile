import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ia_mobile/src/commons/enums/ConnectivityStatus.dart';
import 'package:ia_mobile/src/commons/enums/formMember.dart';
import 'package:ia_mobile/src/commons/general_regex.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/validator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/employeeType.dart';
import 'package:ia_mobile/src/providers/connectivity_service.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddEmployeePage extends StatefulWidget {
  @override
  _AddEmployeePageState createState() => new _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FormMember _formType = FormMember.pageOne;
  Validator validator = Validator();
  List<String> _sexList = ["Masculino", "Femenino"];
  List<EmployeeType> _employeeTypeList = [
    EmployeeType(id: 1, description: "Administrativo", amountPerHour: "200"),
    EmployeeType(id: 2, description: "Profesor", amountPerHour: "100"),
  ];
  List<bool> _noErrors = [];
  String _name;
  String _lastName;
  String _email;
  String _sex;
  bool _state = false;
  int _dni;
  EmployeeType _employeeType;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _amountPerHourController = TextEditingController();

  FocusNode textNameFocusNode = FocusNode();
  FocusNode textLastNameFocusNode = FocusNode();
  FocusNode textEmailFocusNode = FocusNode();
  FocusNode textDniFocusNode = FocusNode();
  FocusNode textAmountPerHourFocusNode = FocusNode();

  void _resetTextFocus() {
    textNameFocusNode.unfocus();
    textLastNameFocusNode.unfocus();
    textLastNameFocusNode.unfocus();
    textDniFocusNode.unfocus();
    textAmountPerHourFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dniController.dispose();
    _amountPerHourController.dispose();
    super.dispose();
  }

  _confirmErrors(bool state) {
    setState(() {
      _noErrors.add(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        LocaleSingleton.strings.addEmployee,
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _pageWidget(),
      ),
    );
  }

  Widget _pageWidget() {
    switch (_formType) {
      case FormMember.pageOne:
        return _pageOne();
      case FormMember.pageTwo:
        return _pageTwo();
    }
    return null;
  }

  Widget _pageOne() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _pageOneWidgets(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: CustomRaisedButton(
              text: LocaleSingleton.strings.carryOn.toUpperCase(),
              function: () => _moveToPageTwo(),
              context: context,
              buttonColor: Ui.primaryColor,
              textColor: Colors.white,
              fontSize: 17.5,
              fontFamily: 'WorkSans Bold',
              circularRadius: 3.5,
            ),
          )
        ]);
  }

  Widget _pageTwo() {
    return Column(children: <Widget>[
      _pageTwoWidgets(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: CustomRaisedButton(
          text: LocaleSingleton.strings.accept.toUpperCase(),
          function: () => _checkConnectivity(() => _validateAndSubmit()),
          context: context,
          buttonColor: Ui.primaryColor,
          textColor: Colors.white,
          fontSize: 17.5,
          fontFamily: 'WorkSans Bold',
          circularRadius: 3.5,
        ),
      )
    ]);
  }

  Widget _pageOneWidgets() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          _builtName(),
          _builtLastName(),
          _builtDNI(),
          _builtEmail(),
          _builtSex(),
          //_builtState(),
        ],
      ),
    );
  }

  Widget _pageTwoWidgets() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          _builtEmployeeType(),
          _builtAmountPerHour(),
        ],
      ),
    );
  }

  Widget _builtName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _nameController,
        focusNode: textNameFocusNode,
        key: Key('name'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textLastNameFocusNode);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.name.toUpperCase(),
          labelStyle: TextStyle(
            fontFamily: 'WorkSans Regular',
            fontSize: MediaQuery.of(context).size.height <= 640 ? 15.5 : 17.5,
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Ui.primaryColor),
          ),
        ),
        autocorrect: false,
        onSaved: (val) => _name = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.nameError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
        ],
      ),
    );
  }

  Widget _builtLastName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _lastNameController,
        focusNode: textLastNameFocusNode,
        key: Key('lastName'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textDniFocusNode);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.lastName.toUpperCase(),
          labelStyle: TextStyle(
            fontFamily: 'WorkSans Regular',
            fontSize: MediaQuery.of(context).size.height <= 640 ? 15.5 : 17.5,
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Ui.primaryColor),
          ),
        ),
        autocorrect: false,
        onSaved: (val) => _lastName = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.lastNameError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
        ],
      ),
    );
  }

  Widget _builtDNI() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _dniController,
        focusNode: textDniFocusNode,
        key: Key('dni'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textEmailFocusNode);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.dni.toUpperCase(),
          labelStyle: TextStyle(
            fontFamily: 'WorkSans Regular',
            fontSize: MediaQuery.of(context).size.height <= 640 ? 15.5 : 17.5,
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Ui.primaryColor),
          ),
        ),
        autocorrect: false,
        onSaved: (val) => _lastName = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.dniError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
        ],
      ),
    );
  }

  Widget _builtEmail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _emailController,
        key: Key('email'),
        focusNode: textEmailFocusNode,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.email.toUpperCase(),
          labelStyle: TextStyle(
            fontFamily: 'WorkSans Regular',
            fontSize: MediaQuery.of(context).size.height <= 640 ? 15.5 : 17.5,
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Ui.primaryColor),
          ),
        ),
        autocorrect: false,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        validator: (val) => validator.emailValidator(val),
        onSaved: (val) => _email = val,
        keyboardType: TextInputType.emailAddress,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          WhitelistingTextInputFormatter(
            GeneralRegex.regexWithoutSpace,
          ),
        ],
      ),
    );
  }

  Widget _builtSex() {
    return GestureDetector(
      onTap: () => _resetTextFocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              border: Border.all(color: Colors.black38)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              key: widget.key,
              isExpanded: true,
              hint: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    LocaleSingleton.strings.sex,
                    style: TextStyle(
                      fontFamily: 'WorkSans Regular',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )),
              items: _sexList.map(
                (dropDownItem) {
                  return DropdownMenuItem<dynamic>(
                    value: dropDownItem,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        dropDownItem,
                        style: TextStyle(
                          fontFamily: 'WorkSans Regular',
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (dynamic newValueSelected) {
                setState(() {
                  _sex = newValueSelected;
                });
              },
              value: _sexList.contains(_sex) ? _sex : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _builtEmployeeType() {
    return GestureDetector(
      onTap: () => _resetTextFocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              border: Border.all(color: Colors.black38)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              key: widget.key,
              isExpanded: true,
              hint: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    LocaleSingleton.strings.employeeType,
                    style: TextStyle(
                      fontFamily: 'WorkSans Regular',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  )),
              items: _employeeTypeList.map(
                (dropDownItem) {
                  return DropdownMenuItem<dynamic>(
                    value: dropDownItem,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        dropDownItem.description,
                        style: TextStyle(
                          fontFamily: 'WorkSans Regular',
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (dynamic newValueSelected) {
                setState(() {
                  _employeeType = newValueSelected;
                });
              },
              value: _employeeTypeList.contains(_employeeType)
                  ? _employeeType
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _builtAmountPerHour() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _amountPerHourController,
        focusNode: textAmountPerHourFocusNode,
        key: Key('amountPerHour'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.amoutPerHour.toUpperCase(),
          labelStyle: TextStyle(
            fontFamily: 'WorkSans Regular',
            fontSize: MediaQuery.of(context).size.height <= 640 ? 15.5 : 17.5,
            color: Colors.black,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Ui.primaryColor),
          ),
        ),
        autocorrect: false,
        onSaved: (val) => _lastName = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.amoutPerHourErrro : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
        ],
      ),
    );
  }

  _pageOneWidgetValidation() {
    return _sex != null;
  }

  _pageTwoWidgetValidation() {
    return _employeeType != null;
  }

  _moveToPageTwo() {
    _resetTextFocus();
    final FormState form = _formkey.currentState;
    if (_validateAndSave(_pageOneWidgetValidation)) {
      form.reset();
      try {
        setState(() {
          _formType = FormMember.pageTwo;
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _checkConnectivity(function) {
    var connectionStatus =
        Provider.of<ConnectivityServiceNotifier>(context).getConnectivityStatus;
    if (connectionStatus != ConnectivityStatus.Offline) {
      function();
    } else {
      // showDialog(
      //   barrierDismissible: false,
      //   context: context,
      //   builder: (BuildContext context) => ErrorConnectionPopup(
      //     message: LocaleSingleton.strings.connectToInternet,
      //   ),
      // );
    }
  }

  bool _validateAndSave(validate) {
    final form = _formkey.currentState;
    form.validate();
    if (!_noErrors.contains(false) && validate()) {
      setState(() {
        _noErrors = [];
      });
      form.save();
      return true;
    }
    setState(() {
      _noErrors = [];
    });
    return false;
  }

  void _validateAndSubmit() async {
    if (_validateAndSave(_pageTwoWidgetValidation)) {
      try {
        _checkConnectivity(_createAction);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _createAction() {
    Navigator.pop(context);
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) => LoadingPopup(
    //     future: () async {
    //       //var result = await ClientBranchModule().createBranchDasa();
    //       //return result;
    //     },
    //     successFunction: () => {},
    //     failFunction: () => {},
    //   ),
    // ).then((result) {

    // });
  }
}
