import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  final IconData icon;
  final void Function() ontap;

  RoundedBtn({this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      onTap: ontap,
    );
  }
}
