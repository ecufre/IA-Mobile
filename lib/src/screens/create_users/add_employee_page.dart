import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ia_mobile/src/commons/enums/ConnectivityStatus.dart';
import 'package:ia_mobile/src/commons/enums/formEmployee.dart';
import 'package:ia_mobile/src/commons/general_regex.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/error_case.dart';
import 'package:ia_mobile/src/helpers/validator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/employeeType.dart';
import 'package:ia_mobile/src/providers/connectivity_service.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/custom_text_field.dart';
import 'package:ia_mobile/src/widgets/successful_popup.dart';
import 'package:provider/provider.dart';

class AddEmployeePage extends StatefulWidget {
  @override
  _AddEmployeePageState createState() => new _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FormEmployee _formType = FormEmployee.pageOne;
  Validator validator = Validator();
  List<String> _sexList = ["Masculino", "Femenino"];
  List<EmployeeType> _employeeTypeList = List();
  List<bool> _noErrors = [];
  String _name;
  String _lastName;
  String _email;
  String _sex;
  String _dni;
  String _salary;
  String _cbu;
  String _cuit;
  EmployeeType _employeeType;
  bool _isLoading = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _amountPerHourController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _cbuController = TextEditingController();
  TextEditingController _cuitController = TextEditingController();

  FocusNode textNameFocusNode = FocusNode();
  FocusNode textLastNameFocusNode = FocusNode();
  FocusNode textEmailFocusNode = FocusNode();
  FocusNode textDniFocusNode = FocusNode();
  FocusNode textAmountPerHourFocusNode = FocusNode();
  FocusNode textSalaryFocusNode = FocusNode();
  FocusNode textCbuFocusNode = FocusNode();
  FocusNode textCuitFocusNode = FocusNode();

  void _resetTextFocus() {
    textNameFocusNode.unfocus();
    textLastNameFocusNode.unfocus();
    textLastNameFocusNode.unfocus();
    textDniFocusNode.unfocus();
    textAmountPerHourFocusNode.unfocus();
    textSalaryFocusNode.unfocus();
    textCbuFocusNode.unfocus();
    textCuitFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dniController.dispose();
    _amountPerHourController.dispose();
    _salaryController.dispose();
    _cbuController.dispose();
    _cuitController.dispose();
    super.dispose();
  }

  _confirmErrors(bool state) {
    setState(() {
      _noErrors.add(state);
    });
  }

  @override
  void initState() {
    _getEmployeeTypes();
    super.initState();
  }

  _getEmployeeTypes() {
    ApiModule().getEmployeeTypes().then((result) {
      setState(() {
        _employeeTypeList = result;
        _isLoading = false;
      });
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
    return _isLoading
        ? ColorLoaderPopup()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _pageWidget(),
            ),
          );
  }

  Widget _pageWidget() {
    switch (_formType) {
      case FormEmployee.pageOne:
        return _pageOne();
      case FormEmployee.pageTwo:
        return _pageTwo();
      case FormEmployee.Detail:
        return _pageDetail();
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
          text: LocaleSingleton.strings.carryOn.toUpperCase(),
          function: () => _moveToPageDetail(),
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

  Widget _pageDetail() {
    return Column(children: <Widget>[
      _pageDetailWidgets(),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              CustomRaisedButton(
                text: LocaleSingleton.strings.update.toUpperCase(),
                function: () => _moveToPageOne(),
                context: context,
                buttonColor: Ui.primaryColor,
                textColor: Colors.white,
                fontSize: 17.5,
                fontFamily: 'WorkSans Bold',
                circularRadius: 3.5,
              ),
              SizedBox(height: 20.0),
              CustomRaisedButton(
                text: LocaleSingleton.strings.accept.toUpperCase(),
                function: () => _submit(),
                context: context,
                buttonColor: Ui.primaryColor,
                textColor: Colors.white,
                fontSize: 17.5,
                fontFamily: 'WorkSans Bold',
                circularRadius: 3.5,
              ),
            ],
          ))
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
          _builtCbu(),
          _builtCuit(),
          _builtSex(),
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
          _employeeType != null ? _builtSalary() : SizedBox(),
        ],
      ),
    );
  }

  Widget _pageDetailWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          _titleDetails(LocaleSingleton.strings.personalData),
          SizedBox(height: 10.0),
          _personalDataDetails(),
          SizedBox(height: 10.0),
          _titleDetails(LocaleSingleton.strings.employeeType),
          _employeeTypeDetails(),
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
        onSaved: (val) => _dni = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.dniError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          WhitelistingTextInputFormatter(
            GeneralRegex.regexOnlyNumbers,
          ),
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
          FocusScope.of(context).requestFocus(textCbuFocusNode);
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

  Widget _builtCbu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _cbuController,
        focusNode: textCbuFocusNode,
        key: Key('cbu'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textCuitFocusNode);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.cbu.toUpperCase(),
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
        onSaved: (val) => _cbu = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.cbuError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(22),
          WhitelistingTextInputFormatter(
            GeneralRegex.regexOnlyNumbers,
          ),
        ],
      ),
    );
  }

  Widget _builtCuit() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _cuitController,
        focusNode: textCuitFocusNode,
        key: Key('cuit'),
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
          labelText: LocaleSingleton.strings.cuit.toUpperCase(),
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
        onSaved: (val) => _cuit = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.cuitError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
          WhitelistingTextInputFormatter(
            GeneralRegex.regexOnlyNumbers,
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

  Widget _builtSalary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _salaryController,
        focusNode: textSalaryFocusNode,
        key: Key('salary'),
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
          labelText: _employeeType.description.toLowerCase() ==
                  LocaleSingleton.strings.externalProfessor.toLowerCase()
              ? LocaleSingleton.strings.amoutPerHour.toUpperCase()
              : LocaleSingleton.strings.salary.toUpperCase(),
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
        onSaved: (val) => _salary = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.salaryError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
      ),
    );
  }

  Widget _titleDetails(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'WorkSans Bold',
        fontSize: 23.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _personalDataDetails() {
    return Card(
      elevation: 3.0,
      child: Column(
        children: <Widget>[
          _detail(LocaleSingleton.strings.name, _name),
          Divider(),
          _detail(LocaleSingleton.strings.lastName, _lastName),
          Divider(),
          _detail(LocaleSingleton.strings.dni, _dni),
          Divider(),
          _detail(LocaleSingleton.strings.sex, _sex),
          Divider(),
          _detail(LocaleSingleton.strings.email, _email),
          Divider(),
          _detail(LocaleSingleton.strings.cbu, _cbu),
          Divider(),
          _detail(LocaleSingleton.strings.cuit, _cuit),
        ],
      ),
    );
  }

  Widget _employeeTypeDetails() {
    return Card(
      elevation: 3.0,
      child: Column(
        children: <Widget>[
          _detail(
              LocaleSingleton.strings.employeeType, _employeeType.description),
          Divider(),
          _detail(
              _employeeType.id == 3
                  ? LocaleSingleton.strings.amoutPerHour
                  : LocaleSingleton.strings.monthWork,
              _salary),
          Divider(),
        ],
      ),
    );
  }

  Widget _detail(
    String title,
    String message,
  ) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Bold',
          fontSize: 17.0,
        ),
      ),
      subtitle: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
      ),
    );
  }

  _pageOneWidgetValidation() {
    return _sex != null;
  }

  _pageTwoWidgetValidation() {
    return _employeeType != null;
  }

  _moveToPageOne() {
    _resetTextFocus();
    try {
      setState(() {
        _formType = FormEmployee.pageOne;
        _nameController.text = _name;
        _lastNameController.text = _lastName;
        _dniController.text = _dni;
        _emailController.text = _email;
        _cbuController.text = _cbu;
        _cuitController.text = _cuit;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _moveToPageTwo() {
    _resetTextFocus();
    final FormState form = _formkey.currentState;
    if (_validateAndSave(_pageOneWidgetValidation)) {
      form.reset();
      try {
        setState(() {
          _formType = FormEmployee.pageTwo;
          _salaryController.text = _salary;
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _moveToPageDetail() {
    _resetTextFocus();
    final FormState form = _formkey.currentState;
    if (_validateAndSave(_pageTwoWidgetValidation)) {
      form.reset();
      try {
        setState(() {
          _formType = FormEmployee.Detail;
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

  void _submit() async {
    try {
      _checkConnectivity(_createAction);
    } catch (e) {
      print(e.toString());
    }
  }

  _createAction() {
    setState(() {
      _isLoading = true;
    });
    ApiModule()
        .createEmployee(_name, _lastName, _dni, _email, _sex, _cbu, _cuit,
            DateTime.now(), double.parse(_salary), _employeeType)
        .then((result) {
      setState(() {
        _isLoading = false;
      });
      _showPopup("Se creó el empleado ${result.name} ${result.lastName}");
    }).catchError((error) {
      Navigator.pop(context);
      errorCase(error.message, context);
    });
  }

  void _showPopup(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          SuccessfulPopup(message: message, context: context, function: _back),
    );
  }

  _back() {
    Navigator.pop(context);
  }
}
