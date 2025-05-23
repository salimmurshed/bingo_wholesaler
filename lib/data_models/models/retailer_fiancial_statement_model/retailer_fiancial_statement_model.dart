class RetailerFinancialStatementModel {
  bool? success;
  String? message;
  Data? data;

  RetailerFinancialStatementModel({this.success, this.message, this.data});

  RetailerFinancialStatementModel.fromJson(Map<String, dynamic> json) {
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
  String? grandTotal;
  FinancialStatements? financialStatements;

  Data({this.grandTotal, this.financialStatements});

  Data.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'];
    financialStatements = json['financial_statements'] != null
        ? FinancialStatements.fromJson(json['financial_statements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grand_total'] = grandTotal;
    if (financialStatements != null) {
      data['financial_statements'] = financialStatements!.toJson();
    }
    return data;
  }
}

class FinancialStatements {
  int? currentPage;
  List<FinancialStatementsData>? data;
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

  FinancialStatements(
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

  FinancialStatements.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FinancialStatementsData>[];
      json['data'].forEach((v) {
        data!.add(FinancialStatementsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'] ?? 0;
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
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

class FinancialStatementsData {
  String? documentId;
  String? storeName;
  String? saleUniqueId;
  String? enrollmentType;
  String? dateGenerated;
  String? dueDate;
  String? invoice;
  String? amount;
  String? openBalance;
  int? status;
  String? documentType;
  String? collectionLotId; //need
  String? saleId;
  String? creditLineId;
  String? wholesalerName;
  String? bpIdW;
  String? currency;
  String? totalBalance;
  String? totalAmount;
  String? statusDescription;
  String? contractAccount;
  String? documentCount;
  List<Documents>? documents;

  FinancialStatementsData(
      {this.documentId,
      this.storeName,
      this.saleUniqueId,
      this.enrollmentType,
      this.dateGenerated,
      this.dueDate,
      this.invoice,
      this.amount,
      this.openBalance,
      this.status,
      this.documentType,
      this.saleId,
      this.creditLineId,
      this.wholesalerName,
      this.bpIdW,
      this.currency,
      this.totalBalance,
      this.totalAmount,
      this.statusDescription,
      this.contractAccount,
      this.documentCount,
      this.documents});

  FinancialStatementsData.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'] ?? "";
    storeName = json['store_name'] ?? "";
    saleUniqueId = json['sale_unique_id'] ?? "";
    enrollmentType = json['enrollment_type'] ?? "";
    dateGenerated = json['date_generated'] ?? "";
    dueDate = json['due_date'] ?? "";
    invoice = json['invoice'] ?? "";
    amount = json['amount'] ?? "0.0";
    openBalance = json['open_balance'] ?? "0.0";
    status = json['status'] ?? 0;
    documentType = json['document_type'] ?? "";
    saleId = json['sale_id'] ?? "";
    creditLineId = json['creditLineId'] ?? "";
    wholesalerName = json['wholesaler_name'] ?? "";
    bpIdW = json['bp_id_w'] ?? "";
    currency = json['currency'] ?? "";
    totalBalance = json['total_balance'] ?? "0.0";
    totalAmount = json['total_amount'] ?? "0.0";
    statusDescription = json['status_description'] ?? "";
    contractAccount = json['contract_account'] ?? "";
    documentCount = json['documents_count'].toString() ?? "0";
    documentCount = (json['documents_count'] ?? 0).toString();
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['store_name'] = storeName;
    data['sale_unique_id'] = saleUniqueId;
    data['enrollment_type'] = enrollmentType;
    data['date_generated'] = dateGenerated;
    data['due_date'] = dueDate;
    data['invoice'] = invoice;
    data['amount'] = amount;
    data['open_balance'] = openBalance;
    data['status'] = status;
    data['document_type'] = documentType;
    data['sale_id'] = saleId;
    data['creditLineId'] = creditLineId;
    data['wholesaler_name'] = wholesalerName;
    data['bp_id_w'] = bpIdW;
    data['currency'] = currency;
    data['total_balance'] = totalBalance;
    data['total_amount'] = totalAmount;
    data['status_description'] = statusDescription;
    data['contract_account'] = contractAccount;
    data['documents_count'] = documentCount;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  String? documentId;
  String? saleUniqueId;
  String? enrollmentType;
  String? dateGenerated;
  String? dueDate;
  String? invoice;
  String? amount;
  String? openBalance;
  int? status;
  String? documentType;
  String? saleId;
  String? creditLineId;
  String? wholesalerName;
  String? bpIdW;
  String? currency;
  String? statusDescription;
  String? contractAccount;

  Documents(
      {this.documentId,
      this.saleUniqueId,
      this.enrollmentType,
      this.dateGenerated,
      this.dueDate,
      this.invoice,
      this.amount,
      this.openBalance,
      this.status,
      this.documentType,
      this.saleId,
      this.creditLineId,
      this.wholesalerName,
      this.bpIdW,
      this.currency,
      this.statusDescription,
      this.contractAccount});

  Documents.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'] ?? "";
    saleUniqueId = json['sale_unique_id'] ?? "";
    enrollmentType = json['enrollment_type'] ?? "";
    dateGenerated = json['date_generated'] ?? "";
    dueDate = json['due_date'] ?? "";
    invoice = json['invoice'] ?? "";
    amount = json['amount'] ?? "0.0";
    openBalance = json['open_balance'] ?? "0.0";
    status = json['status'] ?? 0;
    amount = (json['amount'] ?? "0.0");
    openBalance = (json['open_balance'] ?? "0.0");
    status = int.parse((json['status'] ?? "0").toString());
    documentType = json['document_type'] ?? "";
    saleId = json['sale_id'] ?? "";
    creditLineId = json['creditLineId'] ?? "";
    wholesalerName = json['wholesaler_name'] ?? "";
    bpIdW = json['bp_id_w'] ?? "";
    currency = json['currency'] ?? "";
    statusDescription = json['status_description'] ?? "";
    contractAccount = json['contract_account'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['sale_unique_id'] = saleUniqueId;
    data['enrollment_type'] = enrollmentType;
    data['date_generated'] = dateGenerated;
    data['due_date'] = dueDate;
    data['invoice'] = invoice;
    data['amount'] = amount;
    data['open_balance'] = openBalance;
    data['status'] = status;
    data['document_type'] = documentType;
    data['sale_id'] = saleId;
    data['creditLineId'] = creditLineId;
    data['wholesaler_name'] = wholesalerName;
    data['bp_id_w'] = bpIdW;
    data['currency'] = currency;
    data['status_description'] = statusDescription;
    data['contract_account'] = contractAccount;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? "";
    label = json['label'] ?? "";
    active = json['active'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
