import 'package:workmanager/workmanager.dart';
import './location_service.dart';

void callbackDispatcher() {
  Workmanager.executeTask(
    (taskName, inputData) {
      if (taskName == "getposition") {
        print('task is running');
        getPosition();
      }
      return Future.value(true);
    },
  );
}
