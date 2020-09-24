import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final void Function() ontap;
  final String title;

  PrimaryBtn({this.ontap, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: ontap,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
      ),
    );
  }
}
