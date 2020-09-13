import 'package:get_it/get_it.dart';
import '../services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<LocationDatabase>(LocationDatabase.instance);
  sl.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
}
