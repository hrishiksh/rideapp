import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConnect {
  final IO.Socket socket = IO.io(
    'https://morning-scrubland-63803.herokuapp.com/',
    <String, dynamic>{
      'transports': ['websocket'],
    },
  );

  // Making a singleton

  SocketConnect._privateConstructor();

  static final SocketConnect instance = SocketConnect._privateConstructor();

  void connection() {
    socket.on('connect', (_) => print('SOCKET: Data is connected'));
    socket.on('connect_error', (_) => print('SOCKET: connection error'));
  }

  IO.Socket get getsocketInstance {
    return socket;
  }

  void sendLocationData(Map<String, dynamic> data) {
    String jsondata = jsonEncode(data);
    socket.emit('client-location', jsondata);
  }

  void rcvmsg() {
    socket.on(
      'feedback',
      (data) => print(
        'RECIEVED: ${jsonDecode(data)}',
      ),
    );
  }
}
