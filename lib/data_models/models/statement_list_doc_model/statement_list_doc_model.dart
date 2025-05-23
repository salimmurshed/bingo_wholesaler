class StatementListDocModel {
  bool? success;
  String? message;
  Data? data;

  StatementListDocModel({this.success, this.message, this.data});

  StatementListDocModel.fromJson(Map<String, dynamic> json) {
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
  List<FinancialStatementsDetails>? financialStatements;
  FinancialStatementsDetailsGroupMetadata? groupMetadata;
  int? currentPage;
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
      {this.financialStatements,
      this.groupMetadata,
      this.currentPage,
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
    if (json['financial_statements'] != null) {
      financialStatements = <FinancialStatementsDetails>[];
      json['financial_statements'].forEach((v) {
        financialStatements!.add(FinancialStatementsDetails.fromJson(v));
      });
    }
    groupMetadata = json['group_metadata'] != null
        ? FinancialStatementsDetailsGroupMetadata.fromJson(
            json['group_metadata'])
        : null;
    currentPage = json['current_page'] ?? 0;
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
    if (financialStatements != null) {
      data['financial_statements'] =
          financialStatements!.map((v) => v.toJson()).toList();
    }
    if (groupMetadata != null) {
      data['group_metadata'] = groupMetadata!.toJson();
    }
    data['current_page'] = currentPage;
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

class FinancialStatementsDetails {
  String? documentId;
  String? saleUniqueId;
  String? invoice;
  String? amount;
  int? advancePayment;
  int? status;
  String? documentTypeUniqueId;
  String? dateGenerated;
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
  String? openBalance;
  bool? canStartPayment;

  FinancialStatementsDetails(
      {this.documentId,
      this.saleUniqueId,
      this.invoice,
      this.amount,
      this.advancePayment,
      this.status,
      this.documentTypeUniqueId,
      this.dateGenerated,
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
      this.openBalance,
      this.canStartPayment});

  FinancialStatementsDetails.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    saleUniqueId = json['sale_unique_id'];
    invoice = json['invoice'];
    amount = json['amount'];
    advancePayment = json['advance_payment'];
    status = json['status'];
    documentTypeUniqueId = json['document_type_unique_id'];
    dateGenerated = json['date_generated'];
    dueDate = json['due_date'];
    dueDateFrom = json['due_date_from'];
    dueDateTo = json['due_date_to'];
    wholesalerName = json['wholesaler_name'];
    bpIdW = json['bp_id_w'];
    currency = json['currency'];
    storeName = json['store_name'];
    documentType = json['document_type'];
    statusDescription = json['status_description'];
    contractAccount = json['contract_account'];
    paymentDate = json['payment_date'];
    remainingDays = json['remaining_days'];
    openBalance = json['open_balance'];
    canStartPayment = json['can_start_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['sale_unique_id'] = saleUniqueId;
    data['invoice'] = invoice;
    data['amount'] = amount;
    data['advance_payment'] = advancePayment;
    data['status'] = status;
    data['document_type_unique_id'] = documentTypeUniqueId;
    data['date_generated'] = dateGenerated;
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
    data['open_balance'] = openBalance;
    data['can_start_payment'] = canStartPayment;
    return data;
  }
}

class FinancialStatementsDetailsGroupMetadata {
  String? groupTitle;
  String? totalOpenBalance;
  String? totalAmount;
  int? documentsCount;

  FinancialStatementsDetailsGroupMetadata(
      {this.groupTitle,
      this.totalOpenBalance,
      this.totalAmount,
      this.documentsCount});

  FinancialStatementsDetailsGroupMetadata.fromJson(Map<String, dynamic> json) {
    groupTitle = json['group_title'];
    totalOpenBalance = json['total_open_balance'];
    totalAmount = json['total_amount'];
    documentsCount = json['documents_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_title'] = groupTitle;
    data['total_open_balance'] = totalOpenBalance;
    data['total_amount'] = totalAmount;
    data['documents_count'] = documentsCount;
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
