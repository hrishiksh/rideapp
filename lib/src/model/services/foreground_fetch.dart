import 'dart:convert';
import 'package:foreground_service/foreground_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/location_model.dart';
import '../helpers/helpers.dart';
import '../services/services.dart';
import '../../controllers/blocs/blocs.dart';

void foreGroundFetch() async {
  if (!(await ForegroundService.foregroundServiceIsStarted())) {
    await ForegroundService.setServiceIntervalSeconds(30);

    await ForegroundService.notification.startEditMode();
    await ForegroundService.notification.setTitle("Getting Location");
    await ForegroundService.notification
        .setText("Please on your location service");

    await ForegroundService.notification.finishEditMode();

    await ForegroundService.startForegroundService(foregroundServiceFunction);
    await ForegroundService.getWakeLock();
  }

  await ForegroundService.setupIsolateCommunication((msg) {
    Map<String, dynamic> parsedmsg = jsonDecode(msg);
    print('MSG : $msg');
    StatusStream.instance.addStatus(parsedmsg);
  });
}

void foregroundServiceFunction() async {
  SharedPreferences storage = await SharedPreferences.getInstance();

  Position position = await getPosition();
  print("Got location");

  int id = storage.getInt("rowid");
  print('ID: $id');
  List<Map<String, dynamic>> prevData =
      await LocationDatabase.instance.retrivePrevData(id);

  print('DATA: $prevData');

  ForegroundService.notification.setText(
      "${DateTime.now().minute} ${DateTime.now().second}: ${position.latitude}");

  LocationModel newlocation = LocationModel(
    latitude: position.latitude,
    longitude: position.longitude,
    prevlatitude: prevData != null ? prevData[0]["latitude"] : null,
    prevlongitude: prevData != null ? prevData[0]["longitude"] : null,
    prevdateTime:
        prevData != null ? DateTime.parse(prevData[0]["dateTime"]) : null,
  );

  int newid = await LocationDatabase.instance.insertLocationDb(newlocation);
  storage.setInt("rowid", newid);

  SocketConnect socketConnect = SocketConnect.instance;

  bool inGreenZone() {
    double distance = double.parse(calculateDistance(
        startlatitude: 26.6204495,
        startlongitude: 93.5867906,
        endlatitude: position.latitude,
        endlongitude: position.longitude));
    if (distance < 90) {
      return true;
    }
    return false;
  }

  String speed = calculateValocity(
    startlatitude: prevData != null ? prevData[0]["latitude"] : null,
    startlongitude: prevData != null ? prevData[0]["longitude"] : null,
    startDate:
        prevData != null ? DateTime.parse(prevData[0]["dateTime"]) : null,
    endlatitude: position.latitude,
    endlongitude: position.longitude,
    endDate: DateTime.now(),
  );

  print('SPEED: $speed');

  socketConnect.sendLocationData({
    //TODO: get name and address from sharedpreference
    'name': 'from app',
    'contact': '1232345673',
    'address': 'Guwahati',
    'latitude': position.latitude,
    'longitude': position.longitude,
    'time': DateTime.now().toString(),
  });
  showNotification();
  ForegroundService.sendToPort(
    jsonEncode(
      {
        "status": "greenzone",
        "color": 0xFF57C061,
        "msg": "Your location is shared with police",
        "sl": "20kmph"
      },
    ),
  );

  //TODO: un comment below line

  // if (inGreenZone() && double.parse(speed) > 20.0) {
  //   socketConnect.sendLocationData({
  //     'latitude': position.latitude,
  //     'longitude': position.longitude,
  //     "time": DateTime.now().toString(),
  //   });
  //   showNotification();
  //   ForegroundService.sendToPort(
  //     jsonEncode(
  //       {
  //         "status": "greenzone",
  //         "color": 0xFF57C061,
  //         "msg": "Your location is shared with police",
  //         "sl": "20kmph"
  //       },
  //     ),
  //   );
  // } else if (inGreenZone()) {
  //   ForegroundService.sendToPort(
  //     jsonEncode(
  //       {
  //         "status": "greenzone",
  //         "color": 0xFF57C061,
  //         "msg": "Greenzone Ahed. Drive slow",
  //         "sl": "20kmph"
  //       },
  //     ),
  //   );
  // } else if (double.parse(speed) > 100) {
  //   socketConnect.sendLocationData({
  //     'latitude': position.latitude,
  //     'longitude': position.longitude,
  //     "time": DateTime.now().toString(),
  //   });
  //   showNotification();
  //   ForegroundService.sendToPort(
  //     jsonEncode(
  //       {
  //         "status": "greenzone",
  //         "color": 0xFFFF3A3A,
  //         "msg": "Your location is shared with police",
  //         "sl": "20kmph"
  //       },
  //     ),
  //   );
  // } else {
  //   ForegroundService.sendToPort(
  //     jsonEncode(
  //       {
  //         "status": "normal",
  //         "color": 0xFF657ED4,
  //         "msg": "Moderate traffic. Obey traffic rules",
  //         "sl": "100kmph"
  //       },
  //     ),
  //   );
  // }

  print("INSERTED");

  if (!ForegroundService.isIsolateCommunicationSetup) {
    ForegroundService.setupIsolateCommunication(
        (message) => print("isolate msg received: $message"));
  }
}
