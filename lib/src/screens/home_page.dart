import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/enums/tabItem.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/screens/create_users/create_user_page.dart';
import 'package:ia_mobile/src/screens/menu_drawer/menu_drawer.dart';
import 'package:ia_mobile/src/screens/search/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem currentItem = TabItem.SEARCH_PAGE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: _appBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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

  Widget _buildBody() {
    switch (currentItem) {
      case TabItem.SEARCH_PAGE:
        return SearchPage();
      case TabItem.ADD_PAGE:
        return CreateUserPage();
    }

    return SearchPage();
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _navBarOptions(),
        ),
      ),
    );
  }

  List<Widget> _navBarOptions() {
    List<Widget> list = [
      _buildItem(
        icon: Icons.search,
        tabItem: TabItem.SEARCH_PAGE,
        text: LocaleSingleton.strings.search,
      ),
      _buildItem(
        icon: Icons.person_add,
        tabItem: TabItem.ADD_PAGE,
        text: LocaleSingleton.strings.add,
      ),
    ];
    list.removeWhere((value) => value == null);
    return list.toList();
  }

  Widget _buildItem({IconData icon, TabItem tabItem, String text}) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  color: _iconColorMatching(item: tabItem),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: _colorTextMatching(item: tabItem),
                    fontSize: 14.0,
                    fontFamily: 'WorkSans Bold',
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => _updateCurrentItem(item: tabItem),
      ),
    );
  }

  _updateCurrentItem({TabItem item}) {
    setState(() {
      currentItem = item;
    });
  }

  Color _iconColorMatching({TabItem item}) {
    return currentItem == item ? Ui.primaryColor : null;
  }

  Color _colorTextMatching({TabItem item}) {
    return currentItem == item ? Ui.primaryColor : Colors.black87;
  }
}
