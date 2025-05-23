class InternalConfigurationListModel {
  bool? success;
  String? message;
  Data? data;

  InternalConfigurationListModel({this.success, this.message, this.data});

  InternalConfigurationListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CustomerType>? customerType;
  List<GracePeriod>? gracePeriod;
  List<PricingGroups>? pricingGroups;
  List<SaleZones>? saleZones;

  Data(
      {this.customerType,
      this.gracePeriod,
      this.pricingGroups,
      this.saleZones});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['customer_type'] != null) {
      customerType = <CustomerType>[];
      json['customer_type'].forEach((v) {
        customerType!.add(CustomerType.fromJson(v));
      });
    }
    if (json['grace_period'] != null) {
      gracePeriod = <GracePeriod>[];
      json['grace_period'].forEach((v) {
        gracePeriod!.add(GracePeriod.fromJson(v));
      });
    }
    if (json['pricing_groups'] != null) {
      pricingGroups = <PricingGroups>[];
      json['pricing_groups'].forEach((v) {
        pricingGroups!.add(PricingGroups.fromJson(v));
      });
    }
    if (json['sale_zones'] != null) {
      saleZones = <SaleZones>[];
      json['sale_zones'].forEach((v) {
        saleZones!.add(SaleZones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerType != null) {
      data['customer_type'] =
          this.customerType!.map((v) => v.toJson()).toList();
    }
    if (this.gracePeriod != null) {
      data['grace_period'] = this.gracePeriod!.map((v) => v.toJson()).toList();
    }
    if (this.pricingGroups != null) {
      data['pricing_groups'] =
          this.pricingGroups!.map((v) => v.toJson()).toList();
    }
    if (this.saleZones != null) {
      data['sale_zones'] = this.saleZones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerType {
  String? customerType;

  CustomerType({this.customerType});

  CustomerType.fromJson(Map<String, dynamic> json) {
    customerType = json['customer_type'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_type'] = this.customerType;
    return data;
  }
}

class GracePeriod {
  String? gracePeriodGroup;

  GracePeriod({this.gracePeriodGroup});

  GracePeriod.fromJson(Map<String, dynamic> json) {
    gracePeriodGroup = json['grace_period_group'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grace_period_group'] = this.gracePeriodGroup;
    return data;
  }
}

class PricingGroups {
  String? pricingGroups;

  PricingGroups({this.pricingGroups});

  PricingGroups.fromJson(Map<String, dynamic> json) {
    pricingGroups = json['pricing_groups'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pricing_groups'] = this.pricingGroups;
    return data;
  }
}

class SaleZones {
  String? saleZone;
  String? zoneName;

  SaleZones({this.saleZone, this.zoneName});

  SaleZones.fromJson(Map<String, dynamic> json) {
    saleZone = json['sale_zone'] ?? "";
    zoneName = json['zone_name'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_zone'] = this.saleZone;
    data['zone_name'] = this.zoneName;
    return data;
  }
}
