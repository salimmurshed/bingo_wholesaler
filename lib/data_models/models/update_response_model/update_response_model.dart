class UpdateResponseModel {
  bool? success;
  String? message;
  Data? data;

  UpdateResponseModel({this.success, this.message, this.data});

  UpdateResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? activationCode;

  Data({this.activationCode});

  Data.fromJson(Map<String, dynamic> json) {
    activationCode = json['activation_code'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activation_code'] = activationCode;
    return data;
  }
}
