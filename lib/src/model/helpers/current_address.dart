import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../services/services.dart';
import './service_locator.dart';
import '../../controllers/blocs/blocs.dart';

Future<String> currentAddress() async {
  Position location = await getPosition();
  sl<UserLocationStream>().setlocation(
      {"latitude": location.latitude, "longitude": location.longitude});
  List<Placemark> address = await getPlacefromCoordinate(
      latitude: location.latitude, longitude: location.longitude);

  return "${address[0].subLocality}, ${address[0].locality}";
}
