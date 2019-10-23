import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';
import 'package:ia_mobile/src/widgets/custom_raised_button.dart';

class SuccessfulPopup extends StatelessWidget {
  SuccessfulPopup({
    @required this.context,
    @required this.message,
    this.function,
  });
  final BuildContext context;
  final String message;
  final function;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: SizedBox(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 13.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/icono_check.png',
                          color: Ui.primaryColor,
                          scale: 1.1,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        this.message,
                        maxLines: 6,
                        style: TextStyle(
                            fontFamily: 'WorkSans Regular',
                            fontSize: 17.3,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: CustomRaisedButton(
                        buttonColor: Ui.primaryColor,
                        fontSize: 17.5,
                        fontFamily: 'WorkSans Bold',
                        textColor: Colors.white,
                        function: () => _back(),
                        text: LocaleSingleton.strings.accept,
                        context: context,
                        circularRadius: 3.5,
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
