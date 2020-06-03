import 'package:shared_preferences/shared_preferences.dart';
import 'package:specta_mobile/services/storage/IStorageService.dart';
import 'package:specta_mobile/utils/uidata.dart';

class SecureStorage implements IStorageService {
  static SecureStorage _secureStorage;
  static SharedPreferences _preferences;
  final key = UIData.tokenKey;

  static Future<SecureStorage> getInstance() async {
    if (_secureStorage == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = SecureStorage._();
      await secureStorage._init();
      _secureStorage = secureStorage;
    }
    return _secureStorage;
  }

  SecureStorage._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  deleteToken() async {
    // Delete a token from secure storage
    _preferences.remove(key);
  }

  @override
  hasToken() {
    // Check if there is a token in the secure storage
    return _preferences.getString(key) != null;
  }

  @override
  persistToken(String token) {
    _preferences.setString(key, token);
  }

  @override
  getToken() {
    // Get the token from the secure storage
    return _preferences.getString(key);
  }
}
