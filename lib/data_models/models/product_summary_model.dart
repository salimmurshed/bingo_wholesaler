class ProductSummaryModel {
  bool? success;
  String? message;
  List<ProductSummaryData>? data;

  ProductSummaryModel({this.success, this.message, this.data});

  ProductSummaryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductSummaryData>[];
      json['data'].forEach((v) {
        data!.add(ProductSummaryData.fromJson(v));
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

class ProductSummaryData {
  String? uniqueId;
  String? skuId;
  List<Pricing>? pricing;

  ProductSummaryData({this.uniqueId, this.skuId, this.pricing});

  ProductSummaryData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    skuId = json['sku_id'];
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(Pricing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['sku_id'] = skuId;
    if (pricing != null) {
      data['pricing'] = pricing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pricing {
  String? pricingGroupId;
  int? unitPrice;
  String? description;
  String? category;
  String? unit;
  String? currency;
  int? tax;
  int? status;

  Pricing(
      {this.pricingGroupId,
      this.unitPrice,
      this.description,
      this.category,
      this.unit,
      this.currency,
      this.tax,
      this.status});

  Pricing.fromJson(Map<String, dynamic> json) {
    pricingGroupId = json['pricing_group_id'];
    unitPrice = json['unit_price'];
    description = json['description'];
    category = json['category'];
    unit = json['unit'];
    currency = json['currency'];
    tax = json['tax'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pricing_group_id'] = pricingGroupId;
    data['unit_price'] = unitPrice;
    data['description'] = description;
    data['category'] = category;
    data['unit'] = unit;
    data['currency'] = currency;
    data['tax'] = tax;
    data['status'] = status;
    return data;
  }
}
