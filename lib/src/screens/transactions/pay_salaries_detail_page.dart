import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';

class PaySalariesDetailPage extends StatefulWidget {
  @override
  _PaySalariesDetailPageState createState() =>
      new _PaySalariesDetailPageState();
}

class _PaySalariesDetailPageState extends State<PaySalariesDetailPage> {
  bool _holidayState = false;
  bool _illnessState = false;
  bool _studyDayState = false;
  int _holiday = 0;
  int _illness = 0;
  int _studyDay = 0;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          _builtHolidays(),
          _addHolidays(),
          _builtIllness(),
          _addIllness(),
          _builtStudyDay(),
          _addStudyDay(),
          _button(),
        ],
      ),
    );
  }

  Widget _builtHolidays() {
    return Card(
      elevation: 3.0,
      child: CheckboxListTile(
        title: Text(
          LocaleSingleton.strings.holidays,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: 'WorkSans Regular',
          ),
        ),
        value: _holidayState,
        onChanged: (value) {
          setState(() {
            _holiday = 0;
            _holidayState = value;
          });
        },
      ),
    );
  }

  Widget _addHolidays() {
    return _holidayState
        ? Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    LocaleSingleton.strings.days,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'WorkSans Regular',
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/less_icon.png",
                          scale: 0.5,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(
                            () =>
                                _holiday != 0 ? _holiday = _holiday - 1 : null,
                          );
                        },
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          border: Border.all(color: Colors.black38),
                        ),
                        child: Center(
                          child: Text(
                            _holiday.toString(),
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'WorkSans Bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/pluss_icon.png",
                          scale: 0.5,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(
                            () =>
                                _holiday != 50 ? _holiday = _holiday + 1 : null,
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Widget _builtIllness() {
    return Card(
      elevation: 3.0,
      child: CheckboxListTile(
        title: Text(
          LocaleSingleton.strings.illness,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: 'WorkSans Regular',
          ),
        ),
        value: _illnessState,
        onChanged: (value) {
          setState(() {
            _illness = 0;
            _illnessState = value;
          });
        },
      ),
    );
  }

  Widget _addIllness() {
    return _illnessState
        ? Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    LocaleSingleton.strings.days,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'WorkSans Regular',
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/less_icon.png",
                          scale: 0.5,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(
                            () =>
                                _illness != 0 ? _illness = _illness - 1 : null,
                          );
                        },
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          border: Border.all(color: Colors.black38),
                        ),
                        child: Center(
                          child: Text(
                            _illness.toString(),
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'WorkSans Bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/pluss_icon.png",
                          scale: 0.5,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(
                            () =>
                                _illness != 50 ? _illness = _illness + 1 : null,
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Widget _builtStudyDay() {
    return Card(
      elevation: 3.0,
      child: CheckboxListTile(
        title: Text(
          LocaleSingleton.strings.studyDay,
          style: TextStyle(
            fontSize: 17.0,
            fontFamily: 'WorkSans Regular',
          ),
        ),
        value: _studyDayState,
        onChanged: (value) {
          setState(() {
            _studyDay = 0;
            _studyDayState = value;
          });
        },
      ),
    );
  }

  Widget _addStudyDay() {
    return _studyDayState
        ? Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    LocaleSingleton.strings.days,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'WorkSans Regular',
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/less_icon.png",
                          scale: 0.5,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(
                            () => _studyDay != 0
                                ? _studyDay = _studyDay - 1
                                : null,
                          );
                        },
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          border: Border.all(color: Colors.black38),
                        ),
                        child: Center(
                          child: Text(
                            _studyDay.toString(),
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'WorkSans Bold',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/pluss_icon.png",
                          scale: 0.5,
                        ),
                        iconSize: 30.0,
                        onPressed: () {
                          setState(
                            () => _studyDay != 50
                                ? _studyDay = _studyDay + 1
                                : null,
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: CustomRaisedButton(
        text: LocaleSingleton.strings.paySalary.toUpperCase(),
        function: () {},
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
