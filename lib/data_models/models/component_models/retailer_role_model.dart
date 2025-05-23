class RetailerRolesModel {
  bool? success;
  String? message;
  List<RetailerRolesData>? data;

  RetailerRolesModel({this.success, this.message, this.data});

  RetailerRolesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RetailerRolesData>[];
      json['data'].forEach((v) {
        data!.add(RetailerRolesData.fromJson(v));
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

class RetailerRolesData {
  String? uniqueId;
  String? roleName;
  String? roleDescription;
  int? isStatus;
  String? createdAt;
  String? statusDescription;

  RetailerRolesData(
      {this.uniqueId,
      this.roleName,
      this.roleDescription,
      this.isStatus,
      this.createdAt,
      this.statusDescription});

  RetailerRolesData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    roleName = json['role_name'];
    roleDescription = json['role_description'];
    isStatus = json['is_status'];
    createdAt = json['created_at'];
    statusDescription = json['status_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['role_name'] = this.roleName;
    data['role_description'] = this.roleDescription;
    data['is_status'] = this.isStatus;
    data['created_at'] = this.createdAt;
    data['status_description'] = this.statusDescription;
    return data;
  }
}
