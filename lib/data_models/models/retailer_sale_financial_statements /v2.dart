class RetailerSaleFinancialStatementsV2 {
  bool? success;
  String? message;
  Data? data;

  RetailerSaleFinancialStatementsV2({this.success, this.message, this.data});

  RetailerSaleFinancialStatementsV2.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? currentPage;
  List<RetailerSaleFinancialStatementsV2Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    if (json['data'] != null) {
      data = <RetailerSaleFinancialStatementsV2Data>[];
      json['data'].forEach((v) {
        data!.add(RetailerSaleFinancialStatementsV2Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ?? "";
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    lastPageUrl = json['last_page_url'] ?? "";
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'] ?? "";
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    prevPageUrl = json['prev_page_url'] ?? "";
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class RetailerSaleFinancialStatementsV2Data {
  String? documentId;
  String? amount;
  String? dateGenerated;
  String? saleUniqueId;
  String? invoice;
  int? advancePayment;
  int? status;
  String? documentTypeUniqueId;
  String? dueDate;
  String? dueDateFrom;
  String? dueDateTo;
  String? wholesalerName;
  String? bpIdW;
  String? currency;
  String? storeName;
  String? documentType;
  String? statusDescription;
  String? contractAccount;
  String? paymentDate;
  int? remainingDays;
  String? financialCharge;
  String? invoiceAmount;
  String? openBalance;
  bool? canStartPayment;

  RetailerSaleFinancialStatementsV2Data(
      {this.documentId,
      this.amount,
      this.dateGenerated,
      this.saleUniqueId,
      this.invoice,
      this.advancePayment,
      this.status,
      this.documentTypeUniqueId,
      this.dueDate,
      this.dueDateFrom,
      this.dueDateTo,
      this.wholesalerName,
      this.bpIdW,
      this.currency,
      this.storeName,
      this.documentType,
      this.statusDescription,
      this.contractAccount,
      this.paymentDate,
      this.remainingDays,
      this.financialCharge,
      this.invoiceAmount,
      this.openBalance,
      this.canStartPayment});

  RetailerSaleFinancialStatementsV2Data.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'] ?? "";
    amount = json['amount'] ?? "";
    dateGenerated = json['date_generated'] ?? "";
    saleUniqueId = json['sale_unique_id'] ?? "";
    invoice = json['invoice'] ?? "";
    advancePayment = json['advance_payment'] ?? 0;
    status = json['status'] ?? 0;
    documentTypeUniqueId = json['document_type_unique_id'] ?? "";
    dueDate = json['due_date'] ?? "";
    dueDateFrom = json['due_date_from'] ?? "";
    dueDateTo = json['due_date_to'] ?? "";
    wholesalerName = json['wholesaler_name'] ?? "";
    bpIdW = json['bp_id_w'] ?? "";
    currency = json['currency'] ?? "";
    storeName = json['store_name'] ?? "";
    documentType = json['document_type'] ?? "";
    statusDescription = json['status_description'] ?? "";
    contractAccount = json['contract_account'] ?? "";
    paymentDate = json['payment_date'] ?? "";
    remainingDays = json['remaining_days'] ?? 0;
    financialCharge = json['financial_charge'] ?? "";
    invoiceAmount = json['invoice_amount'] ?? "";
    openBalance = json['open_balance'] ?? "";
    canStartPayment = json['can_start_payment'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['amount'] = amount;
    data['date_generated'] = dateGenerated;
    data['sale_unique_id'] = saleUniqueId;
    data['invoice'] = invoice;
    data['advance_payment'] = advancePayment;
    data['status'] = status;
    data['document_type_unique_id'] = documentTypeUniqueId;
    data['due_date'] = dueDate;
    data['due_date_from'] = dueDateFrom;
    data['due_date_to'] = dueDateTo;
    data['wholesaler_name'] = wholesalerName;
    data['bp_id_w'] = bpIdW;
    data['currency'] = currency;
    data['store_name'] = storeName;
    data['document_type'] = documentType;
    data['status_description'] = statusDescription;
    data['contract_account'] = contractAccount;
    data['payment_date'] = paymentDate;
    data['remaining_days'] = remainingDays;
    data['financial_charge'] = financialCharge;
    data['invoice_amount'] = invoiceAmount;
    data['open_balance'] = openBalance;
    data['can_start_payment'] = canStartPayment;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
