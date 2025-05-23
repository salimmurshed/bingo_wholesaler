class FieAccountModel {
  bool? success;
  String? message;
  List<FieAccountModelData>? data;

  FieAccountModel({this.success, this.message, this.data});

  FieAccountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FieAccountModelData>[];
      json['data'].forEach((v) {
        data!.add(FieAccountModelData.fromJson(v));
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

class FieAccountModelData {
  String? effectiveDate;
  String? accountType;
  String? accountNumber;
  String? costCenter;
  String? debitCredit;
  String? currency;
  String? amount;

  FieAccountModelData(
      {this.effectiveDate,
      this.accountType,
      this.accountNumber,
      this.costCenter,
      this.debitCredit,
      this.currency,
      this.amount});

  FieAccountModelData.fromJson(Map<String, dynamic> json) {
    effectiveDate = json['effective_date'];
    accountType = json['account_type'];
    accountNumber = json['account_number'].toString();
    costCenter = json['cost_center'];
    debitCredit = json['debit_credit'];
    currency = json['currency'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['effective_date'] = effectiveDate;
    data['account_type'] = accountType;
    data['account_number'] = accountNumber;
    data['cost_center'] = costCenter;
    data['debit_credit'] = debitCredit;
    data['currency'] = currency;
    data['amount'] = amount;
    return data;
  }
}
