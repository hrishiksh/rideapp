import 'package:rxdart/rxdart.dart';

class StatusStream {
  // Making a singleton because getit is not working with foreground execution

  StatusStream._privateConstructor();

  static final instance = StatusStream._privateConstructor();

  final statusStreamController = BehaviorSubject<Map<String, dynamic>>();

  Function(Map<String, dynamic>) get addStatus =>
      statusStreamController.sink.add;

  Stream<Map<String, dynamic>> get statusStream =>
      statusStreamController.stream;

  dispose() {
    statusStreamController.close();
  }
}
