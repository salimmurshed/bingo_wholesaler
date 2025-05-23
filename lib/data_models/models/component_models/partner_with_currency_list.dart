class PartnerWithCurrencyList {
  bool? success;
  String? message;
  List<PartnerWithCurrencyListData>? data;

  PartnerWithCurrencyList({this.success, this.message, this.data});

  PartnerWithCurrencyList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PartnerWithCurrencyListData>[];
      json['data'].forEach((v) {
        data!.add(PartnerWithCurrencyListData.fromJson(v));
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

class PartnerWithCurrencyListData {
  List<WholesalerData>? wholesalerData;

  PartnerWithCurrencyListData({this.wholesalerData});

  PartnerWithCurrencyListData.fromJson(Map<String, dynamic> json) {
    if (json['wholesaler_data'] != null) {
      wholesalerData = <WholesalerData>[];
      json['wholesaler_data'].forEach((v) {
        wholesalerData!.add(WholesalerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wholesalerData != null) {
      data['wholesaler_data'] = wholesalerData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WholesalerData {
  String? bpIdW;
  String? associationUniqueId;
  String? wholesalerName;
  List<WholesalerCurrency>? wholesalerCurrency;

  WholesalerData(
      {this.bpIdW,
      this.associationUniqueId,
      this.wholesalerName,
      this.wholesalerCurrency});

  WholesalerData.fromJson(Map<String, dynamic> json) {
    bpIdW = json['bp_id_w'] ?? "";
    associationUniqueId = json['association_unique_id'] ?? "";
    wholesalerName = json['wholesaler_name'] ?? "";
    if (json['wholesaler_currency'] != null) {
      wholesalerCurrency = <WholesalerCurrency>[];
      json['wholesaler_currency'].forEach((v) {
        wholesalerCurrency!.add(WholesalerCurrency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bp_id_w'] = bpIdW;
    data['association_unique_id'] = associationUniqueId;
    data['wholesaler_name'] = wholesalerName;
    if (wholesalerCurrency != null) {
      data['wholesaler_currency'] =
          wholesalerCurrency!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WholesalerCurrency {
  String? currency;

  WholesalerCurrency({this.currency});

  WholesalerCurrency.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    return data;
  }
}
