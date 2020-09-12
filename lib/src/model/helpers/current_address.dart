import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';
import '../services/location_conversion.dart';

Future<String> currentAddress() async {
  Position location = await getPosition();
  List<Placemark> address = await getPlacefromCoordinate(
      latitude: location.latitude, longitude: location.longitude);

  return "${address[0].subLocality}, ${address[0].locality}";
}
