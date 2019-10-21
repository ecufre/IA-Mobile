import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/people.dart';
import 'package:ia_mobile/src/services/modules/people.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List<People> _list;

  @override
  void initState() {
    _getListPeople();
    super.initState();
  }

  _getListPeople() {
    PeopleModule().getListPeople().then((result) {
      setState(() {
        _list = result;
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
        LocaleSingleton.strings.appTitle,
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
    return _isLoading ? ColorLoaderPopup() : _listPeople();
  }

  Widget _listPeople() {
    return ListView.builder(
        shrinkWrap: true,
        addRepaintBoundaries: true,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_list[index].name),
            subtitle: Text(_list[index].id.toString()),
          );
        });
  }
}
