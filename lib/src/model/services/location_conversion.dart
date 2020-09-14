import 'package:geocoding/geocoding.dart';

Future<List<Placemark>> getPlacefromCoordinate(
    {double latitude, double longitude}) async {
  if (latitude == null || longitude == null) {
    return Future(
      () => [
        Placemark(subLocality: "..."),
      ],
    );
  } else {
    return await placemarkFromCoordinates(latitude, longitude);
  }
}
