import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/payment_method.dart';
import 'package:ia_mobile/src/services/modules/payment_method.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';

class BillSuscriptionPage extends StatefulWidget {
  @override
  _BillSuscriptionPageState createState() => new _BillSuscriptionPageState();
}

class _BillSuscriptionPageState extends State<BillSuscriptionPage> {
  bool _isLoading = true;
  List<String> _suscriptionTypeList = [
    "Día - \$20",
    "Semana - \$120",
    "Quincena - \$350",
    "Mes - \$550",
    "Semestre - \$1000",
    "Año - \$5000"
  ];
  List<PaymentMethod> _methodsOfPaymentList = List();
  String _suscription;
  String _methodOfPayment;
  DateTime _upToDate;

  @override
  void initState() {
    _getPaymentMethods();
    super.initState();
  }

  _getPaymentMethods() async {
    PaymentMethodModule().getPeymentMethods().then((result) {
      if (result['successful']) {
        setState(() => _methodsOfPaymentList = result);
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
            items: _suscriptionTypeList.map(
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
              _upToDateMethod(newValueSelected);
              setState(() {
                _suscription = newValueSelected;
              });
            },
            value: _suscriptionTypeList.contains(_suscription)
                ? _suscription
                : null,
          ),
        ),
      ),
    );
  }

  _upToDateMethod(String value) {
    setState(() {
      switch (value) {
        case "Día - \$20":
          _upToDate = DateTime.now().add(Duration(days: 1));
          break;
        case "Semana - \$120":
          _upToDate = DateTime.now().add(Duration(days: 7));
          break;
        case "Quincena - \$350":
          _upToDate = DateTime.now().add(Duration(days: 15));
          break;
        case "Mes - \$550":
          _upToDate = DateTime.now().add(Duration(days: 30));
          break;
        case "Semestre - \$1000":
          _upToDate = DateTime.now().add(Duration(days: 60));
          break;
        case "Año - \$5000":
          _upToDate = DateTime.now().add(Duration(days: 365));
          break;
      }
    });
  }

  Widget _sinceAndUpToDetail() {
    return _suscription != null
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
                      "${dropDownItem.description} - \$${dropDownItem.value}",
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
        function: _suscription != null && _methodOfPayment != null
            ? () => Navigator.pop(context)
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
}
