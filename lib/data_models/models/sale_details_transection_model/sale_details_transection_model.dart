class SaleDetailsTransection {
  bool? success;
  String? message;
  List<Data>? data;

  SaleDetailsTransection({this.success, this.message, this.data});

  SaleDetailsTransection.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? wholesalerName;
  String? availableAmount;
  String? retailerName;
  String? fieName;
  String? saleDate;
  String? dueDate;
  String? currency;
  String? amount;
  String? reversedAmount;
  String? invoiceNumber;
  String? orderNumber;
  String? bingoStoreId;
  String? salesStep;
  String? description;
  int? status;
  String? statusDescription;
  List<SaleTranctionDetails>? tranctionDetails;

  Data(
      {this.wholesalerName,
      this.availableAmount,
      this.retailerName,
      this.fieName,
      this.saleDate,
      this.dueDate,
      this.currency,
      this.amount,
      this.reversedAmount,
      this.invoiceNumber,
      this.orderNumber,
      this.bingoStoreId,
      this.salesStep,
      this.description,
      this.status,
      this.statusDescription,
      this.tranctionDetails});

  Data.fromJson(Map<String, dynamic> json) {
    wholesalerName = json['wholesaler_name'] ?? '';
    availableAmount = json['available_amount'] ?? '';
    retailerName = json['retailer_name'] ?? '';
    fieName = json['fie_name'] ?? '';
    saleDate = json['sale_date'] ?? json['date_of_invoice'] ?? '';
    dueDate = json['due_date'] ?? '';
    currency = json['currency'] ?? '';
    amount = json['amount'] ?? '';
    reversedAmount = json['reserved_amount'] ?? '';
    invoiceNumber = json['invoice_number'] ?? '';
    orderNumber = json['order_number'] ?? '';
    bingoStoreId = json['bingo_store_id'] ?? '';
    salesStep = json['sales_step'] ?? '';
    description = json['description'] ?? '';
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? '';
    if (json['tranction_details'] != null) {
      tranctionDetails = <SaleTranctionDetails>[];
      json['tranction_details'].forEach((v) {
        tranctionDetails!.add(SaleTranctionDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wholesaler_name'] = wholesalerName;
    data['available_amount'] = availableAmount;
    data['retailer_name'] = retailerName;
    data['fie_name'] = fieName;
    data['sale_date'] = saleDate;
    data['due_date'] = dueDate;
    data['currency'] = currency;
    data['amount'] = amount;
    data['reserved_amount'] = reversedAmount;
    data['invoice_number'] = invoiceNumber;
    data['order_number'] = orderNumber;
    data['bingo_store_id'] = bingoStoreId;
    data['sales_step'] = salesStep;
    data['description'] = description;
    data['status'] = status;
    data['status_description'] = statusDescription;
    if (tranctionDetails != null) {
      data['tranction_details'] =
          tranctionDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleTranctionDetails {
  String? saleUniqueId;
  String? invoice;
  String? currency;
  String? documentType;
  String? documentId;
  String? settlementUniqueId;
  String? collectionLotId;
  String? postingDate;
  String? storeName;
  String? retailerName;
  int? status;
  String? dateGenerated;
  String? dueDate;
  String? amount;
  String? openBalance;
  String? appliedAmount;
  String? statusDescription;
  String? contractAccount;

  SaleTranctionDetails(
      {this.saleUniqueId,
      this.invoice,
      this.currency,
      this.documentType,
      this.documentId,
      this.settlementUniqueId,
      this.collectionLotId,
      this.postingDate,
      this.storeName,
      this.retailerName,
      this.status,
      this.dateGenerated,
      this.dueDate,
      this.amount,
      this.openBalance,
      this.appliedAmount,
      this.statusDescription,
      this.contractAccount});

  SaleTranctionDetails.fromJson(Map<String, dynamic> json) {
    saleUniqueId = json['sale_unique_id'];
    invoice = json['invoice'];
    currency = json['currency'];
    documentType = json['document_type'];
    documentId = json['document_id'];
    settlementUniqueId = json['settlement_unique_id'] ?? "";
    collectionLotId = json['collection_lot_id'] ?? "";
    postingDate = json['posting_date'];
    storeName = json['store_name'];
    retailerName = json['retailer_name'];
    status = json['status'];
    dateGenerated = json['date_generated'];
    dueDate = json['due_date'];
    amount = json['amount'];
    openBalance = json['open_balance'];
    appliedAmount = json['applied_amount'];
    statusDescription = json['status_description'];
    contractAccount = json['contract_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sale_unique_id'] = saleUniqueId;
    data['invoice'] = invoice;
    data['currency'] = currency;
    data['document_type'] = documentType;
    data['document_id'] = documentId;
    data['settlement_unique_id'] = settlementUniqueId;
    data['collection_lot_id'] = collectionLotId;
    data['posting_date'] = postingDate;
    data['store_name'] = storeName;
    data['retailer_name'] = retailerName;
    data['status'] = status;
    data['date_generated'] = dateGenerated;
    data['due_date'] = dueDate;
    data['amount'] = amount;
    data['open_balance'] = openBalance;
    data['applied_amount'] = appliedAmount;
    data['status_description'] = statusDescription;
    data['contract_account'] = contractAccount;
    return data;
  }
}

class WholesalerSaleTranctionDetails {
  bool? success;
  String? message;
  List<SaleTranctionDetails>? data;

  WholesalerSaleTranctionDetails({this.success, this.message, this.data});

  WholesalerSaleTranctionDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SaleTranctionDetails>[];
      json['data'].forEach((v) {
        data!.add(SaleTranctionDetails.fromJson(v));
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
