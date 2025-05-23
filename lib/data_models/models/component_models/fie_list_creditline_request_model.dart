class FieCreditLineRequestModel {
  bool? success;
  String? message;
  List<FieCreditLineRequestData>? data;

  FieCreditLineRequestModel({this.success, this.message, this.data});

  FieCreditLineRequestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FieCreditLineRequestData>[];
      json['data'].forEach((v) {
        data!.add(FieCreditLineRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FieCreditLineRequestData {
  String? fieUniqueId;
  String? bpName;

  FieCreditLineRequestData({this.fieUniqueId, this.bpName});

  FieCreditLineRequestData.fromJson(Map<String, dynamic> json) {
    fieUniqueId = json['fie_unique_id'] ?? "";
    bpName = json['bp_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fie_unique_id'] = fieUniqueId;
    data['bp_name'] = bpName;
    return data;
  }
}
