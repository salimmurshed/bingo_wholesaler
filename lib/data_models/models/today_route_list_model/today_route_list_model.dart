import '../all_sales_model/all_sales_model.dart';

class TodayRouteListModel {
  bool? success;
  String? message;
  TodayRouteListData? data;

  TodayRouteListModel({this.success, this.message, this.data});

  TodayRouteListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new TodayRouteListData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TodayRouteListData {
  List<PendingToAttendStores>? pendingToAttendStores;
  List<PendingToAttendStores>? completedStores;

  TodayRouteListData({this.pendingToAttendStores, this.completedStores});

  TodayRouteListData.fromJson(Map<String, dynamic> json) {
    if (json['pending_to_attend_stores'] != null) {
      pendingToAttendStores = <PendingToAttendStores>[];
      json['pending_to_attend_stores'].forEach((v) {
        pendingToAttendStores!.add(new PendingToAttendStores.fromJson(v));
      });
    } else {
      [];
    }
    if (json['completed_stores'] != null) {
      completedStores = <PendingToAttendStores>[];
      json['completed_stores'].forEach((v) {
        completedStores!.add(new PendingToAttendStores.fromJson(v));
      });
    } else {
      [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingToAttendStores != null) {
      data['pending_to_attend_stores'] =
          this.pendingToAttendStores!.map((v) => v.toJson()).toList();
    }
    if (this.completedStores != null) {
      data['completed_stores'] =
          this.completedStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingToAttendStores {
  int? id;
  String? uniqueId;
  String? bpIdW;
  String? bpIdR;
  String? routeId;
  int? routeOrder;
  String? wRetailerId;
  String? wStoreId;
  int? bingoStoreId;
  String? date;
  String? country;
  int? type;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? retailerName;
  String? wholesalerName;
  String? storeName;
  String? address;
  String? retailerStoreId;
  String? routeName;
  String? routeIdMr;
  String? lattitude;
  String? longitude;
  String? retaillerId;
  String? salesStep;
  String? storeTodayStatus;
  String? storeTodayStatusCreatedAt;
  List<AllSalesData>? sales;

  PendingToAttendStores(
      {this.id,
      this.uniqueId,
      this.bpIdW,
      this.bpIdR,
      this.routeId,
      this.routeOrder,
      this.wRetailerId,
      this.wStoreId,
      this.bingoStoreId,
      this.date,
      this.country,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.retailerName,
      this.wholesalerName,
      this.storeName,
      this.address,
      this.retailerStoreId,
      this.routeName,
      this.routeIdMr,
      this.lattitude,
      this.longitude,
      this.retaillerId,
      this.salesStep,
      this.storeTodayStatus,
      this.storeTodayStatusCreatedAt,
      this.sales});

  PendingToAttendStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    bpIdW = json['bp_id_w'];
    bpIdR = json['bp_id_r'];
    routeId = json['route_id'];
    routeOrder = json['route_order'];
    wRetailerId = json['w_retailer_id'];
    wStoreId = json['w_store_id'];
    bingoStoreId = json['bingo_store_id'];
    date = json['date'];
    country = json['country'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    retailerName = json['retailer_name'];
    wholesalerName = json['wholesaler_name'];
    storeName = json['store_name'];
    address = json['address'];
    retailerStoreId = json['retailer_store_id'];
    routeName = json['route_name'];
    routeIdMr = json['route_id_mr'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    retaillerId = json['retailler_id'];
    salesStep = json['sales_step'];
    storeTodayStatus = json['store_today_status'].toString();
    storeTodayStatusCreatedAt = json['store_today_status_created_at'];
    if (json['sales'] != null) {
      sales = <AllSalesData>[];
      json['sales'].forEach((v) {
        sales!.add(new AllSalesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['bp_id_w'] = this.bpIdW;
    data['bp_id_r'] = this.bpIdR;
    data['route_id'] = this.routeId;
    data['route_order'] = this.routeOrder;
    data['w_retailer_id'] = this.wRetailerId;
    data['w_store_id'] = this.wStoreId;
    data['bingo_store_id'] = this.bingoStoreId;
    data['date'] = this.date;
    data['country'] = this.country;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['retailer_name'] = this.retailerName;
    data['wholesaler_name'] = this.wholesalerName;
    data['store_name'] = this.storeName;
    data['address'] = this.address;
    data['retailer_store_id'] = this.retailerStoreId;
    data['route_name'] = this.routeName;
    data['route_id_mr'] = this.routeIdMr;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['retailler_id'] = this.retaillerId;
    data['sales_step'] = this.salesStep;
    data['store_today_status'] = this.storeTodayStatus;
    data['store_today_status_created_at'] = this.storeTodayStatusCreatedAt;
    if (this.sales != null) {
      data['sales'] = this.sales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Sales {
//   String? uniqueId;
//   Null? appUniqueId;
//   String? invoiceNumber;
//   String? orderNumber;
//   String? saleDate;
//   Null? dueDate;
//   String? currency;
//   String? saleType;
//   String? amount;
//   String? bingoOrderId;
//   int? status;
//   String? description;
//   String? retailerName;
//   String? fieName;
//   String? wholesalerTempTxAddress;
//   String? retailerTempTxAddress;
//   String? wholesalerStoreId;
//   String? bpIdR;
//   String? storeId;
//   String? statusDescription;
//
//   Sales(
//       {this.uniqueId,
//       this.appUniqueId,
//       this.invoiceNumber,
//       this.orderNumber,
//       this.saleDate,
//       this.dueDate,
//       this.currency,
//       this.saleType,
//       this.amount,
//       this.bingoOrderId,
//       this.status,
//       this.description,
//       this.retailerName,
//       this.fieName,
//       this.wholesalerTempTxAddress,
//       this.retailerTempTxAddress,
//       this.wholesalerStoreId,
//       this.bpIdR,
//       this.storeId,
//       this.statusDescription});
//
//   Sales.fromJson(Map<String, dynamic> json) {
//     uniqueId = json['unique_id'];
//     appUniqueId = json['app_unique_id'];
//     invoiceNumber = json['invoice_number'];
//     orderNumber = json['order_number'];
//     saleDate = json['sale_date'];
//     dueDate = json['due_date'];
//     currency = json['currency'];
//     saleType = json['sale_type'];
//     amount = json['amount'];
//     bingoOrderId = json['bingo_order_id'];
//     status = json['status'];
//     description = json['description'];
//     retailerName = json['retailer_name'];
//     fieName = json['fie_name'];
//     wholesalerTempTxAddress = json['wholesaler_temp_tx_address'];
//     retailerTempTxAddress = json['retailer_temp_tx_address'];
//     wholesalerStoreId = json['wholesaler_store_id'];
//     bpIdR = json['bp_id_r'];
//     storeId = json['store_id'];
//     statusDescription = json['status_description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['unique_id'] = this.uniqueId;
//     data['app_unique_id'] = this.appUniqueId;
//     data['invoice_number'] = this.invoiceNumber;
//     data['order_number'] = this.orderNumber;
//     data['sale_date'] = this.saleDate;
//     data['due_date'] = this.dueDate;
//     data['currency'] = this.currency;
//     data['sale_type'] = this.saleType;
//     data['amount'] = this.amount;
//     data['bingo_order_id'] = this.bingoOrderId;
//     data['status'] = this.status;
//     data['description'] = this.description;
//     data['retailer_name'] = this.retailerName;
//     data['fie_name'] = this.fieName;
//     data['wholesaler_temp_tx_address'] = this.wholesalerTempTxAddress;
//     data['retailer_temp_tx_address'] = this.retailerTempTxAddress;
//     data['wholesaler_store_id'] = this.wholesalerStoreId;
//     data['bp_id_r'] = this.bpIdR;
//     data['store_id'] = this.storeId;
//     data['status_description'] = this.statusDescription;
//     return data;
//   }
// }
