import 'package:get_it/get_it.dart';
import '../services/database.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<LocationDatabase>(LocationDatabase.instance);
}
