import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';

class ErrorCasePopup extends StatelessWidget {
  ErrorCasePopup({
    @required this.context,
    @required this.errorMessage,
    this.function,
  });
  final BuildContext context;
  final String errorMessage;
  final function;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: SizedBox(
            height: 320.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/images/deny_icon.png'),
                          width: screenSize.width * 0.60,
                          height: screenSize.height <= 640
                              ? screenSize.height * 0.12
                              : screenSize.height * 0.09,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        this.errorMessage,
                        maxLines: 6,
                        style: TextStyle(
                          fontSize: 17.5,
                          color: Colors.black,
                          fontFamily: 'WorkSans Regular',
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: RaisedButton(
                        color: Ui.primaryColor,
                        textColor: Colors.white,
                        onPressed: () => _back(),
                        child: Text(
                          LocaleSingleton.strings.accept.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'WorkSans Bold',
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _back() {
    if (this.function != null) this.function();
    Navigator.pop(context, false);
  }
}
