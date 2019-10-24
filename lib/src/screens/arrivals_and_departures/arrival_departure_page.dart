import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/error_case.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/people.dart';
import 'package:ia_mobile/src/screens/menu_drawer/menu_drawer.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/search_bar.dart';
import 'package:ia_mobile/src/widgets/successful_popup.dart';

class ArrivalAndDeparturePage extends StatefulWidget {
  @override
  _ArrivalAndDeparturePageState createState() =>
      new _ArrivalAndDeparturePageState();
}

class _ArrivalAndDeparturePageState extends State<ArrivalAndDeparturePage> {
  String _search;
  bool _isLoading = true;
  List<String> _listRols = ["SOCIO", "EMPLEADO"];
  String _rol = "EMPLEADO";

  TextEditingController _searchController = TextEditingController();
  FocusNode textSearchFocusNode = FocusNode();
  List<People> _listPeople = List();
  List<People> _listFilterPeople = List();
  List<People> _listFilterRol = List();

  _ArrivalAndDeparturePageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() => _search = "");
        _filterPeople();
      } else {
        setState(() => _search = _searchController.text);
        _filterPeople();
      }
    });
  }

  void _resetTextFocus() {
    textSearchFocusNode.unfocus();
  }

  @override
  void initState() {
    _getPeople();
    super.initState();
  }

  _getPeople() {
    ApiModule().getPeople().then((result) {
      setState(() {
        _isLoading = false;
        _listPeople = result;
        _filterRol();
        _listFilterPeople.addAll(_listFilterRol);
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
        LocaleSingleton.strings.arrivalsAndDepartures,
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
      actions: <Widget>[
        PopupMenuButton<String>(
          icon: Icon(
            Icons.filter_list,
            color: Colors.white,
          ),
          onSelected: (value) => _changeRol(value),
          itemBuilder: (BuildContext context) {
            return _listRols.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  _changeRol(String value) {
    setState(() {
      _rol = value;
      _searchController.text = "";
      _search = "";
    });
    _filterRol();
    _filterPeople();
  }

  Widget _body() {
    return _isLoading
        ? ColorLoaderPopup()
        : GestureDetector(
            onTap: () => _resetTextFocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _searchbar(),
                  _employees(),
                ],
              ),
            ),
          );
  }

  Widget _searchbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
      child: SearchBar(
        controller: _searchController,
        focusNode: textSearchFocusNode,
        keyType: TextInputType.number,
        hintText: LocaleSingleton.strings.search,
        function: () => _filterPeople(),
      ),
    );
  }

  Widget _employees() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        shrinkWrap: true,
        addRepaintBoundaries: true,
        itemCount: _listFilterPeople.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        AssetImage("assets/icons/dumbbell_icon.png"),
                  ),
                  title: Text(
                    "${_listFilterPeople[index].name} ${_listFilterPeople[index].lastName}",
                    style: TextStyle(
                      fontFamily: 'WorkSans Regular',
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _rol == "SOCIO" ? "SOCIO" : "EMPLEADO",
                        style: TextStyle(
                          fontFamily: 'WorkSans Regular',
                          fontSize: 13.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: RaisedButton(
                              child: Text(
                                "Ingreso",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans Bold",
                                ),
                              ),
                              onPressed: () =>
                                  _arrivalAction(_listFilterPeople[index]),
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            child: RaisedButton(
                              child: Text(
                                "Salida",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans Bold",
                                ),
                              ),
                              onPressed: () =>
                                  _departureAction(_listFilterPeople[index]),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }

  _filterPeople() {
    _listFilterPeople.clear();
    setState(() {
      _listFilterRol.forEach((item) {
        if (item.name
            .toString()
            .toLowerCase()
            .contains(_search.toLowerCase())) {
          _listFilterPeople.add(item);
        }
      });
    });
  }

  _filterRol() {
    _listFilterRol.clear();
    setState(() {
      _listPeople.forEach((item) {
        if (item.rols.contains(_rol)) {
          _listFilterRol.add(item);
        }
      });
    });
  }

  _arrivalAction(People people) {
    setState(() => _isLoading = true);
    ApiModule()
        .arrivalRequest(people.id, people.rols[0].toString())
        .then((result) {
      setState(() => _isLoading = false);
      _showPopup(
          "Se resgistró correctamente el ingreso de ${people.name} ${people.lastName}");
    }).catchError((error) {
      setState(() => _isLoading = false);
      errorCase(error.message, context);
    });
  }

  _departureAction(People people) {
    setState(() => _isLoading = true);
    ApiModule()
        .arrivalRequest(people.id, people.rols[0].toString())
        .then((result) {
      setState(() => _isLoading = false);
      _showPopup(
          "Se resgistró correctamente la salida de ${people.name} ${people.lastName}");
    }).catchError((error) {
      setState(() => _isLoading = false);
      errorCase(error.message, context);
    });
  }

  void _showPopup(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => SuccessfulPopup(
        message: message,
        context: context,
      ),
    );
  }
}
