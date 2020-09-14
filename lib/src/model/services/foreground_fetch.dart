import 'package:foreground_service/foreground_service.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import '../services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/location_model.dart';

void foreGroundFetch() async {
  if (!(await ForegroundService.foregroundServiceIsStarted())) {
    await ForegroundService.setServiceIntervalSeconds(600);

    await ForegroundService.notification.startEditMode();
    await ForegroundService.notification.setTitle("Getting Location");
    await ForegroundService.notification
        .setText("Please on your location service");

    await ForegroundService.notification.finishEditMode();

    await ForegroundService.startForegroundService(foregroundServiceFunction);
    await ForegroundService.getWakeLock();
  }

  await ForegroundService.setupIsolateCommunication(
      (message) => print(message));
}

void foregroundServiceFunction() async {
  SharedPreferences storage = await SharedPreferences.getInstance();

  Position position = await getPosition();
  print("Got location");

  int id = storage.getInt("rowid");
  print('ID: $id');
  List<Map<String, dynamic>> prevData =
      await LocationDatabase.instance.retrivePrevData(id);

  print('DATA: $prevData.');

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

  print("INSERTED");

  if (!ForegroundService.isIsolateCommunicationSetup) {
    ForegroundService.setupIsolateCommunication(
        (message) => print("isolate msg received: $message"));
  }

  ForegroundService.sendToPort("foreground: $position");
}
