import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ia_mobile/src/commons/enums/ConnectivityStatus.dart';
import 'package:ia_mobile/src/commons/enums/formMember.dart';
import 'package:ia_mobile/src/commons/general_regex.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/validator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/providers/connectivity_service.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddMemberPage extends StatefulWidget {
  @override
  _AddMemberPageState createState() => new _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FormMember _formType = FormMember.pageOne;
  Validator validator = Validator();
  List<String> _sexList = ["Masculino", "Femenino"];
  List<bool> _noErrors = [];
  String _name;
  String _lastName;
  String _email;
  String _dni;
  String _sex;
  String _doctor;
  String _date;
  String _doctorPhone;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _doctorController = TextEditingController();
  TextEditingController _doctorPhoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  FocusNode textNameFocusNode = FocusNode();
  FocusNode textLastNameFocusNode = FocusNode();
  FocusNode textEmailFocusNode = FocusNode();
  FocusNode textDniFocusNode = FocusNode();
  FocusNode textDoctorFocusNode = FocusNode();
  FocusNode textDoctorPhoneFocusNode = FocusNode();
  FocusNode textDateFocusNode = FocusNode();

  void _resetTextFocus() {
    textNameFocusNode.unfocus();
    textLastNameFocusNode.unfocus();
    textLastNameFocusNode.unfocus();
    textDniFocusNode.unfocus();
    textDoctorFocusNode.unfocus();
    textDoctorPhoneFocusNode.unfocus();
    textDateFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dniController.dispose();
    _doctorController.dispose();
    _doctorPhoneController.dispose();
    _dateController.dispose();
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
        LocaleSingleton.strings.addMember,
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
      case FormMember.Detail:
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
          _builtDoctor(),
          _builtDoctorPhone(),
          _builtDate(),
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
          _personalDataDetails(),
          SizedBox(height: 10.0),
          _titleDetails(LocaleSingleton.strings.medicalData),
          _medicalDataDetails(),
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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

  // Widget _builtState() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: CheckboxListTile(
  //       title: Text(
  //         _state
  //             ? LocaleSingleton.strings.enable
  //             : LocaleSingleton.strings.disable,
  //         style: TextStyle(
  //           fontFamily: 'WorkSans Regular',
  //           fontSize: 15,
  //           color: Colors.black,
  //         ),
  //       ),
  //       value: _state,
  //       onChanged: (value) {
  //         setState(() => _state = value);
  //       },
  //     ),
  //   );
  // }

  Widget _builtDoctor() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _doctorController,
        focusNode: textDoctorFocusNode,
        key: Key('doctor'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textDoctorPhoneFocusNode);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.doctor.toUpperCase(),
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
        onSaved: (val) => _doctor = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.doctorError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
        ],
      ),
    );
  }

  Widget _builtDoctorPhone() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _doctorPhoneController,
        focusNode: textDoctorPhoneFocusNode,
        key: Key('doctorPhone'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textDateFocusNode);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.doctorPhone.toUpperCase(),
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
        onSaved: (val) => _doctorPhone = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.doctorPhoneError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
        ],
      ),
    );
  }

  Widget _builtDate() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _dateController,
        focusNode: textDateFocusNode,
        key: Key('date'),
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
          labelText: LocaleSingleton.strings.date.toUpperCase(),
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
        onSaved: (val) => _date = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.dateError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(75),
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
        ],
      ),
    );
  }

  Widget _medicalDataDetails() {
    return Card(
      child: Column(
        children: <Widget>[
          _detail(LocaleSingleton.strings.doctor, _doctor),
          Divider(),
          _detail(LocaleSingleton.strings.doctorPhone, _doctorPhone),
          Divider(),
          _detail(LocaleSingleton.strings.date, _date),
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
    return true;
  }

  _moveToPageOne() {
    _resetTextFocus();
    try {
      setState(() {
        _formType = FormMember.pageOne;
        _nameController.text = _name;
        _lastNameController.text = _lastName;
        _dniController.text = _dni;
        _emailController.text = _email;
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
          _formType = FormMember.pageTwo;
          _dateController.text = _date;
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
          _formType = FormMember.Detail;
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
