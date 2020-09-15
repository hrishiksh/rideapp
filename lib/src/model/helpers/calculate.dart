import 'package:geolocator/geolocator.dart';

String calculateValocity(
    {double startlatitude,
    double startlongitude,
    double endlatitude,
    double endlongitude,
    DateTime startDate,
    DateTime endDate}) {
  if (startlatitude == null || startlongitude == null || startDate == null) {
    return '0.0';
  }
  double distance =
      distanceBetween(startlatitude, startlongitude, endlatitude, endlongitude);
  int time = endDate.difference(startDate).inHours;
  return (distance / (1000 * time)).toStringAsFixed(2);
}

String calculateDistance(
    {double startlatitude,
    double startlongitude,
    double endlatitude,
    double endlongitude}) {
  if (startlatitude == null || startlongitude == null) {
    return '0.0';
  }

  return (distanceBetween(
              startlatitude, startlongitude, endlatitude, endlongitude) /
          1000)
      .toStringAsFixed(2);
}

int calculateTime({DateTime startDate, DateTime endDate}) {
  if (startDate == null) {
    return 0;
  }

  return endDate.difference(startDate).inHours;
}
