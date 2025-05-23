class PricingGroupModel {
  bool? success;
  String? message;
  List<Data>? data;

  PricingGroupModel({this.success, this.message, this.data});

  PricingGroupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? uniqueId;
  String? pricingGroups;
  String? pricingGroupName;
  String? date;
  Data({this.uniqueId, this.pricingGroups, this.pricingGroupName, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    pricingGroups = json['pricing_groups'] ?? "";
    pricingGroupName = json['pricing_group_name'] ?? "";
    date = json['date'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['pricing_groups'] = pricingGroups;
    data['pricing_group_name'] = pricingGroupName;
    data['date'] = date;
    return data;
  }
}
