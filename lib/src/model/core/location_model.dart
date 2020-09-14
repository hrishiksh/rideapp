class LocationModel {
  int id;
  DateTime dateTime;
  double prevlatitude;
  double prevlongitude;
  DateTime prevdateTime;
  double latitude;
  double longitude;

  LocationModel({
    this.id,
    this.dateTime,
    this.latitude,
    this.longitude,
    this.prevlatitude,
    this.prevlongitude,
    this.prevdateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      "dateTime": DateTime.now().toString(),
      "latitude": latitude,
      "longitude": longitude,
      "prevlatitude": prevlatitude,
      "prevlongitude": prevlongitude,
      "prevdateTime": prevdateTime != null ? prevdateTime.toString() : null,
    };
  }
}
