import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/helpers/helpers.dart';

class InputSanitizer {
  final nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isEmpty) {
        sink.addError('name shoudn\'t empty');
      } else if (data.contains(',')) {
        sink.addError('name shoudn\'t contain ,');
      } else if (data.contains('-')) {
        sink.addError('name shoudn\'t contain -');
      } else if (data.contains('.')) {
        sink.addError('name shoudn\'t contain .');
      } else {
        sink.add(data);
      }
    },
  );
  final contactValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isEmpty ||
          data.contains(' ') ||
          data.contains(',') ||
          data.contains('-') ||
          data.length < 10) {
        sink.addError('Please add a valid contact number');
      } else {
        sink.add(data);
      }
    },
  );
  final addressValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.isEmpty || data.length < 5) {
        sink.addError('Please add a valid Address');
      } else {
        sink.add(data);
      }
    },
  );
}

class LoginStream extends InputSanitizer {
  final _loginNameStreamController = BehaviorSubject<String>();
  final _loginContactStreamController = BehaviorSubject<String>();
  final _loginAddressStreamController = BehaviorSubject<String>();
  final _loginIsPoliceStreamController = BehaviorSubject<bool>();

  void Function(String) get addname => _loginNameStreamController.sink.add;
  void Function(String) get addcontact =>
      _loginContactStreamController.sink.add;
  void Function(String) get addaddress =>
      _loginAddressStreamController.sink.add;

  void Function(bool) get addIsPolice =>
      _loginIsPoliceStreamController.sink.add;

  Stream<String> get nameStream =>
      _loginNameStreamController.stream.transform(nameValidator);
  Stream<String> get contactStream =>
      _loginContactStreamController.stream.transform(contactValidator);
  Stream<String> get addressStream =>
      _loginAddressStreamController.stream.transform(addressValidator);

  Stream<bool> get isPoliceStream => _loginIsPoliceStreamController.stream;

  Future<void> submit() async {
    await sl<SharedPreferences>()
        .setString("name", _loginNameStreamController.value);
    await sl<SharedPreferences>()
        .setString("contact", _loginContactStreamController.value);
    await sl<SharedPreferences>()
        .setString("address", _loginAddressStreamController.value);
    await sl<SharedPreferences>()
        .setBool("isPolice", _loginIsPoliceStreamController.value ?? false);

    print("ADDED SHARED_PREFERENCE");
  }

  dispose() {
    _loginNameStreamController.close();
    _loginContactStreamController.close();
    _loginAddressStreamController.close();
    _loginIsPoliceStreamController.close();
  }
}
