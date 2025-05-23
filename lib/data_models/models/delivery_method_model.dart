class DeliveryMethodModel {
  bool? success;
  String? message;
  DeliveryMethodDataModel? data;

  DeliveryMethodModel({this.success, this.message, this.data});

  DeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? DeliveryMethodDataModel.fromJson(json['data'])
        : null;
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

class DeliveryMethodDataModel {
  List<WholesalerDeliveryMethods>? wholesalerDeliveryMethods;
  WholesalerDeliveryMethods? deliveryMethods;
  List<String>? currencies;
  List<SaleZonesForDelivery>? saleZones;

  DeliveryMethodDataModel(
      {this.wholesalerDeliveryMethods,
      this.deliveryMethods,
      this.currencies,
      this.saleZones});

  DeliveryMethodDataModel.fromJson(Map<String, dynamic> json) {
    if (json['wholesaler_delivery_methods'] != null) {
      wholesalerDeliveryMethods = <WholesalerDeliveryMethods>[];
      json['wholesaler_delivery_methods'].forEach((v) {
        wholesalerDeliveryMethods!.add(WholesalerDeliveryMethods.fromJson(v));
      });
    }
    deliveryMethods = json['delivery_method'] != null
        ? WholesalerDeliveryMethods.fromJson(json['delivery_method'])
        : null;
    currencies = json['currencies'].cast<String>();
    if (json['sale_zones'] != null) {
      saleZones = <SaleZonesForDelivery>[];
      json['sale_zones'].forEach((v) {
        saleZones!.add(SaleZonesForDelivery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wholesalerDeliveryMethods != null) {
      data['wholesaler_delivery_methods'] =
          wholesalerDeliveryMethods!.map((v) => v.toJson()).toList();
    }
    if (deliveryMethods != null) {
      data['delivery_method'] = deliveryMethods!.toJson();
    }
    data['currencies'] = currencies;
    if (saleZones != null) {
      data['sale_zones'] = saleZones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WholesalerDeliveryMethods {
  int? id;
  String? uniqueId;
  String? deliveryMethodId;
  String? description;
  List<SaleZonesForDelivery>? saleZone;
  String? currency;
  int? shippingAndHandlingCost;
  int? status;
  String? country;

  WholesalerDeliveryMethods(
      {this.id,
      this.uniqueId,
      this.deliveryMethodId,
      this.description,
      this.saleZone,
      this.currency,
      this.shippingAndHandlingCost,
      this.status,
      this.country});

  WholesalerDeliveryMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    deliveryMethodId = json['delivery_method_id'];
    description = json['description'];
    // saleZone = json['sale_zone'];
    if (json['sale_zone'] != null) {
      saleZone = <SaleZonesForDelivery>[];
      json['sale_zone'].forEach((v) {
        saleZone!.add(SaleZonesForDelivery.fromJson(v));
      });
    }
    currency = json['currency'];
    shippingAndHandlingCost = json['shipping_and_handling_cost'];
    status = json['status'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['delivery_method_id'] = deliveryMethodId;
    data['description'] = description;
    // data['sale_zone'] = saleZone;
    if (saleZone != null) {
      data['sale_zone'] = saleZone!.map((v) => v.toJson()).toList();
    }
    data['currency'] = currency;
    data['shipping_and_handling_cost'] = shippingAndHandlingCost;
    data['status'] = status;
    data['country'] = country;
    return data;
  }
}

class SaleZonesForDelivery {
  String? uniqueId;
  String? zoneId;
  String? zoneName;
  String? country;

  SaleZonesForDelivery(
      {this.uniqueId, this.zoneId, this.zoneName, this.country});

  SaleZonesForDelivery.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['zone_id'] = zoneId;
    data['zone_name'] = zoneName;
    data['country'] = country;
    return data;
  }
}
