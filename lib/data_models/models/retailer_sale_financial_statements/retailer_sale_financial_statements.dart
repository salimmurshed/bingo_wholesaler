class RetailerSaleFinancialStatements {
  bool? success;
  String? message;
  Data? data;

  RetailerSaleFinancialStatements({this.success, this.message, this.data});

  RetailerSaleFinancialStatements.fromJson(Map<String, dynamic> json) {
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
  FinancialStatements? financialStatements;

  Data({this.financialStatements});

  Data.fromJson(Map<String, dynamic> json) {
    financialStatements = json['financial_statements'] != null
        ? FinancialStatements.fromJson(json['financial_statements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (financialStatements != null) {
      data['financial_statements'] = financialStatements!.toJson();
    }
    return data;
  }
}

class FinancialStatements {
  int? currentPage;
  List<RetailerSaleFinancialStatementsData>? data;
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
      data = <RetailerSaleFinancialStatementsData>[];
      json['data'].forEach((v) {
        data!.add(RetailerSaleFinancialStatementsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
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

class RetailerSaleFinancialStatementsData {
  String? documentId;
  String? saleUniqueId;
  String? dateGenerated;
  String? dueDate;
  String? invoice;
  String? amount;
  String? openBalance;
  int? status;
  String? documentType;
  String? saleId;
  String? wholesalerName;
  String? bpIdW;
  String? currency;
  String? storeName;
  String? statusDescription;
  String? contractAccount;

  RetailerSaleFinancialStatementsData(
      {this.documentId,
      this.saleUniqueId,
      this.dateGenerated,
      this.dueDate,
      this.invoice,
      this.amount,
      this.openBalance,
      this.status,
      this.documentType,
      this.saleId,
      this.wholesalerName,
      this.bpIdW,
      this.currency,
      this.storeName,
      this.statusDescription,
      this.contractAccount});

  RetailerSaleFinancialStatementsData.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    saleUniqueId = json['sale_unique_id'];
    dateGenerated = json['date_generated'];
    dueDate = json['due_date'];
    invoice = json['invoice'];
    amount = json['amount'];
    openBalance = json['open_balance'];
    status = json['status'];
    documentType = json['document_type'];
    saleId = json['sale_id'];
    wholesalerName = json['wholesaler_name'];
    bpIdW = json['bp_id_w'];
    currency = json['currency'];
    storeName = json['store_name'];
    statusDescription = json['status_description'];
    contractAccount = json['contract_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['sale_unique_id'] = saleUniqueId;
    data['date_generated'] = dateGenerated;
    data['due_date'] = dueDate;
    data['invoice'] = invoice;
    data['amount'] = amount;
    data['open_balance'] = openBalance;
    data['status'] = status;
    data['document_type'] = documentType;
    data['sale_id'] = saleId;
    data['wholesaler_name'] = wholesalerName;
    data['bp_id_w'] = bpIdW;
    data['currency'] = currency;
    data['store_name'] = storeName;
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
