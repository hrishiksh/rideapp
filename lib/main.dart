import 'package:flutter/material.dart';
import './src/app.dart';
import './src/model/services/foreground_fetch.dart';
import './src/model/helpers/service_locator.dart';

void main() async {
  setupLocator();
  runApp(
    MyApp(),
  );
  foreGroundFetch();
}
