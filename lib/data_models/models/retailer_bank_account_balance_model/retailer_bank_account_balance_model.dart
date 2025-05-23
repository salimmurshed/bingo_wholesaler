class RetailerBankAccountBalanceModel {
  bool? success;
  String? message;
  List<RetailerBankAccountBalanceData>? data;

  RetailerBankAccountBalanceModel({this.success, this.message, this.data});

  RetailerBankAccountBalanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RetailerBankAccountBalanceData>[];
      json['data'].forEach((v) {
        data!.add(RetailerBankAccountBalanceData.fromJson(v));
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

class RetailerBankAccountBalanceData {
  String? uniqueId;
  int? bankAccountType;
  String? currency;
  String? bankAccountNumber;
  String? iban;
  String? updatedAt;
  String? fieId;
  String? fieName;
  int? status;
  String? balance;
  String? bankName;
  String? date;
  String? statusDescription;
  String? bankAccountTypeDescription;

  RetailerBankAccountBalanceData(
      {this.uniqueId,
      this.bankAccountType,
      this.currency,
      this.bankAccountNumber,
      this.iban,
      this.updatedAt,
      this.fieId,
      this.fieName,
      this.status,
      this.balance,
      this.bankName,
      this.date,
      this.statusDescription,
      this.bankAccountTypeDescription});

  RetailerBankAccountBalanceData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    bankAccountType = json['bank_account_type'] ?? 0;
    currency = json['currency'] ?? "-";
    bankAccountNumber = json['bank_account_number'] ?? "-";
    iban = json['iban'] ?? "-";
    updatedAt = json['updated_at'] ?? "-";
    fieId = json['fie_id'] ?? "-";
    fieName = json['fie_name'] ?? "-";
    status = json['status'] ?? 0;
    balance = json['balance'] ?? "-";
    bankName = json['bank_name'] ?? "-";
    date = json['date'] ?? "-";
    statusDescription = json['status_description'] ?? "-";
    bankAccountTypeDescription = json['bank_account_type_description'] ?? "-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['bank_account_type'] = bankAccountType;
    data['currency'] = currency;
    data['bank_account_number'] = bankAccountNumber;
    data['iban'] = iban;
    data['updated_at'] = updatedAt;
    data['fie_id'] = fieId;
    data['fie_name'] = fieName;
    data['status'] = status;
    data['balance'] = balance;
    data['bank_name'] = bankName;
    data['date'] = date;
    data['status_description'] = statusDescription;
    data['bank_account_type_description'] = bankAccountTypeDescription;
    return data;
  }
}
