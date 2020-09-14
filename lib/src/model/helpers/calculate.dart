import 'package:geolocator/geolocator.dart';

double calculateValocity(
    {double startlatitude,
    double startlongitude,
    double endlatitude,
    double endlongitude,
    DateTime startDate,
    DateTime endDate}) {
  double distance =
      distanceBetween(startlatitude, startlongitude, endlatitude, endlongitude);
  int time = endDate.difference(startDate).inHours;
  return distance / (1000 * time);
}

double calculateDistance(
    {double startlatitude,
    double startlongitude,
    double endlatitude,
    double endlongitude}) {
  return distanceBetween(
          startlatitude, startlongitude, endlatitude, endlongitude) /
      1000;
}

int calculateTime({DateTime startDate, DateTime endDate}) {
  return endDate.difference(startDate).inHours;
}
