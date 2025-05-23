class RoutesDetailsModel {
  bool? success;
  String? message;
  List<RoutesDetailsModelData>? data;

  RoutesDetailsModel({this.success, this.message, this.data});

  RoutesDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RoutesDetailsModelData>[];
      json['data'].forEach((v) {
        data!.add(RoutesDetailsModelData.fromJson(v));
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

class RoutesDetailsModelData {
  String? uniqueId;
  String? description;
  String? routeId;
  String? date;
  String? createdAt;
  int? status;
  String? updatedDate;
  int? retailersCount;
  int? storesCount;
  String? assignTo;
  String? assignToUniqueId;
  String? statusDescription;
  List<LocationsDetails>? locationsDetails;
  List<AssignableUserList>? assignableUserList;

  RoutesDetailsModelData(
      {this.uniqueId,
      this.description,
      this.routeId,
      this.date,
      this.createdAt,
      this.status,
      this.updatedDate,
      this.retailersCount,
      this.storesCount,
      this.assignTo,
      this.assignToUniqueId,
      this.statusDescription,
      this.locationsDetails,
      this.assignableUserList});

  RoutesDetailsModelData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    description = json['description'];
    routeId = json['route_id'];
    date = json['date'];
    createdAt = json['created_at'];
    status = json['status'];
    updatedDate = json['updated_date'];
    retailersCount = json['retailers_count'];
    storesCount = json['stores_count'];
    assignTo = json['assign_to'];
    assignToUniqueId = json['assign_to_unique_id'];
    statusDescription = json['status_description'];
    if (json['locations_details'] != null) {
      locationsDetails = <LocationsDetails>[];
      json['locations_details'].forEach((v) {
        locationsDetails!.add(LocationsDetails.fromJson(v));
      });
    }
    if (json['assignable_user_list'] != null) {
      assignableUserList = <AssignableUserList>[];
      json['assignable_user_list'].forEach((v) {
        assignableUserList!.add(AssignableUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['description'] = description;
    data['route_id'] = routeId;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['updated_date'] = updatedDate;
    data['retailers_count'] = retailersCount;
    data['stores_count'] = storesCount;
    data['assign_to'] = assignTo;
    data['assign_to_unique_id'] = assignToUniqueId;
    data['status_description'] = statusDescription;
    if (locationsDetails != null) {
      data['locations_details'] =
          locationsDetails!.map((v) => v.toJson()).toList();
    }
    if (assignableUserList != null) {
      data['assignable_user_list'] =
          assignableUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationsDetails {
  String? locationId;
  int? visitOrder;
  String? retailerInternalId;
  String? retailerName;
  String? storeId;
  String? storeName;
  String? storeAddress;
  String? bingoStoreId;
  String? retailerId;
  String? lattitude;
  String? longitude;
  int? status;
  String? statusDescription;

  LocationsDetails(
      {this.locationId,
      this.visitOrder,
      this.retailerInternalId,
      this.retailerName,
      this.storeId,
      this.storeName,
      this.storeAddress,
      this.bingoStoreId,
      this.retailerId,
      this.lattitude,
      this.longitude,
      this.status,
      this.statusDescription});

  LocationsDetails.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    visitOrder = json['visit_order'];
    retailerInternalId = json['retailer_internal_id'];
    retailerName = json['retailer_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    bingoStoreId = json['bingo_store_id'];
    retailerId = json['retailer_id'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    status = json['status'];
    statusDescription = json['status_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['visit_order'] = visitOrder;
    data['retailer_internal_id'] = retailerInternalId;
    data['retailer_name'] = retailerName;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_address'] = storeAddress;
    data['bingo_store_id'] = bingoStoreId;
    data['retailer_id'] = retailerId;
    data['lattitude'] = lattitude;
    data['longitude'] = longitude;
    data['status'] = status;
    data['status_description'] = statusDescription;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assign_to_unique_id'] = assignToUniqueId;
    data['assign_to'] = assignTo;
    return data;
  }
}
