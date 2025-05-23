class ResponseMessages {
  bool? success;
  String? message;
  String? data;

  ResponseMessages({this.success, this.message, this.data});

  ResponseMessages.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = json['data'].runtimeType == String ? json['data'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
