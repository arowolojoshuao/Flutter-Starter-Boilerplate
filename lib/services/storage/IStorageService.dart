abstract class IStorageService {
  void deleteToken();
  void persistToken(String token);
  bool hasToken();
  String getToken();

}