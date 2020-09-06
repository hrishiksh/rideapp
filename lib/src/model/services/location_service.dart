import "package:geolocator/geolocator.dart";

Future<Position> getPosition() async {
  LocationPermission permission = await checkPermission();
  if (permission == LocationPermission.denied) {
    await requestPermission();
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
  Position position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}
