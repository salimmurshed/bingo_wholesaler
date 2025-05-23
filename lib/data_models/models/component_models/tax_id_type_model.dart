class TaxIdType {
  bool? success;
  String? message;
  List<TaxIdTypeData>? data;

  TaxIdType({this.success, this.message, this.data});

  TaxIdType.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TaxIdTypeData>[];
      json['data'].forEach((v) {
        data!.add(TaxIdTypeData.fromJson(v));
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

class TaxIdTypeData {
  String? taxIdType;

  TaxIdTypeData({this.taxIdType});

  TaxIdTypeData.fromJson(Map<String, dynamic> json) {
    taxIdType = json['tax_id_type'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tax_id_type'] = taxIdType;
    return data;
  }
}
