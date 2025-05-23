class SalesZoneModel {
  bool? success;
  String? message;
  List<SalesZoneModelData>? data;

  SalesZoneModel({this.success, this.message, this.data});

  SalesZoneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SalesZoneModelData>[];
      json['data'].forEach((v) {
        data!.add(SalesZoneModelData.fromJson(v));
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

class SalesZoneModelData {
  String? saleZone;
  String? zoneName;

  SalesZoneModelData({this.saleZone, this.zoneName});

  SalesZoneModelData.fromJson(Map<String, dynamic> json) {
    saleZone = json['sale_zone'] ?? "";
    zoneName = json['zone_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sale_zone'] = saleZone;
    data['zone_name'] = zoneName;
    return data;
  }
}
