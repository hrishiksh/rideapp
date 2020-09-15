import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rideapp/src/model/services/notification.dart';
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
