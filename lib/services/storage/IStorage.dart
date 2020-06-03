import 'package:shared_preferences/shared_preferences.dart';
import 'package:specta_mobile/services/storage/IStorageService.dart';

abstract class IStorage extends IStorageService {
  SharedPreferences getStorage();
}