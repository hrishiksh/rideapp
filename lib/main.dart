import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import './src/app.dart';
import './src/model/services/backgroung_fatch.dart';

void main() {
  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager.registerPeriodicTask("1", "getposition");
  runApp(
    MyApp(),
  );
}
