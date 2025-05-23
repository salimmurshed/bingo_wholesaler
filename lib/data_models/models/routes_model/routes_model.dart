class RoutesModel {
  bool? success;
  String? message;
  Data? data;

  RoutesModel({this.success, this.message, this.data});

  RoutesModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<RoutesModelData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
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
      data = <RoutesModelData>[];
      json['data'].forEach((v) {
        data!.add(RoutesModelData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ?? "";
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    lastPageUrl = json['last_page_url'] ?? "";
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'] ?? "";
    path = json['path'] ?? "";
    perPage = json['per_page'].toString();
    prevPageUrl = json['prev_page_url'] ?? "";
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class RoutesModelData {
  String? uniqueId;
  String? description;
  String? routeId;
  String? salesId;
  String? salesZoneName;
  String? date;
  String? createdAt;
  int? status;
  String? updatedDate;
  int? retailersCount;
  int? storesCount;
  String? assignTo;
  String? saleStep;
  String? statusDescription;

  RoutesModelData(
      {this.uniqueId,
      this.description,
      this.routeId,
      this.salesId,
      this.salesZoneName,
      this.date,
      this.createdAt,
      this.status,
      this.updatedDate,
      this.retailersCount,
      this.storesCount,
      this.assignTo,
      this.saleStep,
      this.statusDescription});

  RoutesModelData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "-";
    description = json['description'] ?? "-";
    routeId = json['route_id'] ?? "-";
    salesId = json['sales_id'] ?? "-";
    salesZoneName = json['sales_zone_name'] ?? "-";
    date = json['date'] ?? "-";
    createdAt = json['created_at'] ?? "-";
    status = json['status'] ?? 0;
    updatedDate = json['updated_date'] ?? "-";
    retailersCount = json['retailers_count'] ?? 0;
    storesCount = json['stores_count'] ?? 0;
    assignTo = json['assign_to'] ?? "-";
    saleStep = json['sales_step'] ?? "-";
    statusDescription = json['status_description'] ?? "-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['description'] = description;
    data['route_id'] = routeId;
    data['sales_id'] = salesId;
    data['sales_zone_name'] = salesZoneName;
    data['date'] = date;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['updated_date'] = updatedDate;
    data['retailers_count'] = retailersCount;
    data['stores_count'] = storesCount;
    data['assign_to'] = assignTo;
    data['sales_step'] = saleStep;
    data['status_description'] = statusDescription;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
