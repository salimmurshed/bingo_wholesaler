class FieLotDetailsModel {
  bool? success;
  String? message;
  List<Data>? data;

  FieLotDetailsModel({this.success, this.message, this.data});

  FieLotDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? lotNumber;
  String? lotId;
  String? lotType;
  String? dateGenerated;
  String? postingDate;
  String? currency;
  String? openBalanceAmount;
  String? amountCollected;
  String? user;
  int? status;
  String? statusDescription;
  List<PaymentDetails>? paymentDetails;

  Data(
      {this.lotNumber,
      this.lotId,
      this.lotType,
      this.dateGenerated,
      this.postingDate,
      this.currency,
      this.openBalanceAmount,
      this.amountCollected,
      this.user,
      this.status,
      this.statusDescription,
      this.paymentDetails});

  Data.fromJson(Map<String, dynamic> json) {
    lotNumber = json['lot_number'] ?? 0;
    lotId = json['lot_id'] ?? "";
    lotType = json['lot_type'] ?? "";
    dateGenerated = json['date_generated'] ?? "";
    postingDate = json['posting_date'] ?? "";
    currency = json['currency'] ?? "";
    openBalanceAmount = json['open_balance_amount'] ?? "0.0";
    amountCollected = json['amount_collected'] ?? "0.0";
    user = json['user'] ?? "";
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? "";
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lot_number'] = this.lotNumber;
    data['lot_id'] = this.lotId;
    data['lot_type'] = this.lotType;
    data['date_generated'] = this.dateGenerated;
    data['posting_date'] = this.postingDate;
    data['currency'] = this.currency;
    data['open_balance_amount'] = this.openBalanceAmount;
    data['amount_collected'] = this.amountCollected;
    data['user'] = this.user;
    data['status'] = this.status;
    data['status_description'] = this.statusDescription;
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetails {
  String? lotId;
  String? documentId;
  String? documentType;
  String? invoice;
  double? openBalance;
  double? amountApplied;
  String? businessPartnerId;
  String? creditLineId;
  int? status;
  String? statusDescription;

  PaymentDetails(
      {this.lotId,
      this.documentId,
      this.documentType,
      this.invoice,
      this.openBalance,
      this.amountApplied,
      this.businessPartnerId,
      this.creditLineId,
      this.status,
      this.statusDescription});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    lotId = json['lot_id'] ?? "";
    documentId = json['document_id'] ?? "";
    documentType = json['document_type'] ?? "";
    invoice = json['invoice'] ?? "";
    openBalance = double.parse(
        (json['open_balance'] ?? "0.0").toString().replaceAll(',', ''));
    amountApplied = double.parse(
        (json['amount_applied'] ?? "0.0").toString().replaceAll(',', ''));
    businessPartnerId = json['business_partner_id'] ?? "";
    creditLineId = json['credit_line_id'] ?? "";
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lot_id'] = this.lotId;
    data['document_id'] = this.documentId;
    data['document_type'] = this.documentType;
    data['invoice'] = this.invoice;
    data['open_balance'] = this.openBalance;
    data['amount_applied'] = this.amountApplied;
    data['business_partner_id'] = this.businessPartnerId;
    data['credit_line_id'] = this.creditLineId;
    data['status'] = this.status;
    data['status_description'] = this.statusDescription;
    return data;
  }
}

class PaymentPartners {
  String? partner;
  double? balance;
  double? amount;
  List<PaymentDetails>? paymentDetails;

  PaymentPartners(
      {this.partner, this.balance = 0.0, this.amount, this.paymentDetails});
}
