import 'package:rxdart/rxdart.dart';

class ServerStream {
  final _serverStreamController = BehaviorSubject<List>();

  Stream<List> get serverstream => _serverStreamController.stream;

  Function(List) get addServerStream => _serverStreamController.sink.add;

  dispose() {
    _serverStreamController.close();
  }
}
