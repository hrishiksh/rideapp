import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotification() async {
  AndroidInitializationSettings androidinitialize =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  IOSInitializationSettings iosinitialize = IOSInitializationSettings();

  InitializationSettings initialization =
      InitializationSettings(androidinitialize, iosinitialize);

  await flutterLocalNotificationsPlugin.initialize(
    initialization,
    onSelectNotification: (String payload) async {
      print('PAYLOAD: $payload');
    },
  );
}

Future<void> showNotification() async {
  AndroidNotificationDetails androidSpecification = AndroidNotificationDetails(
    'CHANNEL_ID',
    'Sending Location',
    'Your location is being sent',
    importance: Importance.Max,
    priority: Priority.Max,
    playSound: true,
    styleInformation: DefaultStyleInformation(true, true),
  );

  IOSNotificationDetails iosSpecification = IOSNotificationDetails();
  NotificationDetails platformchanelspecification =
      NotificationDetails(androidSpecification, iosSpecification);
  await flutterLocalNotificationsPlugin.show(0, 'Location is shared',
      'Your location is shared with police', platformchanelspecification,
      payload: 'This is a payload');
}
