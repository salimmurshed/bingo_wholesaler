class SaleZones {
  bool? success;
  String? message;
  Data? data;

  SaleZones({this.success, this.message, this.data});

  SaleZones.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int? currentPage;
  List<SaleZonesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    if (json['data'] != null) {
      data = <SaleZonesData>[];
      json['data'].forEach((v) {
        data!.add(new SaleZonesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ?? "";
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    lastPageUrl = json['last_page_url'] ?? "";
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'] ?? "";
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    prevPageUrl = json['prev_page_url'] ?? "";
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class SaleZonesData {
  String? uniqueId;
  String? salesId;
  String? salesZoneName;
  String? salesStep;
  int? status;
  String? assignTo;
  String? createdAt;
  int? retailersCount;
  int? storesCount;
  String? salesStepDescription;
  String? statusDescription;

  // String? lattitude;
  // String? longitude;

  SaleZonesData(
      {this.uniqueId,
      this.salesId,
      this.salesZoneName,
      this.salesStep,
      this.status,
      this.assignTo,
      this.createdAt,
      this.retailersCount,
      this.storesCount,
      this.salesStepDescription,
      this.statusDescription
      // this.lattitude,
      // this.longitude
      });

  SaleZonesData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    salesId = json['sales_id'];
    salesZoneName = json['sales_zone_name'];
    salesStep = json['sales_step'];
    status = json['status'];
    assignTo = json['assign_to'];
    createdAt = json['created_at'];
    retailersCount = json['retailers_count'];
    storesCount = json['stores_count'];
    salesStepDescription = json['sales_step_description'];
    statusDescription = json['status_description'];
    // lattitude = json['lattitude'];
    // longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['sales_id'] = this.salesId;
    data['sales_zone_name'] = this.salesZoneName;
    data['sales_step'] = this.salesStep;
    data['status'] = this.status;
    data['assign_to'] = this.assignTo;
    data['created_at'] = this.createdAt;
    data['retailers_count'] = this.retailersCount;
    data['stores_count'] = this.storesCount;
    data['sales_step_description'] = this.salesStepDescription;
    data['status_description'] = this.statusDescription;
    // data['lattitude'] = lattitude;
    // data['longitude'] = longitude;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
