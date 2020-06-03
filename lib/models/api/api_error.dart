class ApiError {
  int code;
  String message;
  String details;
  dynamic validationErrors;

  ApiError({this.code, this.message, this.details, this.validationErrors});

  ApiError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
    validationErrors = json['validationErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['details'] = this.details;
    data['validationErrors'] = this.validationErrors;
    return data;
  }
}