import 'package:geocoding/geocoding.dart';

Future<List<Placemark>> getPlacefromCoordinate(
    {double latitude, double longitude}) async {
  return await placemarkFromCoordinates(latitude, longitude);
}
