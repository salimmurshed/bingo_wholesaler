// class SettlementsListModel {
//   bool? success;
//   String? message;
//   List<SettlementsListData>? data;
//
//   SettlementsListModel({this.success, this.message, this.data});
//
//   SettlementsListModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <SettlementsListData>[];
//       json['data'].forEach((v) {
//         data!.add(SettlementsListData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SettlementsListData {
//   String? postingDate;
//   String? lotId;
//   String? currency;
//   String? amount;
//   int? status;
//   String? statusDescription;
//
//   SettlementsListData(
//       {this.postingDate,
//       this.lotId,
//       this.currency,
//       this.amount,
//       this.status,
//       this.statusDescription});
//
//   SettlementsListData.fromJson(Map<String, dynamic> json) {
//     postingDate = json['posting_date'] ?? "";
//     lotId = json['lot_id'] ?? "";
//     currency = json['currency'] ?? "";
//     amount = json['amount'] ?? "";
//     status = json['status'] ?? 0;
//     statusDescription = json['status_description'] ?? "";
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['posting_date'] = postingDate;
//     data['lot_id'] = lotId;
//     data['currency'] = currency;
//     data['amount'] = amount;
//     data['status'] = status;
//     data['status_description'] = statusDescription;
//     return data;
//   }
// }

class SettlementsListModel {
  bool? success;
  String? message;
  Data? data;

  SettlementsListModel({this.success, this.message, this.data});

  SettlementsListModel.fromJson(Map<String, dynamic> json) {
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
  List<SettlementsListData>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    if (json['data'] != null) {
      data = <SettlementsListData>[];
      json['data'].forEach((v) {
        data!.add(SettlementsListData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ?? "";
    from = json['from'] ?? 0;
    nextPageUrl = json['next_page_url'] ?? "";
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    prevPageUrl = json['prev_page_url'] ?? "";
    to = json['to'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    return data;
  }
}

class SettlementsListData {
  String? postingDate;
  String? lotId;
  int? lotType;
  String? currency;
  String? amount;
  int? status;
  String? statusDescription;

  SettlementsListData(
      {this.postingDate,
      this.lotId,
      this.lotType,
      this.currency,
      this.amount,
      this.status,
      this.statusDescription});

  SettlementsListData.fromJson(Map<String, dynamic> json) {
    postingDate = json['posting_date'] ?? "";
    lotId = json['lot_id'] ?? "";
    lotType = json['lot_type'] ?? 0;
    currency = json['currency'] ?? "";
    amount = json['amount'] ?? "";
    status = json['status'] ?? 0;
    statusDescription = json['status_description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['posting_date'] = postingDate;
    data['lot_id'] = lotId;
    data['lot_type'] = lotType;
    data['currency'] = currency;
    data['amount'] = amount;
    data['status'] = status;
    data['status_description'] = statusDescription;
    return data;
  }
}
