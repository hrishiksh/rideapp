import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './services.dart';
import '../helpers/helpers.dart';
import 'package:geolocator/geolocator.dart';

void shareLocationDirectly({bool cancelstream}) {
  StreamSubscription<Position> positionStram = getPositionStream().listen(
    (Position position) {
      SocketConnect.instance.sendLocationData(
        {
          'name': sl<SharedPreferences>().getString("name"),
          'contact': sl<SharedPreferences>().getString("contact"),
          'address': sl<SharedPreferences>().getString("address"),
          'latitude': position.latitude,
          'longitude': position.longitude,
          "time": DateTime.now().toString(),
        },
      );
    },
  );

  if (cancelstream) {
    positionStram.cancel();
  }
}
