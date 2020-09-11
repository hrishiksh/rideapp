class LocationModel {
  int id;
  DateTime dateTime;
  double latitude;
  double longitude;

  LocationModel({this.id, this.dateTime, this.latitude, this.longitude});

  Map<String, String> toMap() {
    return {
      "dateTime": "${DateTime.now()}",
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
    };
  }
}
