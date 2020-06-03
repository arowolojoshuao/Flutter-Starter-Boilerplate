import 'package:meta/meta.dart';
import 'package:specta_mobile/manager/UserAuthRepository/IUserAuthRepository.dart';
import 'package:specta_mobile/service_locator.dart';
import 'package:specta_mobile/services/api/api.dart';
import 'package:specta_mobile/services/storage/secure_storage.dart';

class UserAuthManager implements IUserAuthRepository {
  var apiService = serviceLocator<Api>();
  var storageService = serviceLocator<SecureStorage>();
  @override
  Future<void> deleteToken() async {
    return await storageService.deleteToken();
  }

  @override
  Future<bool> hasToken() async {
    var value = await storageService.hasToken();
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> login(
      {@required String username, @required String password}) async {
    final String token =
        await apiService.authenticate(username, password, true);
    print(token);
    storageService.persistToken(token);
    return token;
  }

  @override
  persistToken(String token) {
    return storageService.persistToken(token);
  }
}
