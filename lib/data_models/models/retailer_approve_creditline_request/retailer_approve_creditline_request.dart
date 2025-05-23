class RetailerApproveCreditlineRequest {
  bool? success;
  String? message;
  List<ApproveCreditlineRequestData>? data;

  RetailerApproveCreditlineRequest({this.success, this.message, this.data});

  RetailerApproveCreditlineRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ApproveCreditlineRequestData>[];
      json['data'].forEach((v) {
        data!.add(ApproveCreditlineRequestData.fromJson(v));
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

class ApproveCreditlineRequestData {
  String? statusDescription;
  String? uniqueId;
  String? internalId;
  String? wholesalerName;
  String? retailerName;
  String? fieName;
  String? approvedAmount;
  String? approvedDate;
  String? minimumCommitmentDate;
  String? expirationDate;
  int? remainingDays;
  String? currentBalance;
  String? amountAvailable;
  int? status;
  String? currency;
  String? bankName;
  String? bankAccountNumber;
  String? remainAmount;
  String? effectiveDate;
  String? country;
  String? timezone;
  List<CreditlineDocuments>? creditlineDocuments;
  List<RetailerStoreDetails>? retailerStoreDetails;

  ApproveCreditlineRequestData(
      {this.statusDescription,
      this.uniqueId,
      this.internalId,
      this.wholesalerName,
      this.retailerName,
      this.fieName,
      this.approvedAmount,
      this.minimumCommitmentDate,
      this.approvedDate,
      this.expirationDate,
      this.remainingDays,
      this.currentBalance,
      this.amountAvailable,
      this.status,
      this.currency,
      this.bankName,
      this.bankAccountNumber,
      this.remainAmount,
      this.effectiveDate,
      this.country,
      this.timezone,
      this.creditlineDocuments,
      this.retailerStoreDetails});

  ApproveCreditlineRequestData.fromJson(Map<String, dynamic> json) {
    statusDescription = json['status_description'] ?? "";
    uniqueId = json['unique_id'] ?? "";
    internalId = json['internal_id'] ?? "";
    wholesalerName = json['wholesaler_name'] ?? "";
    retailerName = json['retailer_name'] ?? "";
    fieName = json['fie_name'] ?? "";
    approvedAmount = json['approved_amount'] ?? "";
    minimumCommitmentDate = json['minimum_commitment_date'] ?? "";
    approvedAmount = json['approved_amount'] == null
        ? "0.0"
        : json['approved_amount'].toString().isEmpty
            ? "0.0"
            : json['approved_amount'];
    approvedDate = json['approved_date'] ?? "";
    expirationDate = json['expiration_date'] ?? "";
    remainingDays = json['remaining_days'] ?? 0;
    currentBalance = json['current_balance'] == null
        ? "0.0"
        : json['current_balance'].toString().isEmpty
            ? "0.0"
            : json['current_balance'];
    amountAvailable = json['amount_available'] == null
        ? "0.0"
        : json['amount_available'].toString().isEmpty
            ? "0.0"
            : json['amount_available'];
    status = json['status'] ?? 0;
    currency = json['currency'] ?? "Not Defined";
    bankName = json['bank_name'] ?? "";
    bankAccountNumber = json['bank_account_number'] ?? "";
    remainAmount = json['remain_amount'] ?? "";
    effectiveDate = json['effective_date'] ?? "";
    country = json['country'] ?? "";
    timezone = json['timezone'] ?? "";
    if (json['creditline_documents'] != null) {
      creditlineDocuments = <CreditlineDocuments>[];
      json['creditline_documents'].forEach((v) {
        creditlineDocuments!.add(new CreditlineDocuments.fromJson(v));
      });
    }
    if (json['retailer_store_details'] != null) {
      retailerStoreDetails = <RetailerStoreDetails>[];
      json['retailer_store_details'].forEach((v) {
        retailerStoreDetails!.add(new RetailerStoreDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_description'] = this.statusDescription;
    data['unique_id'] = this.uniqueId;
    data['internal_id'] = this.internalId;
    data['wholesaler_name'] = this.wholesalerName;
    data['retailer_name'] = this.retailerName;
    data['fie_name'] = this.fieName;
    data['approved_amount'] = this.approvedAmount;
    data['approved_date'] = this.approvedDate;
    data['expiration_date'] = this.expirationDate;
    data['remaining_days'] = this.remainingDays;
    data['current_balance'] = this.currentBalance;
    data['amount_available'] = this.amountAvailable;
    data['status'] = this.status;
    data['currency'] = this.currency;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['remain_amount'] = this.remainAmount;
    data['effective_date'] = this.effectiveDate;
    data['country'] = this.country;
    data['timezone'] = this.timezone;
    if (this.creditlineDocuments != null) {
      data['creditline_documents'] =
          this.creditlineDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.retailerStoreDetails != null) {
      data['retailer_store_details'] =
          this.retailerStoreDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditlineDocuments {
  int? id;
  String? uniqueId;
  String? saleUniqueId;
  String? settlementUniqueId;
  String? documentTypeUniqueId;
  String? enrollmentType;
  int? bpId;
  String? invoice;
  var openBalance;
  var amount;
  String? dateGenerated;
  String? dueDate;
  int? status;
  int? isBlock;
  int? advancePayment;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? documentType;
  int? saleId;
  String? creditLineId;
  String? bpName;
  String? tempTxAddress;
  String? currency;
  String? storeName;
  int? storeId;

  CreditlineDocuments(
      {this.id,
      this.uniqueId,
      this.saleUniqueId,
      this.settlementUniqueId,
      this.documentTypeUniqueId,
      this.enrollmentType,
      this.bpId,
      this.invoice,
      this.openBalance,
      this.amount,
      this.dateGenerated,
      this.dueDate,
      this.status,
      this.isBlock,
      this.advancePayment,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.documentType,
      this.saleId,
      this.creditLineId,
      this.bpName,
      this.tempTxAddress,
      this.currency,
      this.storeName,
      this.storeId});

  CreditlineDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    uniqueId = json['unique_id'] ?? "";
    saleUniqueId = json['sale_unique_id'] ?? "";
    settlementUniqueId = json['settlement_unique_id'] ?? "";
    documentTypeUniqueId = json['document_type_unique_id'] ?? "";
    enrollmentType = json['enrollment_type'] ?? "";
    bpId = json['bp_id'] ?? 0;
    invoice = json['invoice'] ?? "";
    openBalance =
        double.parse(json['open_balance'].toString().replaceAll(",", ""));
    amount = double.parse(json['amount'].toString().replaceAll(",", ""));
    dateGenerated = json['date_generated'] ?? "";
    dueDate = json['due_date'] ?? "";
    status = json['status'] ?? 0;
    isBlock = json['is_block'] ?? 0;
    advancePayment = json['advance_payment'] ?? 0;
    country = json['country'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    documentType = json['document_type'] ?? "";
    saleId = json['sale_id'] ?? 0;
    creditLineId = json['creditLineId'] ?? "";
    bpName = json['bp_name'] ?? "";
    tempTxAddress = json['temp_tx_address'] ?? "";
    currency = json['currency'] ?? "Not Defined";
    storeName = json['store_name'] ?? "";
    storeId = json['store_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['sale_unique_id'] = this.saleUniqueId;
    data['settlement_unique_id'] = this.settlementUniqueId;
    data['document_type_unique_id'] = this.documentTypeUniqueId;
    data['enrollment_type'] = this.enrollmentType;
    data['bp_id'] = this.bpId;
    data['invoice'] = this.invoice;
    data['open_balance'] = this.openBalance;
    data['amount'] = this.amount;
    data['date_generated'] = this.dateGenerated;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['is_block'] = this.isBlock;
    data['advance_payment'] = this.advancePayment;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['document_type'] = this.documentType;
    data['sale_id'] = this.saleId;
    data['creditLineId'] = this.creditLineId;
    data['bp_name'] = this.bpName;
    data['temp_tx_address'] = this.tempTxAddress;
    data['currency'] = this.currency;
    data['store_name'] = this.storeName;
    data['store_id'] = this.storeId;
    return data;
  }
}

class RetailerStoreDetails {
  int? id;
  String? uniqueId;
  int? retaillerId;
  String? name;
  String? city;
  String? address;
  String? cordinate;
  String? remark;
  String? bankAccount;
  String? irnNo;
  String? storeLogo;
  String? country;
  String? website;
  String? prefferedBank;
  String? lattitude;
  String? longitude;
  String? signBoardPhoto;
  String? status;
  String? date;
  String? createdAt;
  String? updatedAt;
  double? amount;
  double? consumedAmount;
  String? effectiveDate;
  int? rClId;
  int? clId;
  String? newAssignment;

  RetailerStoreDetails(
      {this.id,
      this.uniqueId,
      this.retaillerId,
      this.name,
      this.city,
      this.address,
      this.cordinate,
      this.remark,
      this.bankAccount,
      this.irnNo,
      this.storeLogo,
      this.country,
      this.website,
      this.prefferedBank,
      this.lattitude,
      this.longitude,
      this.signBoardPhoto,
      this.status,
      this.date,
      this.createdAt,
      this.updatedAt,
      this.amount,
      this.consumedAmount,
      this.effectiveDate,
      this.rClId,
      this.clId,
      this.newAssignment});

  RetailerStoreDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    retaillerId = json['retailler_id'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    cordinate = json['cordinate'];
    remark = json['remark'];
    bankAccount = json['bank_account'];
    irnNo = json['irn_no'];
    storeLogo = json['store_logo'];
    country = json['country'];
    website = json['website'];
    prefferedBank = json['preffered_bank'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    signBoardPhoto = json['sign_board_photo'];
    status = json['status'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'].runtimeType != double
        ? double.parse(json['amount'].toString().replaceAll(",", ""))
        : json['amount'];
    consumedAmount = json['consumed_amount'].runtimeType != double
        ? double.parse(json['consumed_amount'].toString().replaceAll(",", ""))
        : json['consumed_amount'];
    effectiveDate = json['effective_date'];
    rClId = json['r_cl_id'];
    clId = json['cl_id'];
    newAssignment = json['new_assignment'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['retailler_id'] = this.retaillerId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['address'] = this.address;
    data['cordinate'] = this.cordinate;
    data['remark'] = this.remark;
    data['bank_account'] = this.bankAccount;
    data['irn_no'] = this.irnNo;
    data['store_logo'] = this.storeLogo;
    data['country'] = this.country;
    data['website'] = this.website;
    data['preffered_bank'] = this.prefferedBank;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['sign_board_photo'] = this.signBoardPhoto;
    data['status'] = this.status;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['amount'] = amount.runtimeType != double
        ? double.parse(amount.toString().replaceAll(",", ""))
        : amount;
    data['consumed_amount'] = consumedAmount.runtimeType != double
        ? double.parse(consumedAmount.toString().replaceAll(",", ""))
        : consumedAmount;
    data['effective_date'] = this.effectiveDate;
    data['r_cl_id'] = this.rClId;
    data['cl_id'] = this.clId;
    data['new_assignment'] = this.newAssignment;
    return data;
  }
}
