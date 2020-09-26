import 'package:rxdart/rxdart.dart';

class ToggleLocationSharing {
  // Making a singleton
  ToggleLocationSharing._privateConstructor();

  static final ToggleLocationSharing instance =
      ToggleLocationSharing._privateConstructor();

  final toggleLocationSharing = BehaviorSubject<bool>();

  void Function(bool) get addToggleLocation => toggleLocationSharing.sink.add;

  Stream<bool> get toggleLocationStream => toggleLocationSharing.stream;

  dispose() {
    toggleLocationSharing.close();
  }
}
