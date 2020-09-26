import 'dart:async';
import './services.dart';
import 'package:geolocator/geolocator.dart';

void shareLocationDirectly({bool cancelstream}) {
  StreamSubscription<Position> positionStram = getPositionStream().listen(
    (Position position) {
      SocketConnect.instance.sendLocationData(
        //TODO: get name and address from shared preference
        {
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
