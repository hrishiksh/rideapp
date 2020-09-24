import 'package:get_it/get_it.dart';
import '../services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/blocs/blocs.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<LocationDatabase>(LocationDatabase.instance);
  sl.registerSingleton<UserLocationStream>(UserLocationStream());
  sl.registerSingleton<ServerStream>(ServerStream());
  sl.registerSingleton<LoginStream>(LoginStream());
  sl.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
}
