class DownloadXmlCvs {
  bool? success;
  String? message;
  List<DownloadXmlCvsData>? data;

  DownloadXmlCvs({this.success, this.message, this.data});

  DownloadXmlCvs.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DownloadXmlCvsData>[];
      json['data'].forEach((v) {
        data!.add(DownloadXmlCvsData.fromJson(v));
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

class DownloadXmlCvsData {
  String? sequence;
  String? effectiveDate;
  String? accountType;
  String? accountNumber;
  String? costCenter;
  String? debitCredit;
  String? currency;
  String? amount;

  DownloadXmlCvsData(
      {this.sequence,
      this.effectiveDate,
      this.accountType,
      this.accountNumber,
      this.costCenter,
      this.debitCredit,
      this.currency,
      this.amount});

  DownloadXmlCvsData.fromJson(Map<String, dynamic> json) {
    sequence = json['Sequence'].toString();
    effectiveDate = json['Effective_date'];
    accountType = json['Account_type'];
    accountNumber = json['Account_number'].toString();
    costCenter = json['Cost_center'];
    debitCredit = json['Debit_Credit'];
    currency = json['Currency'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Sequence'] = sequence;
    data['Effective_date'] = effectiveDate;
    data['Account_type'] = accountType;
    data['Account_number'] = accountNumber;
    data['Cost_center'] = costCenter;
    data['Debit_Credit'] = debitCredit;
    data['Currency'] = currency;
    data['Amount'] = amount;
    return data;
  }
}
