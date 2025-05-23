class CustomerStoreList {
  bool? success;
  String? message;
  List<CustomerStoreData>? data;

  CustomerStoreList({this.success, this.message, this.data});

  CustomerStoreList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CustomerStoreData>[];
      json['data'].forEach((v) {
        data!.add(CustomerStoreData.fromJson(v));
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

class CustomerStoreListSingle {
  bool? success;
  String? message;
  CustomerStoreData? data;

  CustomerStoreListSingle({this.success, this.message, this.data});

  CustomerStoreListSingle.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? CustomerStoreData.fromJson(json['data']) : null;
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

class CustomerStoreData {
  int? bingoStoreId;
  String? uniqueId;
  String? retailerUniqueId;
  String? name;
  String? country;
  String? remark;
  String? city;
  String? address;
  String? lattitude;
  String? longitude;
  String? remarks;
  String? status;
  String? signBoardPhoto;
  String? storeLogo;
  String? wStoreId;
  int? salesZoneId;
  String? salesZoneName;
  List<StaticRoutes>? staticRoutes;
  List<StaticRoutes>? dynamicRoutes;

  CustomerStoreData(
      {this.bingoStoreId,
      this.uniqueId,
      this.retailerUniqueId,
      this.name,
      this.country,
      this.remark,
      this.city,
      this.address,
      this.lattitude,
      this.longitude,
      this.remarks,
      this.status,
      this.signBoardPhoto,
      this.storeLogo,
      this.wStoreId,
      this.salesZoneId,
      this.salesZoneName,
      this.staticRoutes,
      this.dynamicRoutes});

  CustomerStoreData.fromJson(Map<String, dynamic> json) {
    bingoStoreId = json['bingo_store_id'] ?? 0;
    uniqueId = json['unique_id'] ?? "";
    retailerUniqueId = json['retailer_unique_id'] ?? "";
    name = json['name'] ?? "";
    country = json['country'] ?? "";
    remark = json['remark'] ?? "";
    city = json['city'] ?? "";
    address = json['address'] ?? "";
    lattitude = json['lattitude'] ?? "";
    longitude = json['longitude'] ?? "";
    remarks = json['remarks'] ?? "";
    status = json['status'] ?? "";
    signBoardPhoto = json['sign_board_photo'] ?? "";
    storeLogo = json['store_logo'] ?? "";
    wStoreId = json['w_store_id'] ?? "";
    salesZoneId = json['sales_zone_id'] ?? 0;
    salesZoneName = json['sales_zone_name'] ?? "";
    if (json['static_routes'] != null) {
      staticRoutes = <StaticRoutes>[];
      json['static_routes'].forEach((v) {
        staticRoutes!.add(StaticRoutes.fromJson(v));
      });
    }
    if (json['dynamic_routes'] != null) {
      dynamicRoutes = <StaticRoutes>[];
      json['dynamic_routes'].forEach((v) {
        dynamicRoutes!.add(StaticRoutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bingo_store_id'] = bingoStoreId;
    data['unique_id'] = uniqueId;
    data['retailer_unique_id'] = retailerUniqueId;
    data['name'] = name;
    data['country'] = country;
    data['remark'] = remark;
    data['city'] = city;
    data['address'] = address;
    data['lattitude'] = lattitude;
    data['longitude'] = longitude;
    data['remarks'] = remarks;
    data['status'] = status;
    data['sign_board_photo'] = signBoardPhoto;
    data['store_logo'] = storeLogo;
    data['w_store_id'] = wStoreId;
    data['sales_zone_id'] = salesZoneId;
    data['sales_zone_name'] = salesZoneName;
    if (staticRoutes != null) {
      data['static_routes'] = staticRoutes!.map((v) => v.toJson()).toList();
    }
    if (dynamicRoutes != null) {
      data['dynamic_routes'] = dynamicRoutes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StaticRoutes {
  int? retaillerId;
  int? bingoStoreId;
  String? wStoreId;
  int? id;
  String? uniqueId;
  int? bpIdW;
  String? routeId;
  String? routeName;
  String? date;
  String? country;
  int? type;
  int? status;
  String? salesStep;
  String? createdAt;
  String? updatedAt;

  StaticRoutes(
      {this.retaillerId,
      this.bingoStoreId,
      this.wStoreId,
      this.id,
      this.uniqueId,
      this.bpIdW,
      this.routeId,
      this.routeName,
      this.date,
      this.country,
      this.type,
      this.status,
      this.salesStep,
      this.createdAt,
      this.updatedAt});

  StaticRoutes.fromJson(Map<String, dynamic> json) {
    retaillerId = json['retailler_id'] ?? 0;
    bingoStoreId = json['bingo_store_id'] ?? 0;
    wStoreId = json['w_store_id'] ?? "";
    id = json['id'] ?? 0;
    uniqueId = json['unique_id'] ?? "";
    bpIdW = json['bp_id_w'] ?? 0;
    routeId = json['route_id'] ?? "";
    routeName = json['route_name'] ?? "";
    date = json['date'] ?? "";
    country = json['country'] ?? "";
    type = json['type'] ?? 0;
    status = json['status'] ?? 0;
    salesStep = json['sales_step'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['retailler_id'] = retaillerId;
    data['bingo_store_id'] = bingoStoreId;
    data['w_store_id'] = wStoreId;
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['bp_id_w'] = bpIdW;
    data['route_id'] = routeId;
    data['route_name'] = routeName;
    data['date'] = date;
    data['country'] = country;
    data['type'] = type;
    data['status'] = status;
    data['sales_step'] = salesStep;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
