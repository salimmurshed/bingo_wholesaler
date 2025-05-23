class WholesalerForOrderModel {
  bool? success;
  String? message;
  List<WholesalerForOrderData>? data;

  WholesalerForOrderModel({this.success, this.message, this.data});

  WholesalerForOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WholesalerForOrderData>[];
      json['data'].forEach((v) {
        data!.add(new WholesalerForOrderData.fromJson(v));
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

class WholesalerForOrderData {
  String? uniqueId;
  String? name;
  String? phoneNo;
  String? taxId;
  String? email;
  String? status;
  String? logo;

  WholesalerForOrderData(
      {this.uniqueId,
      this.name,
      this.phoneNo,
      this.taxId,
      this.email,
      this.status,
      this.logo});

  WholesalerForOrderData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    name = json['name'];
    phoneNo = json['phone_no'];
    taxId = json['tax_id'];
    email = json['email'];
    status = json['status'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['tax_id'] = this.taxId;
    data['email'] = this.email;
    data['status'] = this.status;
    data['logo'] = this.logo;
    return data;
  }
}
