import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final int maxline;
  final double horizontalpadding;
  final void Function(String) onChange;
  final bool autofocus;

  TextInputField({
    this.labelText,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.maxline,
    this.horizontalpadding = 20,
    this.onChange,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalpadding),
      child: TextField(
        autofocus: autofocus,
        style: Theme.of(context).textTheme.headline3,
        maxLines: maxline,
        keyboardType: keyboardType,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.5),
          labelText: labelText,
          focusColor: Theme.of(context).accentColor,
          labelStyle: Theme.of(context).textTheme.headline3,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.headline3,
          errorText: errorText,
          errorStyle: Theme.of(context).primaryTextTheme.subtitle2,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorLight,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
