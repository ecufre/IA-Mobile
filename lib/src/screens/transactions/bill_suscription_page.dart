import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/error_case.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/member.dart';
import 'package:ia_mobile/src/models/passes_type.dart';
import 'package:ia_mobile/src/models/payment_method.dart';
import 'package:ia_mobile/src/screens/transactions/card_page.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/successful_page.dart';
import 'package:ia_mobile/src/widgets/successful_popup.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BillSuscriptionPage extends StatefulWidget {
  BillSuscriptionPage({@required this.member});
  final Member member;
  @override
  _BillSuscriptionPageState createState() => new _BillSuscriptionPageState();
}

class _BillSuscriptionPageState extends State<BillSuscriptionPage> {
  bool _isLoading = true;
  List<PassesType> _passesTypeList = List();
  List<PaymentMethod> _methodsOfPaymentList = List();
  PassesType _passesType;
  PaymentMethod _methodOfPayment;
  DateTime _upToDate;
  String _cardNumber;
  String _expiryDate;
  String _cvvCode;

  @override
  void initState() {
    _getPassesType();

    super.initState();
  }

  _getPaymentMethods() async {
    ApiModule().getPaymentMethods().then((result) {
      setState(() {
        _methodsOfPaymentList = result;
        _isLoading = false;
      });
    }).catchError((error) {
      errorCase(error.message, context);
    });
  }

  _getPassesType() {
    ApiModule().getPassesType().then((result) {
      setState(() {
        _passesTypeList = result;
        _getPaymentMethods();
      });
    }).catchError((error) {
      errorCase(error.message, context);
      Navigator.pop(context);
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
        LocaleSingleton.strings.billSubscription,
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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              _suscriptionType(),
              _sinceAndUpToDetail(),
              _methodsOfPayment(),
              _addCreditCardButton(),
              _button(),
            ],
          );
  }

  Widget _suscriptionType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(color: Colors.black38),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
            key: widget.key,
            isExpanded: true,
            hint: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  LocaleSingleton.strings.suscriptionType,
                  style: TextStyle(
                    fontFamily: 'WorkSans Regular',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                )),
            items: _passesTypeList.map(
              (dropDownItem) {
                return DropdownMenuItem<dynamic>(
                  value: dropDownItem,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${dropDownItem.name} - \$${dropDownItem.price.toString()}",
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
              _upToDateMethod(newValueSelected);
              setState(() {
                _passesType = newValueSelected;
              });
            },
            value: _passesTypeList.contains(_passesType) ? _passesType : null,
          ),
        ),
      ),
    );
  }

  _upToDateMethod(PassesType value) {
    setState(() {
      switch (value.id) {
        case 15:
          _upToDate = DateTime.now().add(Duration(days: 1));
          break;
        case 16:
          _upToDate = DateTime.now().add(Duration(days: 7));
          break;
        case 17:
          _upToDate = DateTime.now().add(Duration(days: 15));
          break;
        case 18:
          _upToDate = DateTime.now().add(Duration(days: 30));
          break;
        case 19:
          _upToDate = DateTime.now().add(Duration(days: 60));
          break;
        case 20:
          _upToDate = DateTime.now().add(Duration(days: 90));
          break;
        case 21:
          _upToDate = DateTime.now().add(Duration(days: 180));
          break;
        case 22:
          _upToDate = DateTime.now().add(Duration(days: 365));
          break;
      }
    });
  }

  Widget _sinceAndUpToDetail() {
    initializeDateFormatting();
    return _passesType != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    border: Border.all(color: Colors.black38),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(LocaleSingleton.strings.since),
                        Text(DateFormat.yMd('es_AR')
                            .format(new DateTime.now())
                            .toString()),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    border: Border.all(color: Colors.black38),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(LocaleSingleton.strings.upTo),
                        Text(DateFormat.yMd('es_AR')
                            .format(_upToDate)
                            .toString())
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : SizedBox();
  }

  Widget _methodsOfPayment() {
    return Padding(
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
                  LocaleSingleton.strings.methodsOfPayment,
                  style: TextStyle(
                    fontFamily: 'WorkSans Regular',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                )),
            items: _methodsOfPaymentList.map(
              (dropDownItem) {
                return DropdownMenuItem<dynamic>(
                  value: dropDownItem,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      dropDownItem.name,
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
                _methodOfPayment = newValueSelected;
              });
            },
            value: _methodsOfPaymentList.contains(_methodOfPayment)
                ? _methodOfPayment
                : null,
          ),
        ),
      ),
    );
  }

  Widget _addCreditCardButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cardNumber == null
              ? Container(
                  height: 115,
                  width: 125,
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/icons/cards_icon.png",
                            scale: 11.0,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            LocaleSingleton.strings.addCreditCard,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'WorkSans Bold',
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () => GeneralNavigator(
                      context,
                      CardPage(
                        name: "${widget.member.name} ${widget.member.lastName}",
                        function: (number, date, code) =>
                            _addCard(number, date, code),
                      ),
                    ).navigate(),
                    color: Ui.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(60.5),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    border: Border.all(color: Colors.black38),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/icons/card_icon.png",
                          scale: 11.0,
                        ),
                        Text(
                          LocaleSingleton.strings.cardAdded,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ))
        ],
      ),
    );
  }

  _addCard(String number, String date, String code) {
    setState(() {
      _cardNumber = number;
      _expiryDate = date;
      _cvvCode = code;
    });
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: CustomRaisedButton(
        text: LocaleSingleton.strings.billing.toUpperCase(),
        function: _passesType != null && _methodOfPayment != null
            ? () => _submit()
            : null,
        context: context,
        buttonColor: Ui.primaryColor,
        textColor: Colors.white,
        fontSize: 17.5,
        fontFamily: 'WorkSans Bold',
        circularRadius: 3.5,
      ),
    );
  }

  _submit() {
    setState(() => _isLoading = true);
    ApiModule().createBill(widget.member.id, _passesType.id).then((result) {
      _payBill(result.id, _methodOfPayment.id);
    }).catchError((error) {
      errorCase(error.message, context);
      Navigator.pop(context);
    });
  }

  _payBill(int idBill, int idPaymentMethod) {
    ApiModule().payBill(idBill, idPaymentMethod).then((result) {
      setState(() {
        _isLoading = false;
      });
      if (result is bool) {
        if (result) {
          _openConfirmPopup();
        }
      } else {
        _showPopup(result);
      }
    });
  }

  void _showPopup(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => SuccessfulPopup(
        message: message,
        context: context,
        function: _back,
      ),
    );
  }

  _back() {
    Navigator.pop(context);
  }

  _openConfirmPopup() {
    Navigator.pop(context);
    GeneralNavigator(
        context,
        SuccessfulPage(
          message: "Se realizó el pago",
        )).navigate();
  }
}
