import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<List<LatLng>> generatePolylinePoints({
  double startlatitude,
  double startlogitude,
  double destinationlatitude,
  double destinationlongitude,
}) async {
  List<LatLng> latlngpoints;
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    "APIKEYHERE",
    PointLatLng(startlatitude, startlogitude),
    PointLatLng(destinationlatitude, destinationlongitude),
    travelMode: TravelMode.transit,
  );
  print('ERROR: ${result.errorMessage}');
  print('STATUS: ${result.status}');
  print('POINTS: ${result.points}');
  if (result.points.isNotEmpty) {
    result.points.forEach(
      (element) {
        latlngpoints.add(LatLng(element.latitude, element.longitude));
      },
    );
  }
  return latlngpoints;
}
