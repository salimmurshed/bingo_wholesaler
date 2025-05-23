// import 'package:json_annotation/json_annotation.dart';
//
// part 'all_sales_model.g.dart';
//
// @JsonSerializable(explicitToJson: true, includeIfNull: false)
import '../../../const/database_helper.dart';

class AllSalesModel {
  bool? success;
  String? message;
  SaleData? data;

  AllSalesModel({this.success, this.message, this.data});

  AllSalesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? SaleData.fromJson(json['data']) : null;
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

class SaleData {
  int? currentPage;
  List<AllSalesData>? data;
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

  SaleData(
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

  SaleData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AllSalesData>[];
      json['data'].forEach((v) {
        data!.add(AllSalesData.fromJson(v));
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
    path = json['path'];
    perPage = int.parse((json['per_page'] ?? "0").toString());
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

class AllSalesData {
  String? uniqueId;
  String? invoiceNumber;
  String? orderNumber;
  String? storeId;
  String? bpIdR;
  String? saleDate;
  String? dueDate;
  String? currency;
  String? saleType;
  String? amount;
  String? bingoOrderId;
  int? status;
  String? description;
  String? retailerName;
  String? wholesalerName;
  String? fieName;
  String? wholesalerTempTxAddress;
  String? retailerTempTxAddress;
  String? wholesalerStoreId;
  String? statusDescription;
  int? isStartPayment;
  String? balance;
  String? appUniqueId;
  String? isAppUniqId;
  String? action;
  String? totalOwed;

  AllSalesData(
      {this.uniqueId,
      this.invoiceNumber,
      this.orderNumber,
      this.storeId,
      this.bpIdR,
      this.saleDate,
      this.dueDate,
      this.currency,
      this.saleType,
      this.amount,
      this.bingoOrderId,
      this.status,
      this.description,
      this.retailerName,
      this.wholesalerName,
      this.fieName,
      this.wholesalerTempTxAddress,
      this.retailerTempTxAddress,
      this.wholesalerStoreId,
      this.statusDescription,
      this.isStartPayment,
      this.balance,
      this.appUniqueId,
      this.isAppUniqId,
      this.action,
      this.totalOwed});

  AllSalesData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? ""; //ok
    invoiceNumber = (json['invoice_number'] ?? "").isEmpty
        ? "-"
        : json['invoice_number']; //ok
    orderNumber =
        (json['order_number'] ?? "").isEmpty ? "-" : json['order_number']; //ok
    storeId = json['store_id'] ?? ""; //ok
    bpIdR = json['bp_id_r'] ?? ""; //ok
    saleDate = json['sale_date'] ?? json['date_of_invoice'] ?? ""; //ok
    dueDate = json['due_date'] ?? "-"; //ok
    currency = json['currency'] ?? ""; //ok
    saleType = json['sale_type'] ?? ""; //ok
    amount = (json['amount'].toString()); //ok
    bingoOrderId = json['bingo_order_id'] ?? ""; //ok
    status = json['status'] ?? 0; //ok
    description = json['description'] ?? ""; //ok
    retailerName = json['retailer_name'] ?? ""; //ok
    wholesalerName = json['wholesaler_name'] ?? "";
    fieName = json['fie_name'] ?? ""; //ok
    wholesalerTempTxAddress = json['wholesaler_temp_tx_address'] ?? ""; //ok
    retailerTempTxAddress = json['retailer_temp_tx_address'] ?? ""; //ok
    wholesalerStoreId = json['wholesaler_store_id'] ?? ""; //ok
    statusDescription = json['status_description'] ?? ""; //ok
    isStartPayment = json['is_start_payment'] ?? 0;
    balance = json['balance'] ?? "";
    appUniqueId = json['app_unique_id'] ?? ""; //ok
    isAppUniqId = json['is_app_unique_id'] ?? "";
    action = json['action'] ?? "";
    totalOwed = json['total_owed'] ?? "0.0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['invoice_number'] = invoiceNumber;
    data['order_number'] = orderNumber;
    data['store_id'] = storeId;
    data['bp_id_r'] = bpIdR;
    data['sale_date'] = saleDate;
    data['due_date'] = dueDate;
    data['currency'] = currency;
    data['sale_type'] = saleType;
    data['amount'] = amount;
    data['bingo_order_id'] = bingoOrderId;
    data['status'] = status;
    data['description'] = description;
    data['retailer_name'] = retailerName;
    data['wholesaler_name'] = wholesalerName;
    data['fie_name'] = fieName;
    data['wholesaler_temp_tx_address'] = wholesalerTempTxAddress;
    data['retailer_temp_tx_address'] = retailerTempTxAddress;
    data['wholesaler_store_id'] = wholesalerStoreId;
    data['status_description'] = statusDescription;
    data['is_start_payment'] = isStartPayment;
    data['balance'] = balance;
    data['app_unique_id'] = appUniqueId;
    data['is_app_unique_id'] = isAppUniqId;
    data['action'] = action;
    data['total_owed'] = totalOwed;
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

AllSalesData allSalesDataSqliteToModel(value) {
  AllSalesData data = AllSalesData(
      uniqueId: value.first[DataBaseHelperKeys.uniqueId],
      invoiceNumber: value.first[DataBaseHelperKeys.invoiceNumber] ?? '',
      orderNumber: value.first[DataBaseHelperKeys.orderNumber] ?? '',
      saleDate: value.first[DataBaseHelperKeys.saleDate] ?? '',
      saleType: value.first[DataBaseHelperKeys.saleType],
      dueDate: value.first[DataBaseHelperKeys.dueDate] ?? '',
      currency: value.first[DataBaseHelperKeys.currency],
      amount: value.first[DataBaseHelperKeys.amount].toString(),
      bingoOrderId: value.first[DataBaseHelperKeys.bingoOrderId] ?? '',
      status: value.first[DataBaseHelperKeys.status],
      description: value.first[DataBaseHelperKeys.description],
      retailerName: value.first[DataBaseHelperKeys.retailerName],
      wholesalerName: value.first[DataBaseHelperKeys.wholesalerName],
      fieName: value.first[DataBaseHelperKeys.fieName] ?? '',
      wholesalerTempTxAddress:
          value.first[DataBaseHelperKeys.wholesalerTempTxAddress],
      retailerTempTxAddress:
          value.first[DataBaseHelperKeys.retailerTempTxAddress],
      wholesalerStoreId:
          value.first[DataBaseHelperKeys.wholesalerStoreId] ?? "",
      statusDescription: value.first[DataBaseHelperKeys.statusDescription],
      isStartPayment: value.first[DataBaseHelperKeys.isStartPayment],
      balance: value.first[DataBaseHelperKeys.balance] ?? '',
      appUniqueId: value.first[DataBaseHelperKeys.appUniqueId],
      isAppUniqId: value.first[DataBaseHelperKeys.isAppUniqId]);
  return data;
}

AllSalesData updateSalesDataSqliteToModel(value) {
  AllSalesData data = AllSalesData(
      uniqueId: value[DataBaseHelperKeys.uniqueId],
      invoiceNumber: value[DataBaseHelperKeys.invoiceNumber] ?? "-",
      orderNumber: value[DataBaseHelperKeys.orderNumber] ?? "-",
      saleDate: value[DataBaseHelperKeys.saleDate] ?? '',
      saleType: value[DataBaseHelperKeys.saleType],
      dueDate: value[DataBaseHelperKeys.dueDate] ?? '',
      currency: value[DataBaseHelperKeys.currency],
      amount: value[DataBaseHelperKeys.amount].toString(),
      bingoOrderId: value[DataBaseHelperKeys.bingoOrderId] ?? '',
      status: value[DataBaseHelperKeys.status],
      description: value[DataBaseHelperKeys.description],
      retailerName: value[DataBaseHelperKeys.retailerName],
      wholesalerName: value[DataBaseHelperKeys.wholesalerName],
      fieName: value[DataBaseHelperKeys.fieName] ?? '',
      wholesalerTempTxAddress:
          value[DataBaseHelperKeys.wholesalerTempTxAddress],
      retailerTempTxAddress: value[DataBaseHelperKeys.retailerTempTxAddress],
      wholesalerStoreId: value[DataBaseHelperKeys.wholesalerStoreId] ?? "",
      statusDescription: value[DataBaseHelperKeys.statusDescription],
      isStartPayment: value[DataBaseHelperKeys.isStartPayment],
      balance: value[DataBaseHelperKeys.balance] ?? '',
      appUniqueId: value[DataBaseHelperKeys.appUniqueId],
      isAppUniqId: value[DataBaseHelperKeys.isAppUniqId]);
  return data;
}

class GroupedAllSalesData {
  String? uniqueId;
  List<AllSalesData>? data;

  GroupedAllSalesData({this.uniqueId, this.data});

  GroupedAllSalesData.fromJson(Map<String, dynamic> json) {
    uniqueId = json['uniqueId'];
    if (json['data'] != null) {
      data = <AllSalesData>[];
      json['data'].forEach((v) {
        data!.add(AllSalesData.fromJson(v));
      });
    }
  }

  static List<GroupedAllSalesData> fromJsonList(jsonList) {
    return jsonList
        .map<GroupedAllSalesData>((obj) => GroupedAllSalesData.fromJson(obj))
        .toList();
  }
}

class TranctionDetails {
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

  static List<TranctionDetails> fromJsonList(jsonList) {
    return jsonList
        .map<TranctionDetails>((obj) => TranctionDetails.fromJson(obj))
        .toList();
  }

  TranctionDetails(
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

  TranctionDetails.fromJson(Map<String, dynamic> json) {
    saleUniqueId = json['sale_unique_id'] ?? "-";
    invoice = json['invoice'] ?? "-";
    currency = json['currency'] ?? "-";
    documentType = json['document_type'] ?? "-";
    documentId = json['document_id'] ?? "-";
    settlementUniqueId = json['settlement_unique_id'] ?? "-";
    collectionLotId = json['collection_lot_id'] ?? "-";
    postingDate = json['posting_date'] ?? "-";
    storeName = json['store_name'] ?? "-";
    retailerName = json['retailer_name'] ?? "-";
    status = json['status'] ?? 0;
    dateGenerated = json['date_generated'] ?? "-";
    dueDate = json['due_date'] ?? "-";
    amount = json['amount'] ?? "-";
    openBalance = json['open_balance'] ?? "-";
    appliedAmount = json['applied_amount'] ?? "-";
    statusDescription = json['status_description'] ?? "-";
    contractAccount = json['contract_account'] ?? "-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_unique_id'] = this.saleUniqueId;
    data['invoice'] = this.invoice;
    data['currency'] = this.currency;
    data['document_type'] = this.documentType;
    data['document_id'] = this.documentId;
    data['settlement_unique_id'] = this.settlementUniqueId;
    data['collection_lot_id'] = this.collectionLotId;
    data['posting_date'] = this.postingDate;
    data['store_name'] = this.storeName;
    data['retailer_name'] = this.retailerName;
    data['status'] = this.status;
    data['date_generated'] = this.dateGenerated;
    data['due_date'] = this.dueDate;
    data['amount'] = this.amount;
    data['open_balance'] = this.openBalance;
    data['applied_amount'] = this.appliedAmount;
    data['status_description'] = this.statusDescription;
    data['contract_account'] = this.contractAccount;
    return data;
  }
}

class OfflineOnlineSalesModel {
  AllSalesData? allSalesData;
  bool? isOffline;

  OfflineOnlineSalesModel({this.allSalesData, this.isOffline});
}

class OfflineOnlineSalesModelForNewQr {
  AllSalesData? allSalesData;
  bool fromQr;

  OfflineOnlineSalesModelForNewQr({this.allSalesData, this.fromQr = true});
}

class WebSaleUpdate {
  String? status;
  WebSaleUpdate({this.status});
}
