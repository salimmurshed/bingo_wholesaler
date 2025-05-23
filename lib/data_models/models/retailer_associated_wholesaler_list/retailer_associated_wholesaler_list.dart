class RetailerAssociatedWholesalerList {
  bool? success;
  String? message;
  List<RetailerAssociatedWholesalerListData>? data;

  RetailerAssociatedWholesalerList({this.success, this.message, this.data});

  RetailerAssociatedWholesalerList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RetailerAssociatedWholesalerListData>[];
      json['data'].forEach((v) {
        data!.add(new RetailerAssociatedWholesalerListData.fromJson(v));
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

class RetailerAssociatedWholesalerListData {
  String? uniqueId;
  String? wholesalerName;
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
  String? bpCompanyLogoUrl;
  String? tempTxAddress;

  RetailerAssociatedWholesalerListData(
      {this.uniqueId,
      this.wholesalerName,
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
      this.supportedDocuments,
      this.bpCompanyLogoUrl,
      this.tempTxAddress});

  RetailerAssociatedWholesalerListData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    wholesalerName = json['wholesaler_name'] ?? "";
    companyName = json['company_name'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    taxId = json['tax_id'] ?? "";
    status = json['status'] ?? "";
    bpEmail = json['bp_email'] ?? "";
    associationDate = json['association_date'] ?? "";
    address = json['address'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    position = json['position'] ?? "";
    contactId = json['contact_id'] ?? "";
    contactPhoneNumber = json['contact_phone_number'] ?? "";
    supportedDocuments = json['supported_documents'] ?? "";
    bpCompanyLogoUrl = json['bp_company_logo_url'] ?? "";
    tempTxAddress = json['temp_tx_address'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['wholesaler_name'] = this.wholesalerName;
    data['company_name'] = this.companyName;
    data['phone_number'] = this.phoneNumber;
    data['tax_id'] = this.taxId;
    data['status'] = this.status;
    data['bp_email'] = this.bpEmail;
    data['association_date'] = this.associationDate;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['position'] = this.position;
    data['contact_id'] = this.contactId;
    data['contact_phone_number'] = this.contactPhoneNumber;
    data['supported_documents'] = this.supportedDocuments;
    data['bp_company_logo_url'] = this.bpCompanyLogoUrl;
    data['temp_tx_address'] = this.tempTxAddress;
    return data;
  }
}
