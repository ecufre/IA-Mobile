import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/error_case.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/member.dart';
import 'package:ia_mobile/src/models/passes_type.dart';
import 'package:ia_mobile/src/models/payment_method.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/successful_popup.dart';

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
            border: Border.all(color: Colors.black38)),
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
    return _passesType != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Desde"),
                Text(DateTime.now().toString()),
                Text("Hasta"),
                Text(_upToDate.toString())
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
      setState(() {
        _isLoading = false;
      });
      _showPopup(
          "Se creó la factura ${result.id} con monto de \$${result.amount}");
    }).catchError((error) {
      errorCase(error.message, context);
      Navigator.pop(context);
    });
  }

  void _showPopup(String message) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          SuccessfulPopup(message: message, context: context),
    );
  }
}
