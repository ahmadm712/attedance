import 'package:attendance/services/firestore_services.dart';
import 'package:attendance/services/location_services.dart';
import 'package:attendance/utils/global_functions.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(() => LocationServices());
  locator.registerLazySingleton(() => GlobalFunctions());
  locator.registerLazySingleton(() => FirebaseServices());
}
