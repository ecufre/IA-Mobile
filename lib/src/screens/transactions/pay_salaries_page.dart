import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/employee.dart';
import 'package:ia_mobile/src/screens/menu_drawer/menu_drawer.dart';
import 'package:ia_mobile/src/screens/transactions/pay_salaries_detail_page.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';

class PaySalariesPage extends StatefulWidget {
  @override
  _PaySalariesPageState createState() => new _PaySalariesPageState();
}

class _PaySalariesPageState extends State<PaySalariesPage> {
  List<String> _listMonths = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre",
  ];
  List<String> _listYears = [
    "2019",
    "2018",
    "2017",
  ];
  List<Employee> _listEmployees = List();
  String _month;
  String _year;

  _searchEmployees(int month, int year) {
    ApiModule().getLiquidationEmployees(month, year).then((result) {
      setState(() {
        _listEmployees = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: MenuDrawer(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        LocaleSingleton.strings.paySalaries,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _monthFilter(),
            Divider(),
            _listUsers(),
          ],
        ),
      ),
    );
  }

  Widget _monthFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
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
                    hint: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          LocaleSingleton.strings.month,
                          style: TextStyle(
                            fontFamily: 'WorkSans Regular',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        )),
                    items: _listMonths.map(
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
                        _month = newValueSelected;
                      });
                    },
                    value: _listMonths.contains(_month) ? _month : null,
                  ),
                ),
              ),
              // SizedBox(width: 20.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
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
                    hint: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          LocaleSingleton.strings.year,
                          style: TextStyle(
                            fontFamily: 'WorkSans Regular',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        )),
                    items: _listYears.map(
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
                        _year = newValueSelected;
                      });
                    },
                    value: _listYears.contains(_year) ? _year : null,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            height: 47.0,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              child: Text(
                LocaleSingleton.strings.search.toUpperCase(),
                style: TextStyle(
                  fontSize: 17.5,
                  fontFamily: 'WorkSans Bold',
                ),
              ),
              onPressed: _month != null && _year != null
                  ? () =>
                      _searchEmployees(_getMonthCode(_month), int.parse(_year))
                  : null,
              color: Ui.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listUsers() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        ListView.builder(
          shrinkWrap: true,
          addRepaintBoundaries: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _listEmployees.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        AssetImage("assets/icons/dumbbell_icon.png"),
                  ),
                  title: Text(
                    _listEmployees[index].name,
                    style: TextStyle(
                      fontFamily: 'WorkSans Regular',
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                GeneralNavigator(
                  context,
                  PaySalariesDetailPage(
                    employee: _listEmployees[index],
                    month: _getMonthCode(_month),
                    year: int.parse(_year),
                  ),
                ).navigate();
              },
            );
          },
        ),
      ],
    );
  }

  int _getMonthCode(String month) {
    switch (month) {
      case "Enero":
        return 1;
      case "Febrero":
        return 2;
      case "Marzo":
        return 3;
      case "Abril":
        return 4;
      case "Mayo":
        return 5;
      case "Junio":
        return 6;
      case "Julio":
        return 7;
      case "Agosto":
        return 8;
      case "Septiembre":
        return 9;
      case "Octubre":
        return 10;
      case "Noviembre":
        return 11;
      case "Diciembre":
        return 12;
      default:
        return 0;
    }
  }
}
