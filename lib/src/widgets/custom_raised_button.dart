import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    @required this.text,
    @required this.function,
    @required this.context,
    @required this.buttonColor,
    @required this.textColor,
    this.elevation = 2.0,
    this.boderSideWidth = 0.0,
    this.boderSideColor = Colors.transparent,
    this.fontSize = 20.0,
    this.width = 500.0,
    this.height = 50.0,
    this.circularRadius = 15.0,
    this.fontFamily,
    this.fontWeight,
  });

  final String text;
  final VoidCallback function;
  final BuildContext context;
  final Color buttonColor;
  final Color textColor;
  final double elevation;
  final double boderSideWidth;
  final Color boderSideColor;
  final double fontSize;
  final double width;
  final double height;
  final double circularRadius;
  final String fontFamily;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: this.height,
            width: this.width,
            child: RaisedButton(
              elevation: this.elevation,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: this.boderSideWidth, color: this.boderSideColor),
                borderRadius:
                    BorderRadius.all(Radius.circular(this.circularRadius)),
              ),
              color: this.buttonColor,
              onPressed: function,
              child: Text(
                text,
                style: TextStyle(
                  color: this.textColor,
                  fontSize: this.fontSize,
                  fontFamily: this.fontFamily,
                  fontWeight: this.fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
