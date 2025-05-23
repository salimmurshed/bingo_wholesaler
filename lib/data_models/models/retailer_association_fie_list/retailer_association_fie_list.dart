class RetailerAssociationFieList {
  bool? success;
  String? message;
  Data? data;

  RetailerAssociationFieList({this.success, this.message, this.data});

  RetailerAssociationFieList.fromJson(Map<String, dynamic> json) {
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
  List<RetailerAssociationFieListData>? data;
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
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <RetailerAssociationFieListData>[];
      json['data'].forEach((v) {
        data!.add(RetailerAssociationFieListData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
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

class RetailerAssociationFieListData {
  String? uniqueId;
  String? fieName;
  String? companyName;
  String? phoneNumber;
  String? taxId;
  String? status;
  String? bpEmail;
  String? associationDate;
  String? address;
  String? latitude;
  String? longitude;
  String? firstName;
  String? lastName;
  String? position;
  String? contactId;
  String? contactPhoneNumber;
  String? supportedDocuments;

  RetailerAssociationFieListData(
      {this.uniqueId,
      this.fieName,
      this.companyName,
      this.phoneNumber,
      this.taxId,
      this.status,
      this.bpEmail,
      this.associationDate,
      this.address,
      this.latitude,
      this.longitude,
      this.firstName,
      this.lastName,
      this.position,
      this.contactId,
      this.contactPhoneNumber,
      this.supportedDocuments});

  RetailerAssociationFieListData.fromJson(Map<String, dynamic> json) {
    uniqueId = (json['unique_id'] ?? "-");
    fieName = (json['fie_name'] ?? "-");
    companyName = (json['company_name'] ?? "-");
    phoneNumber = (json['phone_number'] ?? "-");
    taxId = (json['tax_id'] ?? "-");
    status = (json['status'] ?? "-");
    bpEmail = (json['bp_email'] ?? "-");
    associationDate = (json['association_date'] ?? "-");
    address = (json['address'] ?? "-");
    latitude = (json['latitude'] ?? "-");
    longitude = (json['longitude'] ?? "-");
    firstName = (json['first_name'] ?? "-");
    lastName = (json['last_name'] ?? "-");
    position = (json['position'] ?? "-");
    contactId = (json['contact_id'] ?? "-");
    contactPhoneNumber = (json['contact_phone_number'] ?? "-");
    supportedDocuments = (json['supported_documents'] ?? "-");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['fie_name'] = fieName;
    data['company_name'] = companyName;
    data['phone_number'] = phoneNumber;
    data['tax_id'] = taxId;
    data['status'] = status;
    data['bp_email'] = bpEmail;
    data['association_date'] = associationDate;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['position'] = position;
    data['contact_id'] = contactId;
    data['contact_phone_number'] = contactPhoneNumber;
    data['supported_documents'] = supportedDocuments;
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
