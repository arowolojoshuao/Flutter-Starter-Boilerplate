import 'package:get_it/get_it.dart';
import 'package:specta_mobile/manager/UserAuthRepository/IUserAuthRepository.dart';
import 'package:specta_mobile/manager/UserAuthRepository/UserAuthRepository.dart';
import 'package:specta_mobile/services/api/IApi.dart';
import 'package:specta_mobile/services/api/api.dart';
import 'package:specta_mobile/services/storage/IStorageService.dart';
import 'package:specta_mobile/services/storage/secure_storage.dart';

// ambient variable to access the service locator
GetIt serviceLocator = GetIt.instance;
void setupLocator() {
  serviceLocator.registerLazySingleton(() => Api());
 // serviceLocator.registerLazySingleton(() => SecureStorage());
  serviceLocator.registerLazySingleton(() => UserAuthManager());
  // serviceLocator.registerSingleton<IStorageService>(new SecureStorage());
  // serviceLocator.registerSingleton<IUserAuthRepository>(new UserAuthManager());
}