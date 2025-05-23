class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? uniqueId;
  int? id;
  String? tempTxAddress;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? enrollmentType;
  String? country;
  String? deviceType;
  String? deviceToken;
  String? latitude;
  String? longitude;
  String? address;
  String? languageCode;
  String? profileImage;
  List<SalesZones>? salesZones;
  List<SalesRoutes>? salesRoutes;
  List<Stores>? stores;
  int? notificationOnOff;
  String? token;
  bool? isMaster;
  String? role;
  bool? isPinSet;

  Data(
      {this.uniqueId,
      this.id,
      this.tempTxAddress,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.enrollmentType,
      this.country,
      this.deviceType,
      this.deviceToken,
      this.latitude,
      this.longitude,
      this.address,
      this.languageCode,
      this.profileImage,
      this.salesZones,
      this.salesRoutes,
      this.stores,
      this.notificationOnOff,
      this.token,
      this.isMaster,
      this.role,
      this.isPinSet});

  Data.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? '';
    id = json['id'] ?? 0;
    tempTxAddress = json['temp_tx_address'] ?? '';
    name = json['name'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    email = json['email'] ?? '';
    enrollmentType = json['enrollment_type'] ?? '';
    country = json['country'] ?? '';
    deviceType = json['device_type'] ?? '';
    deviceToken = json['device_token'] ?? '';
    latitude = json['latitude'] ?? '';
    longitude = json['longitude'] ?? '';
    address = json['address'] ?? '';
    languageCode = json['language_code'] ?? "en";
    profileImage = json['profile_image'] ?? "";
    if (json['sales_zones'] != null) {
      salesZones = <SalesZones>[];
      json['sales_zones'].forEach((v) {
        salesZones!.add(SalesZones.fromJson(v));
      });
    }
    if (json['sales_routes'] != null) {
      salesRoutes = <SalesRoutes>[];
      json['sales_routes'].forEach((v) {
        salesRoutes!.add(SalesRoutes.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    notificationOnOff = json['notification_on_off'] ?? 0;
    token = json['token'] ?? '';
    isMaster = json['is_master'] == 1 ? true : false;
    role = json['role'] ?? '';
    isPinSet = json['is_pin_set'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['id'] = id;
    data['temp_tx_address'] = tempTxAddress;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['enrollment_type'] = enrollmentType;
    data['country'] = country;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['language_code'] = languageCode;
    data['profile_image'] = profileImage;
    if (salesZones != null) {
      data['sales_zones'] = salesZones!.map((v) => v.toJson()).toList();
    }
    if (salesRoutes != null) {
      data['sales_routes'] = salesRoutes!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    data['notification_on_off'] = notificationOnOff;
    data['token'] = token;
    data['is_master'] = isMaster == true ? 1 : 0;
    data['role'] = role;
    data['is_pin_set'] = isPinSet;
    return data;
  }
}

class SalesZones {
  String? uniqueId;
  String? zoneId;
  String? zoneName;
  String? country;

  SalesZones({this.uniqueId, this.zoneId, this.zoneName, this.country});

  SalesZones.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? '';
    zoneId = json['zone_id'] ?? '';
    zoneName = json['zone_name'] ?? '';
    country = json['country'] ?? '';
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

class SalesRoutes {
  String? uniqueId;
  String? salesRouteId;
  String? salesRouteName;

  SalesRoutes({this.uniqueId, this.salesRouteId, this.salesRouteName});

  SalesRoutes.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? '';
    salesRouteId = json['sales_route_id'] ?? '';
    salesRouteName = json['sales_route_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['sales_route_id'] = salesRouteId;
    data['sales_route_name'] = salesRouteName;
    return data;
  }
}

class Stores {
  int? id;
  String? uniqueId;
  int? retaillerId;
  String? name;
  String? city;
  String? address;
  String? cordinate;
  String? remark;
  String? bankAccount;
  String? irnNo;
  String? storeLogo;
  String? country;
  String? website;
  String? zone_id;
  String? prefferedBank;
  String? lattitude;
  String? longitude;
  String? signBoardPhoto;
  String? status;
  String? date;
  String? createdAt;
  String? updatedAt;

  Stores(
      {this.id,
      this.uniqueId,
      this.retaillerId,
      this.name,
      this.city,
      this.address,
      this.cordinate,
      this.remark,
      this.bankAccount,
      this.irnNo,
      this.storeLogo,
      this.country,
      this.website,
      this.prefferedBank,
      this.lattitude,
      this.longitude,
      this.signBoardPhoto,
      this.status,
      this.date,
      this.createdAt,
      this.updatedAt});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    retaillerId = json['retailler_id'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    cordinate = json['cordinate'];
    remark = json['remark'];
    bankAccount = json['bank_account'];
    irnNo = json['irn_no'];
    storeLogo = json['store_logo'];
    country = json['country'];
    website = json['website'];
    prefferedBank = json['preffered_bank'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    signBoardPhoto = json['sign_board_photo'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['retailler_id'] = retaillerId;
    data['name'] = name;
    data['city'] = city;
    data['address'] = address;
    data['cordinate'] = cordinate;
    data['remark'] = remark;
    data['bank_account'] = bankAccount;
    data['irn_no'] = irnNo;
    data['store_logo'] = storeLogo;
    data['country'] = country;
    data['website'] = website;
    data['preffered_bank'] = prefferedBank;
    data['lattitude'] = lattitude;
    data['longitude'] = longitude;
    data['sign_board_photo'] = signBoardPhoto;
    data['status'] = status;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserZoneRouteModel {
  String? id;
  String? name;
  int? type;
  String? uid;

  UserZoneRouteModel({this.id, this.name, this.type, this.uid});

  UserZoneRouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'] ?? 0;
    uid = json['uid'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['uid'] = uid;

    return data;
  }
}
