// To parse this JSON data, do
//
//     final authenticateResult = authenticateResultFromJson(jsonString);

import 'dart:convert';

import 'package:specta_mobile/models/api/api_error.dart';

class AuthenticateResult {
    Result result;
    dynamic targetUrl;
    bool success;
    ApiError error;
    bool unAuthorizedRequest;
    bool abp;

    AuthenticateResult({
        this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.abp,
    });

    factory AuthenticateResult.fromRawJson(String str) => AuthenticateResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthenticateResult.fromJson(Map<String, dynamic> json) => new AuthenticateResult(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? null : result.toJson(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
    };
}

class Result {
    String accessToken;
    String encryptedAccessToken;
    int expireInSeconds;
    int userId;

    Result({
        this.accessToken,
        this.encryptedAccessToken,
        this.expireInSeconds,
        this.userId,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        encryptedAccessToken: json["encryptedAccessToken"] == null ? null : json["encryptedAccessToken"],
        expireInSeconds: json["expireInSeconds"] == null ? null : json["expireInSeconds"],
        userId: json["userId"] == null ? null : json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken == null ? null : accessToken,
        "encryptedAccessToken": encryptedAccessToken == null ? null : encryptedAccessToken,
        "expireInSeconds": expireInSeconds == null ? null : expireInSeconds,
        "userId": userId == null ? null : userId,
    };
}
