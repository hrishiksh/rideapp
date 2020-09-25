import 'package:flutter/material.dart';
import './src/app.dart';
import './src/model/services/services.dart';
import './src/model/helpers/helpers.dart';

void main() async {
  setupLocator();
  runApp(
    MyApp(),
  );

  initializeNotification();
  foreGroundFetch();
}
