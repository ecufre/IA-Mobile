import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/member.dart';
import 'package:ia_mobile/src/screens/members/detail_member.dart';
import 'package:ia_mobile/src/screens/menu_drawer/menu_drawer.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  bool _isLoading = true;

  TextEditingController _searchController = TextEditingController();
  FocusNode textSearchFocusNode = FocusNode();

  List<Member> _listMembers = List();
  List<Member> _listFilterMembers = List();
  _HomePageState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() => _search = "");
        _filterMembers();
      } else {
        setState(() => _search = _searchController.text);
        _filterMembers();
      }
    });
  }

  void _resetTextFocus() {
    textSearchFocusNode.unfocus();
  }

  @override
  void initState() {
    _getMembers();
    super.initState();
  }

  _getMembers() {
    ApiModule().getMembers().then((result) {
      setState(() {
        _isLoading = false;
        _listMembers = result;
        _listFilterMembers.addAll(_listMembers);
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text(
        LocaleSingleton.strings.search,
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
        : GestureDetector(
            onTap: () => _resetTextFocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _searchbar(),
                  _members(),
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
        function: () => _filterMembers(),
      ),
    );
  }

  Widget _members() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        shrinkWrap: true,
        addRepaintBoundaries: true,
        itemCount: _listFilterMembers.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Padding(
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
                      _listFilterMembers[index].name,
                      style: TextStyle(
                        fontFamily: 'WorkSans Regular',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
            onTap: () => GeneralNavigator(
                context,
                DetailMemeberPage(
                  member: _listFilterMembers[index],
                )).navigate(),
          );
        },
      ),
    );
  }

  _filterMembers() {
    _listFilterMembers.clear();
    setState(() {
      _listMembers.forEach((item) {
        if (item.name
            .toString()
            .toLowerCase()
            .contains(_search.toLowerCase())) {
          _listFilterMembers.add(item);
        }
      });
    });
  }
}
