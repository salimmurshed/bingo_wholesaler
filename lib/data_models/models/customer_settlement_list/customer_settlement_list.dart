class CustomerSettlementModel {
  bool? success;
  String? message;
  List<CustomerSettlementData>? data;

  CustomerSettlementModel({this.success, this.message, this.data});

  CustomerSettlementModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CustomerSettlementData>[];
      json['data'].forEach((v) {
        data!.add(CustomerSettlementData.fromJson(v));
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

class CustomerSettlementData {
  String? postingDate;
  String? lotId;
  String? retailerUniqueId;
  String? currency;
  String? amount;
  int? status;
  String? statusDescription;
  String? lotType;
  int? type;
  String? dateGenerated;
  String? openBalance;
  String? confirmedAmount;
  int? user;
  List<PaymentDetail>? paymentDetail;

  CustomerSettlementData(
      {this.postingDate,
      this.lotId,
      this.retailerUniqueId,
      this.currency,
      this.amount,
      this.status,
      this.statusDescription,
      this.lotType,
      this.type,
      this.dateGenerated,
      this.openBalance,
      this.confirmedAmount,
      this.user,
      this.paymentDetail});

  CustomerSettlementData.fromJson(Map<String, dynamic> json) {
    postingDate = json['posting_date'];
    lotId = json['lot_id'];
    retailerUniqueId = json['retailer_unique_id'];
    currency = json['currency'];
    amount = json['amount'];
    status = json['status'];
    statusDescription = json['status_description'];
    lotType = json['lot_type'];
    type = json['type'];
    dateGenerated = json['date_generated'];
    openBalance = json['open_balance'];
    confirmedAmount = json['confirmed_amount'];
    user = json['user'];
    if (json['payment_detail'] != null) {
      paymentDetail = <PaymentDetail>[];
      json['payment_detail'].forEach((v) {
        paymentDetail!.add(PaymentDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posting_date'] = postingDate;
    data['lot_id'] = lotId;
    data['retailer_unique_id'] = retailerUniqueId;
    data['currency'] = currency;
    data['amount'] = amount;
    data['status'] = status;
    data['status_description'] = statusDescription;
    data['lot_type'] = lotType;
    data['type'] = type;
    data['date_generated'] = dateGenerated;
    data['open_balance'] = openBalance;
    data['confirmed_amount'] = confirmedAmount;
    data['user'] = user;
    if (paymentDetail != null) {
      data['payment_detail'] =
          paymentDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetail {
  int? id;
  String? uniqueId;
  String? saleUniqueId;
  String? financialEntriesUniqueId;
  String? settlementUniqueId;
  int? creditLineId;
  String? documentTypeUniqueId;
  String? enrollmentType;
  int? bpId;
  String? invoice;
  String? openBalance;
  String? amount;
  String? appliedAmount;
  String? dateGenerated;
  String? dueDate;
  int? status;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? documentType;
  String? tempTxAddress;
  String? partnerName;

  PaymentDetail(
      {this.id,
      this.uniqueId,
      this.saleUniqueId,
      this.financialEntriesUniqueId,
      this.settlementUniqueId,
      this.creditLineId,
      this.documentTypeUniqueId,
      this.enrollmentType,
      this.bpId,
      this.invoice,
      this.openBalance,
      this.amount,
      this.appliedAmount,
      this.dateGenerated,
      this.dueDate,
      this.status,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.documentType,
      this.tempTxAddress,
      this.partnerName});

  PaymentDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    saleUniqueId = json['sale_unique_id'];
    financialEntriesUniqueId = json['financial_entries_unique_id'];
    settlementUniqueId = json['settlement_unique_id'];
    creditLineId = json['credit_line_id'];
    documentTypeUniqueId = json['document_type_unique_id'];
    enrollmentType = json['enrollment_type'];
    bpId = json['bp_id'];
    invoice = json['invoice'];
    openBalance = json['open_balance'].toString();
    amount = json['amount'].toString();
    appliedAmount = json['applied_amount'].toString();
    dateGenerated = json['date_generated'];
    dueDate = json['due_date'];
    status = json['status'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    documentType = json['document_type'];
    tempTxAddress = json['temp_tx_address'];
    partnerName = json['partner_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['sale_unique_id'] = saleUniqueId;
    data['financial_entries_unique_id'] = financialEntriesUniqueId;
    data['settlement_unique_id'] = settlementUniqueId;
    data['credit_line_id'] = creditLineId;
    data['document_type_unique_id'] = documentTypeUniqueId;
    data['enrollment_type'] = enrollmentType;
    data['bp_id'] = bpId;
    data['invoice'] = invoice;
    data['open_balance'] = openBalance;
    data['amount'] = amount;
    data['applied_amount'] = appliedAmount;
    data['date_generated'] = dateGenerated;
    data['due_date'] = dueDate;
    data['status'] = status;
    data['country'] = country;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['document_type'] = documentType;
    data['temp_tx_address'] = tempTxAddress;
    data['partner_name'] = partnerName;
    return data;
  }
}
