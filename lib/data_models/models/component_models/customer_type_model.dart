class CustomerTypeModel {
  bool? success;
  String? message;
  List<Data>? data;

  CustomerTypeModel({this.success, this.message, this.data});

  CustomerTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? typeId;
  String? customerType;
  String? date;

  Data({this.uniqueId, this.typeId, this.customerType, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    typeId = json['type_id'] ?? "";
    customerType = json['customer_type'] ?? "";
    date = json['date'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['type_id'] = typeId;
    data['customer_type'] = customerType;
    data['date'] = date;
    return data;
  }
}
