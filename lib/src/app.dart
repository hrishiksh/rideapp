import 'package:flutter/material.dart';
import './view/pages/pages.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ride App",
      home: HomePage(),
    );
  }
}
