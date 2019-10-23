import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/member.dart';
import 'package:ia_mobile/src/screens/transactions/bill_suscription_page.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';

class DetailMemeberPage extends StatefulWidget {
  DetailMemeberPage({this.member});
  final Member member;
  @override
  _DetailMemeberPageState createState() => new _DetailMemeberPageState();
}

class _DetailMemeberPageState extends State<DetailMemeberPage> {
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
        LocaleSingleton.strings.detailsMember,
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
      child: Column(
        children: <Widget>[
          _detailsData(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                // CustomRaisedButton(
                //   text: LocaleSingleton.strings.update.toUpperCase(),
                //   function: () {},
                //   context: context,
                //   buttonColor: Ui.primaryColor,
                //   textColor: Colors.white,
                //   fontSize: 17.5,
                //   fontFamily: 'WorkSans Bold',
                //   circularRadius: 3.5,
                // ),
                // SizedBox(height: 20.0),
                CustomRaisedButton(
                  text: LocaleSingleton.strings.billSubscription.toUpperCase(),
                  function: () {
                    Navigator.pop(context);
                    GeneralNavigator(
                        context,
                        BillSuscriptionPage(
                          member: widget.member,
                        )).navigate();
                  },
                  context: context,
                  buttonColor: Ui.primaryColor,
                  textColor: Colors.white,
                  fontSize: 17.5,
                  fontFamily: 'WorkSans Bold',
                  circularRadius: 3.5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _detailsData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          _titleDetails(LocaleSingleton.strings.personalData),
          _personalDataDetails(),
        ],
      ),
    );
  }

  Widget _titleDetails(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'WorkSans Bold',
        fontSize: 23.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _personalDataDetails() {
    return Card(
      elevation: 3.0,
      child: Column(
        children: <Widget>[
          _detail(LocaleSingleton.strings.name, widget.member.name),
          Divider(),
          _detail(LocaleSingleton.strings.lastName, widget.member.lastName),
          Divider(),
          _detail(LocaleSingleton.strings.dni, widget.member.dni),
          Divider(),
          _detail(LocaleSingleton.strings.sex, widget.member.sex),
          Divider(),
          _detail(LocaleSingleton.strings.email, widget.member.email),
        ],
      ),
    );
  }

  Widget _detail(
    String title,
    String message,
  ) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Bold',
          fontSize: 17.0,
        ),
      ),
      subtitle: Text(
        message,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'WorkSans Regular',
          fontSize: 15.0,
        ),
      ),
    );
  }
}
