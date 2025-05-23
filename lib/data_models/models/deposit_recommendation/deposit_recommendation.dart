class DepositRecommendation {
  bool? success;
  String? message;
  List<DepositRecommendationData>? data;

  DepositRecommendation({this.success, this.message, this.data});

  DepositRecommendation.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DepositRecommendationData>[];
      json['data'].forEach((v) {
        data!.add(new DepositRecommendationData.fromJson(v));
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

class DepositRecommendationData {
  String? fieName;
  String? bankAccountNumber;
  String? currency;
  String? balance;
  String? dueSaleAmount;
  String? depositeRecAmt;

  DepositRecommendationData(
      {this.fieName,
      this.bankAccountNumber,
      this.currency,
      this.balance,
      this.dueSaleAmount,
      this.depositeRecAmt});

  DepositRecommendationData.fromJson(Map<String, dynamic> json) {
    fieName = json['fie_name'];
    bankAccountNumber = json['bank_account_number'];
    currency = json['currency'];
    balance = json['balance'];
    dueSaleAmount = json['due_sale_amount'];
    depositeRecAmt = json['deposite_rec_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fie_name'] = this.fieName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['currency'] = this.currency;
    data['balance'] = this.balance;
    data['due_sale_amount'] = this.dueSaleAmount;
    data['deposite_rec_amt'] = this.depositeRecAmt;
    return data;
  }
}
