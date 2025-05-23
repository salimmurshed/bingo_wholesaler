class SaleZonesDetailsModel {
  bool? success;
  String? message;
  List<SaleZonesDetailsData>? data;

  SaleZonesDetailsModel({this.success, this.message, this.data});

  SaleZonesDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SaleZonesDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new SaleZonesDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleZonesDetailsData {
  String? uniqueId;
  String? salesId;
  String? description;
  String? salesStep;
  int? status;
  String? assignTo;
  String? assignToUniqueId;
  String? salesStepDescription;
  List<LocationsDetailsSales>? locationsDetails;
  List<AssignableUserList>? assignableUserList;

  SaleZonesDetailsData(
      {this.uniqueId,
      this.salesId,
      this.description,
      this.salesStep,
      this.status,
      this.assignTo,
      this.assignToUniqueId,
      this.salesStepDescription,
      this.locationsDetails,
      this.assignableUserList});

  SaleZonesDetailsData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    salesId = json['sales_id'];
    description = json['description'];
    salesStep = json['sales_step'];
    status = json['status'];
    assignTo = json['assign_to'];
    assignToUniqueId = json['assign_to_unique_id'];
    salesStepDescription = json['sales_step_description'];
    if (json['locations_details'] != null) {
      locationsDetails = <LocationsDetailsSales>[];
      json['locations_details'].forEach((v) {
        locationsDetails!.add(new LocationsDetailsSales.fromJson(v));
      });
    }
    if (json['assignable_user_list'] != null) {
      assignableUserList = <AssignableUserList>[];
      json['assignable_user_list'].forEach((v) {
        assignableUserList!.add(new AssignableUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['sales_id'] = this.salesId;
    data['description'] = this.description;
    data['sales_step'] = this.salesStep;
    data['status'] = this.status;
    data['assign_to'] = this.assignTo;
    data['assign_to_unique_id'] = this.assignToUniqueId;
    data['sales_step_description'] = this.salesStepDescription;
    if (this.locationsDetails != null) {
      data['locations_details'] =
          this.locationsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.assignableUserList != null) {
      data['assignable_user_list'] =
          this.assignableUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationsDetailsSales {
  String? locationId;
  String? retailerInternalId;
  String? retailerName;
  String? storeId;
  String? storeName;
  String? storeAddress;
  int? status;
  String? lattitude;
  String? longitude;
  String? statusDescription;

  LocationsDetailsSales(
      {this.locationId,
      this.retailerInternalId,
      this.retailerName,
      this.storeId,
      this.storeName,
      this.storeAddress,
      this.status,
      this.lattitude,
      this.longitude,
      this.statusDescription});

  LocationsDetailsSales.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    retailerInternalId = json['retailer_internal_id'];
    retailerName = json['retailer_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    status = json['status'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    statusDescription = json['status_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['retailer_internal_id'] = this.retailerInternalId;
    data['retailer_name'] = this.retailerName;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['status'] = this.status;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['status_description'] = this.statusDescription;
    return data;
  }
}

class AssignableUserList {
  String? assignToUniqueId;
  String? assignTo;

  AssignableUserList({this.assignToUniqueId, this.assignTo});

  AssignableUserList.fromJson(Map<String, dynamic> json) {
    assignToUniqueId = json['assign_to_unique_id'];
    assignTo = json['assign_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assign_to_unique_id'] = this.assignToUniqueId;
    data['assign_to'] = this.assignTo;
    return data;
  }
}
