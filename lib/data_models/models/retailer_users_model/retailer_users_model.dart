class RetailerUsersModel {
  bool? success;
  String? message;
  Data? data;

  RetailerUsersModel({this.success, this.message, this.data});

  RetailerUsersModel.fromJson(Map<String, dynamic> json) {
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
  List<RetailerUsersData>? data;
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
      data = <RetailerUsersData>[];
      json['data'].forEach((v) {
        data!.add(new RetailerUsersData.fromJson(v));
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
    nextPageUrl = json['next_page_url'] ?? '';
    path = json['path'];
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

class RetailerUsersData {
  int? id;
  String? uniqueId;
  String? tempTxAddress;
  String? firstName;
  String? lastName;
  String? email;
  String? employeeId;
  String? idType;
  String? idNumber;
  String? taxId;
  String? retailerStoreId;
  String? role;
  String? salesTeam;
  String? docId;
  String? branches;
  String? seller;
  String? country;
  int? isMaster;
  int? status;
  String? masterEmail;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? adderss;
  String? profileImage;
  String? roleId;
  String? isPasswordChanged;
  String? languageCode;
  String? storeNameList;
  String? statusDescription;

  RetailerUsersData(
      {this.id,
      this.uniqueId,
      this.tempTxAddress,
      this.firstName,
      this.lastName,
      this.email,
      this.employeeId,
      this.idType,
      this.idNumber,
      this.taxId,
      this.retailerStoreId,
      this.role,
      this.salesTeam,
      this.docId,
      this.branches,
      this.seller,
      this.country,
      this.isMaster,
      this.status,
      this.masterEmail,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.adderss,
      this.profileImage,
      this.roleId,
      this.isPasswordChanged,
      this.languageCode,
      this.storeNameList,
      this.statusDescription});

  RetailerUsersData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    uniqueId = json['unique_id'] ?? "";
    tempTxAddress = json['temp_tx_address'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    email = json['email'] ?? "";
    employeeId = json['employee_id'] ?? "";
    idType = json['id_type'] ?? "";
    idNumber = json['id_number'] ?? "";
    taxId = json['tax_id'] ?? "";
    retailerStoreId = json['retailer_store_id'] ?? "";
    role = json['role'] ?? "";
    salesTeam = json['sales_team'] ?? "";
    docId = json['doc_id'] ?? "";
    branches = json['branches'] ?? "";
    seller = json['seller'] ?? "";
    country = json['country'] ?? "";
    isMaster = json['is_master'] ?? 0;
    status = json['status'] ?? 0;
    masterEmail = json['master_email'] ?? "";
    createdBy = json['created_by'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    adderss = json['adderss'] ?? "";
    profileImage = json['profile_image'] ?? "";
    roleId = json['role_id'] ?? "";
    isPasswordChanged = json['is_password_changed'] ?? "";
    languageCode = json['language_code'] ?? "";
    storeNameList = json['store_name_list'] ?? "";
    statusDescription = json['status_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['temp_tx_address'] = this.tempTxAddress;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['employee_id'] = this.employeeId;
    data['id_type'] = this.idType;
    data['id_number'] = this.idNumber;
    data['tax_id'] = this.taxId;
    data['retailer_store_id'] = this.retailerStoreId;
    data['role'] = this.role;
    data['sales_team'] = this.salesTeam;
    data['doc_id'] = this.docId;
    data['branches'] = this.branches;
    data['seller'] = this.seller;
    data['country'] = this.country;
    data['is_master'] = this.isMaster;
    data['status'] = this.status;
    data['master_email'] = this.masterEmail;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['adderss'] = this.adderss;
    data['profile_image'] = this.profileImage;
    data['role_id'] = this.roleId;
    data['is_password_changed'] = this.isPasswordChanged;
    data['language_code'] = this.languageCode;
    data['store_name_list'] = this.storeNameList;
    data['status_description'] = this.statusDescription;
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
