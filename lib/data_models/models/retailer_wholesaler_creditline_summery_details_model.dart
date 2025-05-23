class RetailerWholesalerCreditlineSummaryDetailsModel {
  RetailerWholesalerCreditlineDetailsModel?
      retailerWholesalerCreditlineDetailsModel;
  RetailerWholesalerCreditlineSummaryModel?
      retailerWholesalerCreditlineSummaryModel;
  RetailerWholesalerCreditlineSummaryDetailsModel(
      {this.retailerWholesalerCreditlineDetailsModel,
      this.retailerWholesalerCreditlineSummaryModel});
}

class RetailerWholesalerCreditlineDetailsModel {
  bool? success;
  String? message;
  List<DetailsData>? data;

  RetailerWholesalerCreditlineDetailsModel(
      {this.success, this.message, this.data});

  RetailerWholesalerCreditlineDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DetailsData>[];
      json['data'].forEach((v) {
        data!.add(DetailsData.fromJson(v));
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

class DetailsData {
  String? uniqueId;
  String? saleId;
  String? documentType;
  String? documentId;
  String? storeName;
  String? retailerName;
  String? invoice;
  String? currency;
  String? amount;
  String? openBalance;

  DetailsData(
      {this.uniqueId,
      this.saleId,
      this.documentType,
      this.documentId,
      this.storeName,
      this.retailerName,
      this.invoice,
      this.currency,
      this.amount,
      this.openBalance});

  DetailsData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    saleId = json['sale_id'];
    documentType = json['document_type'];
    documentId = json['document_id'];
    storeName = json['store_name'];
    retailerName = json['retailer_name'];
    invoice = json['invoice'];
    currency = json['currency'];
    amount = json['amount'];
    openBalance = json['open_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['sale_id'] = saleId;
    data['document_type'] = documentType;
    data['document_id'] = documentId;
    data['store_name'] = storeName;
    data['retailer_name'] = retailerName;
    data['invoice'] = invoice;
    data['currency'] = currency;
    data['amount'] = amount;
    data['open_balance'] = openBalance;
    return data;
  }
}

class RetailerWholesalerCreditlineSummaryModel {
  bool? success;
  String? message;
  SummaryData? data;

  RetailerWholesalerCreditlineSummaryModel(
      {this.success, this.message, this.data});

  RetailerWholesalerCreditlineSummaryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? SummaryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SummaryData {
  CreditlineHeader? creditlineHeader;
  List<RetailerStores>? retailerStores;
  List<String>? complementaryCreditlines;

  SummaryData(
      {this.creditlineHeader,
      this.retailerStores,
      this.complementaryCreditlines});

  SummaryData.fromJson(Map<String, dynamic> json) {
    creditlineHeader = json['creditline_header'] != null
        ? CreditlineHeader.fromJson(json['creditline_header'])
        : null;
    if (json['retailer_stores'] != null) {
      retailerStores = <RetailerStores>[];
      json['retailer_stores'].forEach((v) {
        retailerStores!.add(RetailerStores.fromJson(v));
      });
    }
    // if (json['complementary_creditlines'] != null) {
    //   complementaryCreditlines = <String>[];
    //   json['complementary_creditlines'].forEach((v) {
    //     complementaryCreditlines!.add(new [].fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (creditlineHeader != null) {
      data['creditline_header'] = creditlineHeader!.toJson();
    }
    if (retailerStores != null) {
      data['retailer_stores'] = retailerStores!.map((v) => v.toJson()).toList();
    }
    // if (this.complementaryCreditlines != null) {
    //   data['complementary_creditlines'] =
    //       this.complementaryCreditlines!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class CreditlineHeader {
  List<ApprovedCreditlines>? approvedCreditlines;

  CreditlineHeader({this.approvedCreditlines});

  CreditlineHeader.fromJson(Map<String, dynamic> json) {
    if (json['approved_creditlines'] != null) {
      approvedCreditlines = <ApprovedCreditlines>[];
      json['approved_creditlines'].forEach((v) {
        approvedCreditlines!.add(ApprovedCreditlines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approvedCreditlines != null) {
      data['approved_creditlines'] =
          approvedCreditlines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApprovedCreditlines {
  String? uniqueId;
  String? creditlineId;
  String? wholesalerName;
  String? financialInstitution;
  String? bankName;
  String? bankAccountNumber;
  String? approvedAmount;
  String? remainingAmount;
  String? dateApproved;
  String? minimumCommitmentDate;

  ApprovedCreditlines(
      {this.uniqueId,
      this.creditlineId,
      this.wholesalerName,
      this.financialInstitution,
      this.bankName,
      this.bankAccountNumber,
      this.approvedAmount,
      this.remainingAmount,
      this.dateApproved,
      this.minimumCommitmentDate});

  ApprovedCreditlines.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    creditlineId = json['creditline_id'];
    wholesalerName = json['wholesaler_name'];
    financialInstitution = json['financial_institution'];
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    approvedAmount = json['approved_amount'];
    remainingAmount = json['remaining_amount'];
    dateApproved = json['date_approved'];
    minimumCommitmentDate = json['minimum_commitment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['creditline_id'] = creditlineId;
    data['wholesaler_name'] = wholesalerName;
    data['financial_institution'] = financialInstitution;
    data['bank_name'] = bankName;
    data['bank_account_number'] = bankAccountNumber;
    data['approved_amount'] = approvedAmount;
    data['remaining_amount'] = remainingAmount;
    data['date_approved'] = dateApproved;
    data['minimum_commitment_date'] = minimumCommitmentDate;
    return data;
  }
}

class RetailerStores {
  String? locationName;
  String? address;
  String? assignedAmount;
  String? consumedAmount;

  RetailerStores(
      {this.locationName,
      this.address,
      this.assignedAmount,
      this.consumedAmount});

  RetailerStores.fromJson(Map<String, dynamic> json) {
    locationName = json['location_name'];
    address = json['address'];
    assignedAmount = json['assigned_amount'];
    consumedAmount = json['consumed_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_name'] = locationName;
    data['address'] = address;
    data['assigned_amount'] = assignedAmount;
    data['consumed_amount'] = consumedAmount;
    return data;
  }
}
