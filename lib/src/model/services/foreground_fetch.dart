import 'package:foreground_service/foreground_service.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';
import '../services/database.dart';
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
      (message) => print(message.runtimeType));
}

void foregroundServiceFunction() async {
  print("running");

  Position position = await getPosition();
  print("Got location");

  ForegroundService.notification.setText(
      "${DateTime.now().minute} ${DateTime.now().second}: ${position.latitude}");
  LocationModel newlocation =
      LocationModel(latitude: position.latitude, longitude: position.longitude);
  LocationDatabase.instance.insertLocationDb(newlocation);

  print("got position");

  if (!ForegroundService.isIsolateCommunicationSetup) {
    ForegroundService.setupIsolateCommunication(
        (message) => print("isolate: $message"));
  }

  ForegroundService.sendToPort("position");
}
