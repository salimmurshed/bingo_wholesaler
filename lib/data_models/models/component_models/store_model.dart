class StoreModel {
  bool? success;
  String? message;
  Data? data;

  StoreModel({this.success, this.message, this.data});

  StoreModel.fromJson(Map<String, dynamic> json) {
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
  List<RetailerInformation>? retailerInformation;

  Data({this.retailerInformation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['retailer_information'] != null) {
      retailerInformation = <RetailerInformation>[];
      json['retailer_information'].forEach((v) {
        retailerInformation!.add(RetailerInformation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (retailerInformation != null) {
      data['retailer_information'] =
          retailerInformation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RetailerInformation {
  String? storeId;
  String? name;
  String? city;
  String? address;
  String? creditlineId;
  String? approvedCreditLineCurrency;
  String? associationId;
  String? saleType;

  RetailerInformation(
      {this.storeId,
      this.name,
      this.city,
      this.address,
      this.creditlineId,
      this.approvedCreditLineCurrency,
      this.associationId,
      this.saleType});

  RetailerInformation.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'] ?? '';
    name = json['name'] ?? '';
    city = json['city'] ?? '';
    address = json['address'] ?? '';
    creditlineId = json['creditline_id'] ?? '';
    approvedCreditLineCurrency = json['approved_credit_line_currency'] ?? '';
    associationId = json['associationId'] ?? '';
    saleType = json['sale_type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['name'] = name;
    data['city'] = city;
    data['address'] = address;
    data['creditline_id'] = creditlineId;
    data['approved_credit_line_currency'] = approvedCreditLineCurrency;
    data['associationId'] = associationId;
    data['sale_type'] = saleType;
    return data;
  }
}
