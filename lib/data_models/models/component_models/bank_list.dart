class BankList {
  bool? success;
  String? message;
  List<BankListData>? data;

  BankList({this.success, this.message, this.data});

  BankList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BankListData>[];
      json['data'].forEach((v) {
        data!.add(BankListData.fromJson(v));
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

class BankListData {
  String? bpName;
  String? bankUniqueId;
  List<String>? currency;

  BankListData({this.bpName, this.bankUniqueId, this.currency});

  BankListData.fromJson(Map<String, dynamic> json) {
    bpName = json['bp_name'];
    bankUniqueId = json['bank_unique_id'];
    currency = json['currency'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bp_name'] = bpName;
    data['bank_unique_id'] = bankUniqueId;
    data['currency'] = currency;
    return data;
  }
}
