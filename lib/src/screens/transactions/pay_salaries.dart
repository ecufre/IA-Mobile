import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/screens/menu_drawer/menu_drawer.dart';

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
    "Diciembre"
  ];
  List<String> _listYears = [
    "2019",
    "2018",
    "2017",
    "2016",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009",
    "2008",
    "2007"
  ];
  List _listEmployees = [
    {"Nombre": "Matias", "Año": "2019", "Tipo": "Administrador"},
    {"Nombre": "Javier", "Año": "2019", "Tipo": "Profesor"},
    {"Nombre": "Carlos", "Año": "2019", "Tipo": "Administrador"},
    {"Nombre": "Pedro", "Año": "2019", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2018", "Tipo": "Profesor"},
    {"Nombre": "Carlos", "Año": "2018", "Tipo": "Administrador"},
    {"Nombre": "Matias", "Año": "2018", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2017", "Tipo": "Profesor"},
    {"Nombre": "Javier", "Año": "2017", "Tipo": "Administrador"},
    {"Nombre": "Pedro", "Año": "2016", "Tipo": "Administrador"},
    {"Nombre": "Matias", "Año": "2016", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2016", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2015", "Tipo": "Administrador"},
    {"Nombre": "Pedro", "Año": "2014", "Tipo": "Administrador"},
    {"Nombre": "Javier", "Año": "2014", "Tipo": "Administrador"},
    {"Nombre": "Pedro", "Año": "2014", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2014", "Tipo": "Administrador"},
    {"Nombre": "Matias", "Año": "2013", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2013", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2012", "Tipo": "Administrador"},
    {"Nombre": "Javier", "Año": "2012", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2012", "Tipo": "Profesor"},
    {"Nombre": "Javier", "Año": "2012", "Tipo": "Administrador"},
    {"Nombre": "Pedro", "Año": "2011", "Tipo": "Administrador"},
    {"Nombre": "Pedro", "Año": "2011", "Tipo": "Profesor"},
    {"Nombre": "Matias", "Año": "2011", "Tipo": "Administrador"},
    {"Nombre": "Carlos", "Año": "2010", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2010", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2009", "Tipo": "Administrador"},
    {"Nombre": "Carlos", "Año": "2008", "Tipo": "Profesor"},
    {"Nombre": "Pedro", "Año": "2007", "Tipo": "Administrador"},
  ];
  String _month;
  String _year;
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
              onPressed: () {},
              color: Ui.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.5)),
              ),
            ),
          ),
          SizedBox(height: 20.0),
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
        ],
      ),
    );
  }

  Widget _listUsers() {
    return Column(
      children: <Widget>[
        Container(
          height: 47.0,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text(
              LocaleSingleton.strings.payAll.toUpperCase(),
              style: TextStyle(
                fontSize: 17.5,
                fontFamily: 'WorkSans Bold',
              ),
            ),
            onPressed: () {},
            color: Ui.primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.5)),
            ),
          ),
        ),
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
                              AssetImage("assets/images/anonymous_user.png"),
                        ),
                        title: Text(
                          _listEmployees[index]["Nombre"],
                          style: TextStyle(
                            fontFamily: 'WorkSans Regular',
                            fontSize: 15.0,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _listEmployees[index]["Tipo"],
                              style: TextStyle(
                                fontFamily: 'WorkSans Regular',
                                fontSize: 13.0,
                              ),
                            ),
                            Text(
                              _listEmployees[index]["Año"],
                              style: TextStyle(
                                fontFamily: 'WorkSans Regular',
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ))),
                onTap: () {},
              );
            }),
      ],
    );
  }
}
