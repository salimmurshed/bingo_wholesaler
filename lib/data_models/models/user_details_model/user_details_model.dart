class UserDetailsModel {
  bool? success;
  String? message;
  UserDetailsData? data;

  UserDetailsModel({this.success, this.message, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserDetailsData.fromJson(json['data']) : null;
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

class UserDetailsData {
  String? uniqueId;
  String? tempTxAddress;
  String? role;
  String? firstName;
  String? lastName;
  String? email;
  String? country;
  int? isMaster;
  int? status;
  String? idType;
  String? docId;
  List<String>? storeNameList;

  UserDetailsData(
      {this.uniqueId,
      this.tempTxAddress,
      this.role,
      this.firstName,
      this.lastName,
      this.email,
      this.country,
      this.isMaster,
      this.status,
      this.idType,
      this.docId,
      this.storeNameList});

  UserDetailsData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    tempTxAddress = json['temp_tx_address'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    country = json['country'];
    isMaster = json['is_master'];
    status = json['status'];
    idType = json['id_type'];
    docId = json['doc_id'];
    storeNameList = json['store_name_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['temp_tx_address'] = tempTxAddress;
    data['role'] = role;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['country'] = country;
    data['is_master'] = isMaster;
    data['status'] = status;
    data['id_type'] = idType;
    data['doc_id'] = docId;
    data['store_name_list'] = storeNameList;
    return data;
  }
}
