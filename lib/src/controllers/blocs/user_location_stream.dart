import 'dart:async';

import 'package:rxdart/rxdart.dart';

class UserLocationStream {
  final locationStreamController = BehaviorSubject<Map<String, double>>();

  Stream<Map<String, double>> get location => locationStreamController.stream;

  Function(Map<String, double>) get setlocation =>
      locationStreamController.sink.add;

  dispose() {
    locationStreamController.close();
  }
}
