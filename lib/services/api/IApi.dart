abstract class IApi {
  Future<String> authenticate(userNameOrEmailAddress, password, rememberClient);
}