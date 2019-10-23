import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/helpers/error_case.dart';
import 'package:ia_mobile/src/helpers/navigations/navigator.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/models/employee.dart';
import 'package:ia_mobile/src/services/modules/api_module.dart';
import 'package:ia_mobile/src/widgets/color_loader_popup.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';
import 'package:ia_mobile/src/widgets/successful_page.dart';
import 'package:ia_mobile/src/widgets/successful_popup.dart';

class PaySalariesDetailPage extends StatefulWidget {
  PaySalariesDetailPage({this.employee, this.month, this.year});
  final Employee employee;
  final int month;
  final int year;
  @override
  _PaySalariesDetailPageState createState() =>
      new _PaySalariesDetailPageState();
}

class _PaySalariesDetailPageState extends State<PaySalariesDetailPage> {
  // bool _holidayState = false;
  // bool _illnessState = false;
  // bool _studyDayState = false;
  // int _holiday = 0;
  // int _illness = 0;
  // int _studyDay = 0;
  bool _isLoading = false;
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
    return _isLoading
        ? ColorLoaderPopup()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _detailsData(),
                // _builtHolidays(),
                // _addHolidays(),
                // _builtIllness(),
                // _addIllness(),
                // _builtStudyDay(),
                // _addStudyDay(),
                _button(),
              ],
            ),
          );
  }

  Widget _detailsData() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
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
          _detail(LocaleSingleton.strings.name, widget.employee.name),
          Divider(),
          _detail(LocaleSingleton.strings.lastName, widget.employee.lastName),
          Divider(),
          _detail(LocaleSingleton.strings.dni, widget.employee.dni),
          Divider(),
          _detail(LocaleSingleton.strings.sex, widget.employee.sex),
          Divider(),
          _detail(LocaleSingleton.strings.email, widget.employee.email),
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

  // Widget _builtHolidays() {
  //   return Card(
  //     elevation: 3.0,
  //     child: CheckboxListTile(
  //       title: Text(
  //         LocaleSingleton.strings.holidays,
  //         style: TextStyle(
  //           fontSize: 17.0,
  //           fontFamily: 'WorkSans Regular',
  //         ),
  //       ),
  //       value: _holidayState,
  //       onChanged: (value) {
  //         setState(() {
  //           _holiday = 0;
  //           _holidayState = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _addHolidays() {
  //   return _holidayState
  //       ? Card(
  //           elevation: 3.0,
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Text(
  //                   LocaleSingleton.strings.days,
  //                   style: TextStyle(
  //                     fontSize: 17.0,
  //                     fontFamily: 'WorkSans Regular',
  //                   ),
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Image.asset(
  //                         "assets/icons/less_icon.png",
  //                         scale: 0.5,
  //                       ),
  //                       iconSize: 30.0,
  //                       onPressed: () {
  //                         setState(
  //                           () =>
  //                               _holiday != 0 ? _holiday = _holiday - 1 : null,
  //                         );
  //                       },
  //                     ),
  //                     Container(
  //                       height: 30,
  //                       width: 30,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(5.0),
  //                         ),
  //                         border: Border.all(color: Colors.black38),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           _holiday.toString(),
  //                           style: TextStyle(
  //                             fontSize: 22.0,
  //                             fontFamily: 'WorkSans Bold',
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                     IconButton(
  //                       icon: Image.asset(
  //                         "assets/icons/pluss_icon.png",
  //                         scale: 0.5,
  //                       ),
  //                       iconSize: 30.0,
  //                       onPressed: () {
  //                         setState(
  //                           () =>
  //                               _holiday != 50 ? _holiday = _holiday + 1 : null,
  //                         );
  //                       },
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       : SizedBox();
  // }

  // Widget _builtIllness() {
  //   return Card(
  //     elevation: 3.0,
  //     child: CheckboxListTile(
  //       title: Text(
  //         LocaleSingleton.strings.illness,
  //         style: TextStyle(
  //           fontSize: 17.0,
  //           fontFamily: 'WorkSans Regular',
  //         ),
  //       ),
  //       value: _illnessState,
  //       onChanged: (value) {
  //         setState(() {
  //           _illness = 0;
  //           _illnessState = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _addIllness() {
  //   return _illnessState
  //       ? Card(
  //           elevation: 3.0,
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Text(
  //                   LocaleSingleton.strings.days,
  //                   style: TextStyle(
  //                     fontSize: 17.0,
  //                     fontFamily: 'WorkSans Regular',
  //                   ),
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Image.asset(
  //                         "assets/icons/less_icon.png",
  //                         scale: 0.5,
  //                       ),
  //                       iconSize: 30.0,
  //                       onPressed: () {
  //                         setState(
  //                           () =>
  //                               _illness != 0 ? _illness = _illness - 1 : null,
  //                         );
  //                       },
  //                     ),
  //                     Container(
  //                       height: 30,
  //                       width: 30,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(5.0),
  //                         ),
  //                         border: Border.all(color: Colors.black38),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           _illness.toString(),
  //                           style: TextStyle(
  //                             fontSize: 22.0,
  //                             fontFamily: 'WorkSans Bold',
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                     IconButton(
  //                       icon: Image.asset(
  //                         "assets/icons/pluss_icon.png",
  //                         scale: 0.5,
  //                       ),
  //                       iconSize: 30.0,
  //                       onPressed: () {
  //                         setState(
  //                           () =>
  //                               _illness != 50 ? _illness = _illness + 1 : null,
  //                         );
  //                       },
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       : SizedBox();
  // }

  // Widget _builtStudyDay() {
  //   return Card(
  //     elevation: 3.0,
  //     child: CheckboxListTile(
  //       title: Text(
  //         LocaleSingleton.strings.studyDay,
  //         style: TextStyle(
  //           fontSize: 17.0,
  //           fontFamily: 'WorkSans Regular',
  //         ),
  //       ),
  //       value: _studyDayState,
  //       onChanged: (value) {
  //         setState(() {
  //           _studyDay = 0;
  //           _studyDayState = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget _addStudyDay() {
  //   return _studyDayState
  //       ? Card(
  //           elevation: 3.0,
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Text(
  //                   LocaleSingleton.strings.days,
  //                   style: TextStyle(
  //                     fontSize: 17.0,
  //                     fontFamily: 'WorkSans Regular',
  //                   ),
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: <Widget>[
  //                     IconButton(
  //                       icon: Image.asset(
  //                         "assets/icons/less_icon.png",
  //                         scale: 0.5,
  //                       ),
  //                       iconSize: 30.0,
  //                       onPressed: () {
  //                         setState(
  //                           () => _studyDay != 0
  //                               ? _studyDay = _studyDay - 1
  //                               : null,
  //                         );
  //                       },
  //                     ),
  //                     Container(
  //                       height: 30,
  //                       width: 30,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(5.0),
  //                         ),
  //                         border: Border.all(color: Colors.black38),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           _studyDay.toString(),
  //                           style: TextStyle(
  //                             fontSize: 22.0,
  //                             fontFamily: 'WorkSans Bold',
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                     IconButton(
  //                       icon: Image.asset(
  //                         "assets/icons/pluss_icon.png",
  //                         scale: 0.5,
  //                       ),
  //                       iconSize: 30.0,
  //                       onPressed: () {
  //                         setState(
  //                           () => _studyDay != 50
  //                               ? _studyDay = _studyDay + 1
  //                               : null,
  //                         );
  //                       },
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       : SizedBox();
  // }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: CustomRaisedButton(
        text: LocaleSingleton.strings.paySalary.toUpperCase(),
        function: () => _paySalary(),
        context: context,
        buttonColor: Ui.primaryColor,
        textColor: Colors.white,
        fontSize: 17.5,
        fontFamily: 'WorkSans Bold',
        circularRadius: 3.5,
      ),
    );
  }

  _paySalary() {
    setState(() => _isLoading = true);
    ApiModule()
        .paySalary(widget.employee.id, widget.month, widget.year)
        .then((result) {
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
    }).catchError((error) {
      Navigator.pop(context);
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
        function: _back,
      ),
    );
  }

  _back() {
    Navigator.pop(context, true);
  }

  _openConfirmPopup() {
    Navigator.pop(context, true);
    GeneralNavigator(
        context,
        SuccessfulPage(
          message: "Se realizó la liquidación",
        )).navigate();
  }
}
