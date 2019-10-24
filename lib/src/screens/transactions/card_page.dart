import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ia_mobile/src/commons/general_regex.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/custom_text_field.dart';

class CardPage extends StatefulWidget {
  CardPage({this.name, this.function});
  final String name;
  final function;
  @override
  _CardPageState createState() => new _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _cardNumber = "";
  String _expiryDate = "";
  String _cvvCode = "";
  bool isCvvFocused = false;
  List<bool> _noErrors = [];

  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvCodeController = TextEditingController();

  FocusNode textCardNumberFocusNode = FocusNode();
  FocusNode textExpiryDateFocusNode = FocusNode();
  FocusNode textCvvCodeFocusNode = FocusNode();

  void _resetTextFocus() {
    textCardNumberFocusNode.unfocus();
    textExpiryDateFocusNode.unfocus();
    textCvvCodeFocusNode.unfocus();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvCodeController.dispose();

    super.dispose();
  }

  _confirmErrors(bool state) {
    setState(() {
      _noErrors.add(state);
    });
  }

  _CardPageState() {
    _cardNumberController.addListener(() {
      if (_cardNumberController.text.isNotEmpty) {
        setState(() {
          _cardNumber = _cardNumberController.text;
          isCvvFocused = false;
        });
      } else {
        setState(() {
          _cardNumber = "";
          isCvvFocused = false;
        });
      }
    });
    _expiryDateController.addListener(() {
      if (_expiryDateController.text.isNotEmpty) {
        setState(() {
          _expiryDate = _expiryDateController.text;
          isCvvFocused = false;
          ;
        });
      } else {
        setState(() {
          _expiryDate = "";
          isCvvFocused = false;
        });
      }
    });

    _cvvCodeController.addListener(() {
      if (_cvvCodeController.text.isNotEmpty) {
        setState(() {
          _cvvCode = _cvvCodeController.text;
          isCvvFocused = true;
        });
      } else {
        setState(() {
          _cvvCode = "";
          isCvvFocused = false;
        });
      }
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
        LocaleSingleton.strings.addCard,
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
      child: GestureDetector(
        onTap: () => _resetTextFocus(),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              _builtCard(),
              _builtCardNumber(),
              _builtCardExpiryDate(),
              _builtCvvCode(),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builtCard() {
    return CreditCardWidget(
      cardNumber: _cardNumber,
      expiryDate: _expiryDate,
      cardHolderName: widget.name.toUpperCase(),
      cvvCode: _cvvCode,
      showBackView: isCvvFocused, //true when you want to show cvv(back) view
    );
  }

  Widget _builtCardNumber() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _cardNumberController,
        focusNode: textCardNumberFocusNode,
        key: Key('card_number'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textExpiryDateFocusNode);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.cardNumber.toUpperCase(),
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
        onSaved: (val) => _cardNumber = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.cardNumberError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(16),
        ],
      ),
    );
  }

  Widget _builtCardExpiryDate() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _expiryDateController,
        focusNode: textExpiryDateFocusNode,
        key: Key('expiry_date'),
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(textCvvCodeFocusNode);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: LocaleSingleton.strings.expiryDate.toUpperCase(),
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
        onSaved: (val) => _expiryDate = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.expiryDateError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
        ],
      ),
    );
  }

  Widget _builtCvvCode() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: CustomTextFormField(
        controller: _cvvCodeController,
        focusNode: textCvvCodeFocusNode,
        key: Key('cvv_code'),
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
          labelText: LocaleSingleton.strings.cvvCode.toUpperCase(),
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
        onSaved: (val) => _cvvCode = val,
        validator: (val) =>
            val.isEmpty ? LocaleSingleton.strings.cvvCodeError : null,
        textCapitalization: TextCapitalization.sentences,
        noErrorsCallback: (bool val) => _confirmErrors(val),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
          WhitelistingTextInputFormatter(
            GeneralRegex.regexOnlyNumbers,
          ),
        ],
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: CustomRaisedButton(
        text: LocaleSingleton.strings.accept.toUpperCase(),
        function: () => _validateAndSubmit(),
        context: context,
        buttonColor: Ui.primaryColor,
        textColor: Colors.white,
        fontSize: 17.5,
        fontFamily: 'WorkSans Bold',
        circularRadius: 3.5,
      ),
    );
  }

  bool _validateAndSave() {
    final form = _formkey.currentState;
    form.validate();
    if (!_noErrors.contains(false)) {
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
    if (_validateAndSave()) {
      try {
        widget.function(_cardNumber, _expiryDate, _cvvCode);
        _saveCard();
      } catch (e) {
        print(e.toString());
      }
    }
  }

  _saveCard() {
    Navigator.pop(context);
  }
}
