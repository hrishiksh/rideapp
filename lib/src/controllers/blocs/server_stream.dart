import 'package:rxdart/rxdart.dart';

class ServerStream {
  final _serverStreamController = BehaviorSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get serverstream =>
      _serverStreamController.stream;

  Function(Map<String, dynamic>) get addServerStream =>
      _serverStreamController.sink.add;

  dispose() {
    _serverStreamController.close();
  }
}
