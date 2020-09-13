import "package:geolocator/geolocator.dart";

Future<Position> getPosition() async {
  return await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<Position> getlastknownposition() async {
  return await getLastKnownPosition();
}
