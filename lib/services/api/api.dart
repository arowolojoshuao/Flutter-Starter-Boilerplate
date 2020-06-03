import 'package:dio/dio.dart';
import 'package:specta_mobile/models/api/response/authenticate.dart';
import 'package:specta_mobile/services/api/IApi.dart';
import 'package:specta_mobile/utils/uidata.dart';

class Api implements IApi {
  static const baseURL = UIData.baseURL;
  static const tenantId = UIData.tenantId;
  final Dio _dio = Dio();
  @override
  Future<String> authenticate(
      userNameOrEmailAddress, password, rememberClient) async {
    var url = "$baseURL/TokenAuth/Authenticate";
    try {
      Response response = await _dio.post(url,
          data: {
            "userNameOrEmailAddress": userNameOrEmailAddress,
            "password": password,
            "rememberClient": rememberClient
          },
          options: Options(headers: {
            "CONTENT_TYPE": 'application/json',
            "ACCEPT": 'application/json',
            'Abp.TenantId': tenantId,
          }));
      AuthenticateResult result = AuthenticateResult.fromJson(response.data);
      return result.result.accessToken;
    } on DioError catch (e) {
      if (e.response.data != "") {
        AuthenticateResult result =
            AuthenticateResult.fromJson(e.response.data);
        return result.error.details;
      } else {
        print(e.request);
        return e.response.statusMessage;
      }
    }
  }
}
