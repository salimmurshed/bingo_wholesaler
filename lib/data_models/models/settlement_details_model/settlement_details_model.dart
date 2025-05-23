class SettlementDetailsModel {
  bool? success;
  String? message;
  List<SettlementDetailsData>? data;

  SettlementDetailsModel({this.success, this.message, this.data});

  SettlementDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SettlementDetailsData>[];
      json['data'].forEach((v) {
        data!.add(SettlementDetailsData.fromJson(v));
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

class SettlementDetailsData {
  int? lotNumber;
  String? lotId;
  String? lotType;
  String? dateGenerated;
  String? postingDate;
  String? currency;
  String? openBalanceAmount;
  String? amountCollected;
  String? effectiveDate;
  String? amount;
  int? type;
  String? user;
  int? status;
  String? statusDescription;
  List<PaymentDetails>? paymentDetails;

  SettlementDetailsData(
      {this.lotNumber,
      this.lotId,
      this.lotType,
      this.dateGenerated,
      this.postingDate,
      this.currency,
      this.openBalanceAmount,
      this.amountCollected,
      this.effectiveDate,
      this.amount,
      this.type,
      this.user,
      this.status,
      this.statusDescription,
      this.paymentDetails});

  SettlementDetailsData.fromJson(Map<String, dynamic> json) {
    lotNumber = json['lot_number'] ?? 0;
    lotId = json['lot_id'] ?? '';
    lotType = json['lot_type'] ?? '';
    dateGenerated = json['date_generated'] ?? '';
    postingDate = json['posting_date'] ?? '';
    currency = json['currency'] ?? '';
    openBalanceAmount = json['open_balance_amount'] ?? '';
    amountCollected = json['amount_collected'] ?? "";
    effectiveDate = json['effective_date'] ?? "";
    amount = json['amount'] ?? "";
    type = json['type'] ?? 0;
    user = json['user'] ?? '';
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? '';
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(PaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lot_number'] = lotNumber;
    data['lot_id'] = lotId;
    data['lot_type'] = lotType;
    data['date_generated'] = dateGenerated;
    data['posting_date'] = postingDate;
    data['currency'] = currency;
    data['open_balance_amount'] = openBalanceAmount;
    data['amount_collected'] = amountCollected;
    data['effective_date'] = effectiveDate;
    data['amount'] = amount;
    data['type'] = type;
    data['user'] = user;
    data['status'] = status;
    data['status_description'] = statusDescription;
    if (paymentDetails != null) {
      data['payment_details'] = paymentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetails {
  String? lotId;
  String? documentId;
  String? documentType;
  String? invoice;
  String? openBalance;
  String? amountApplied;
  String? businessPartnerId;
  String? creditLineId;
  int? status;
  String? clInternalId;
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
      this.clInternalId,
      this.statusDescription});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    lotId = json['lot_id'] ?? '';
    documentId = json['document_id'] ?? '';
    documentType = json['document_type'] ?? '';
    invoice = json['invoice'] ?? '';
    openBalance = json['open_balance'] ?? '';
    amountApplied = json['amount_applied'] ?? '';
    businessPartnerId = json['business_partner_id'] ?? '';
    creditLineId = json['credit_line_id'] ?? '';
    status = json['status'] ?? 0;
    clInternalId = json['cl_internal_id'] ?? "";
    statusDescription = json['status_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lot_id'] = lotId;
    data['document_id'] = documentId;
    data['document_type'] = documentType;
    data['invoice'] = invoice;
    data['open_balance'] = openBalance;
    data['amount_applied'] = amountApplied;
    data['business_partner_id'] = businessPartnerId;
    data['credit_line_id'] = creditLineId;
    data['status'] = status;
    data['cl_internal_id'] = this.clInternalId;
    data['status_description'] = statusDescription;
    return data;
  }
}
