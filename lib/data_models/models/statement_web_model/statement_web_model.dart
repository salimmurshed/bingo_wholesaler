class StatementWebModel {
  bool? success;
  String? message;
  Data? data;

  StatementWebModel({this.success, this.message, this.data});

  StatementWebModel.fromJson(Map<String, dynamic> json) {
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
  Info? info;

  Data(
      {this.grandTotal,
      this.financialStatements,
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
      this.total,
      this.info});

  Data.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total'] ?? "0.0000";
    financialStatements = json['financial_statements'] != null
        ? FinancialStatements.fromJson(json['financial_statements'])
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
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grand_total'] = grandTotal;
    if (financialStatements != null) {
      data['financial_statements'] = financialStatements!.toJson();
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
    if (info != null) {
      data['info'] = info!.toJson();
    }
    return data;
  }
}

class FinancialStatements {
  List<Subgroups>? subgroups;
  // Metadata? metadata;

  FinancialStatements({this.subgroups
      // , this.metadata
      });

  FinancialStatements.fromJson(Map<String, dynamic> json) {
    if (json['subgroups'] != null) {
      subgroups = <Subgroups>[];
      json['subgroups'].forEach((v) {
        subgroups!.add(Subgroups.fromJson(v));
      });
    }
    // metadata =
    //     json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subgroups != null) {
      data['subgroups'] = subgroups!.map((v) => v.toJson()).toList();
    }
    // if (metadata != null) {
    //   data['metadata'] = metadata!.toJson();
    // }
    return data;
  }
}

class Subgroups {
  List<SubgroupData>? subgroupData;
  SubgroupMetadata? subgroupMetadata;

  Subgroups({this.subgroupData, this.subgroupMetadata});

  Subgroups.fromJson(Map<String, dynamic> json) {
    if (json['subgroup_data'] != null) {
      subgroupData = <SubgroupData>[];
      json['subgroup_data'].forEach((v) {
        subgroupData!.add(SubgroupData.fromJson(v));
      });
    }
    subgroupMetadata = json['subgroup_metadata'] != null
        ? SubgroupMetadata.fromJson(json['subgroup_metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subgroupData != null) {
      data['subgroup_data'] = subgroupData!.map((v) => v.toJson()).toList();
    }
    if (subgroupMetadata != null) {
      data['subgroup_metadata'] = subgroupMetadata!.toJson();
    }
    return data;
  }
}

class SubgroupData {
  String? documentId;
  String? saleUniqueId;
  String? invoice;
  int? status;
  String? documentTypeUniqueId;
  String? dueDate;
  String? dateGenerated;
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
  int? otherDocumentsCount;
  String? totalInvoiceAmount;
  String? totalFinancialCharge;

  SubgroupData(
      {this.documentId,
      this.saleUniqueId,
      this.invoice,
      this.status,
      this.documentTypeUniqueId,
      this.dueDate,
      this.dateGenerated,
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
      this.canStartPayment,
      this.otherDocumentsCount,
      this.totalInvoiceAmount,
      this.totalFinancialCharge});

  SubgroupData.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'] ?? "";
    saleUniqueId = json['sale_unique_id'] ?? "";
    invoice = json['invoice'] ?? "";
    status = json['status'] ?? 0;
    documentTypeUniqueId = json['document_type_unique_id'] ?? "";
    dueDate = json['due_date'] ?? "";
    dateGenerated = json['date_generated'] ?? "";
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
    otherDocumentsCount = json['other_documents_count'] ?? 0;
    totalInvoiceAmount = json['total_invoice_amount'] ?? "";
    totalFinancialCharge = json['total_financial_charge'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_id'] = documentId;
    data['sale_unique_id'] = saleUniqueId;
    data['invoice'] = invoice;
    data['status'] = status;
    data['document_type_unique_id'] = documentTypeUniqueId;
    data['due_date'] = dueDate;
    data['date_generated'] = dateGenerated;
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
    data['other_documents_count'] = otherDocumentsCount;
    data['total_invoice_amount'] = totalInvoiceAmount;
    data['total_financial_charge'] = totalFinancialCharge;
    return data;
  }
}

class SubgroupMetadata {
  String? groupTitle;
  String? totalOpenBalance;
  String? totalBalance;
  String? totalInvoiceAmount;
  String? totalFinancialCharge;
  int? documentsCount;

  SubgroupMetadata(
      {this.groupTitle,
      this.totalOpenBalance,
      this.totalBalance,
      this.totalInvoiceAmount,
      this.totalFinancialCharge,
      this.documentsCount});

  SubgroupMetadata.fromJson(Map<String, dynamic> json) {
    groupTitle = json['group_title'] ?? "";
    totalOpenBalance = json['total_open_balance'] ?? "";
    totalBalance = json['total_balance'] ?? "";
    totalInvoiceAmount = json['total_invoice_amount'] ?? "";
    totalFinancialCharge = json['total_financial_charge'] ?? "";
    documentsCount = json['documents_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_title'] = groupTitle;
    data['total_open_balance'] = totalOpenBalance;
    data['total_balance'] = totalBalance;
    data['total_invoice_amount'] = totalInvoiceAmount;
    data['total_financial_charge'] = totalFinancialCharge;
    data['documents_count'] = documentsCount;
    return data;
  }
}

// class Metadata {
//   String? totalOpenBalance;
//   String? totalBalance;
//   String? totalInvoiceAmount;
//   String? totalFinancialCharge;
//   int? documentsCount;
//
//   Metadata(
//       {this.totalOpenBalance,
//       this.totalBalance,
//       this.totalInvoiceAmount,
//       this.totalFinancialCharge,
//       this.documentsCount});
//
//   Metadata.fromJson(Map<String, dynamic> json) {
//     totalOpenBalance = json['total_open_balance'] ?? "";
//     totalBalance = json['total_balance'] ?? "";
//     totalInvoiceAmount = json['total_invoice_amount'] ?? "";
//     totalFinancialCharge = json['total_financial_charge'] ?? "";
//     documentsCount = json['documents_count'] ?? 0;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['total_open_balance'] = totalOpenBalance;
//     data['total_balance'] = totalBalance;
//     data['total_invoice_amount'] = totalInvoiceAmount;
//     data['total_financial_charge'] = totalFinancialCharge;
//     data['documents_count'] = documentsCount;
//     return data;
//   }
// }

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

class Info {
  CurrentGroupingStrategy? currentGroupingStrategy;
  GroupingStrategies? groupingStrategies;
  List<String>? selectedStrategySubgroups;

  Info(
      {this.currentGroupingStrategy,
      this.groupingStrategies,
      this.selectedStrategySubgroups});

  Info.fromJson(Map<String, dynamic> json) {
    currentGroupingStrategy = json['current_grouping_strategy'] != null
        ? CurrentGroupingStrategy.fromJson(json['current_grouping_strategy'])
        : null;
    groupingStrategies = json['grouping_strategies'] != null
        ? GroupingStrategies.fromJson(json['grouping_strategies'])
        : null;
    selectedStrategySubgroups =
        json['selected_strategy_subgroups'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (currentGroupingStrategy != null) {
      data['current_grouping_strategy'] = currentGroupingStrategy!.toJson();
    }
    if (groupingStrategies != null) {
      data['grouping_strategies'] = groupingStrategies!.toJson();
    }
    data['selected_strategy_subgroups'] = selectedStrategySubgroups;
    return data;
  }
}

class CurrentGroupingStrategy {
  String? displayName;
  String? name;

  CurrentGroupingStrategy({this.displayName, this.name});

  CurrentGroupingStrategy.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['display_name'] = displayName;
    data['name'] = name;
    return data;
  }
}

class GroupingStrategies {
  String? wEEKDAYS;
  String? dAYRANGE;

  GroupingStrategies({this.wEEKDAYS, this.dAYRANGE});

  GroupingStrategies.fromJson(Map<String, dynamic> json) {
    wEEKDAYS = json['WEEKDAYS'];
    dAYRANGE = json['DAY_RANGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['WEEKDAYS'] = wEEKDAYS;
    data['DAY_RANGE'] = dAYRANGE;
    return data;
  }
}

class SubgroupsWithData {
  List<SubgroupData>? subgroupData;
  String? groupName;
  int? groupId;

  SubgroupsWithData({this.subgroupData, this.groupName, this.groupId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subgroupData'] = subgroupData;
    data['groupName'] = groupName;
    data['groupId'] = groupId;
    return data;
  }
}
