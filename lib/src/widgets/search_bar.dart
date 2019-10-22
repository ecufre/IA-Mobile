import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/ui.dart';
import 'package:ia_mobile/src/locales/locale_singleton.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    @required this.controller,
    this.icon = Icons.search,
    this.enabled = true,
    this.hintText,
    this.validation,
    @required this.keyType,
    this.function,
    @required this.focusNode,
  });
  final TextEditingController controller;

  final IconData icon;
  final bool enabled;
  final String hintText;
  final validation;
  final keyType;
  final function;
  final focusNode;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Color(0xFFededed),
        borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-2.0, 2.0),
            blurRadius: 1.1,
          )
        ],
      ),
      height: 50.0,
      width: 500.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 0.0, left: 5.0),
          child: TextFormField(
            key: Key('SearchBar'),
            controller: widget.controller,
            focusNode: widget.focusNode,
            style: TextStyle(
              fontSize: 17.5,
              fontFamily: 'WorkSans Regular',
            ),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: widget.controller.text.isEmpty
                    ? null
                    : () => widget.function(),
                child: Image.asset(
                  'assets/icons/icon_lupa.png',
                  scale: 3.0,
                  color:
                      widget.controller.text.isEmpty ? null : Ui.primaryColor,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: 17.5,
                color: Color(0XFFc2c3c9),
                fontFamily: 'WorkSans Regular',
              ),
              border: InputBorder.none,
              hintText: this.widget.hintText != null
                  ? this.widget.hintText
                  : LocaleSingleton.strings.search,
            ),
            enabled: this.widget.enabled,
            onFieldSubmitted: (val) => widget.function(),
            inputFormatters: this.widget.validation,
            keyboardType: widget.keyType,
          ),
        ),
      ),
    );
  }
}
