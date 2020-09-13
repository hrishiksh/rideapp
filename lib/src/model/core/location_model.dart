class LocationModel {
  int id;
  DateTime dateTime;
  double prevlatitude;
  double prevlongitude;
  DateTime prevDateTime;
  double latitude;
  double longitude;

  LocationModel({
    this.id,
    this.dateTime,
    this.latitude,
    this.longitude,
    this.prevlatitude,
    this.prevlongitude,
    this.prevDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      "dateTime": DateTime.now().toString(),
      "latitude": latitude,
      "longitude": longitude,
      "prevlatitude": prevlatitude,
      "prevlongitude": prevlongitude,
      "prevdateTime": prevDateTime != null ? prevDateTime.toString() : null,
    };
  }
}
