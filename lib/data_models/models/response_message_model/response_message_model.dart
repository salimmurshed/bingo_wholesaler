class ResponseMessageModel {
  bool? success;
  String? message;
  String? data;
  Data? data1;

  ResponseMessageModel(
      {this.success, this.message, this.data = "no_data", this.data1});

  ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'].runtimeType == String) {
      data = json['data'] ?? "no_data";
      // } else {
      //   debugPrint(json['data'].runtimeType);
      //   data1 = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? associationId;
  String? fieId;
  String? bpIdF;
  String? bpIdR;
  String? uniqueId;
  String? monthlyPurchase;
  String? averagePurchaseTickets;
  int? visitFrequency;
  double? requestedAmount;
  String? commercialName1;
  String? commercialPhone1;
  String? commercialName2;
  String? commercialPhone2;
  String? commercialName3;
  String? commercialPhone3;
  String? currency;
  String? country;
  String? actionBy;
  String? actionEnrollement;
  int? isForward;
  int? status;
  int? statusFie;
  String? startDate;
  String? expirationDate;
  int? type;
  String? parentClId;
  double? approvedCreditLineAmount;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.associationId,
      this.fieId,
      this.bpIdF,
      this.bpIdR,
      this.uniqueId,
      this.monthlyPurchase,
      this.averagePurchaseTickets,
      this.visitFrequency,
      this.requestedAmount,
      this.commercialName1,
      this.commercialPhone1,
      this.commercialName2,
      this.commercialPhone2,
      this.commercialName3,
      this.commercialPhone3,
      this.currency,
      this.country,
      this.actionBy,
      this.actionEnrollement,
      this.isForward,
      this.status,
      this.statusFie,
      this.startDate,
      this.expirationDate,
      this.type,
      this.parentClId,
      this.approvedCreditLineAmount,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    associationId = json['association_id'];
    fieId = json['fie_id'];
    bpIdF = json['bp_id_f'];
    bpIdR = json['bp_id_r'];
    uniqueId = json['unique_id'];
    monthlyPurchase = json['monthly_purchase'];
    averagePurchaseTickets = json['average_purchase_tickets'];
    visitFrequency = json['visit_frequency'];
    requestedAmount = json['requested_amount'];
    commercialName1 = json['commercial_name_1'];
    commercialPhone1 = json['commercial_phone_1'];
    commercialName2 = json['commercial_name_2'];
    commercialPhone2 = json['commercial_phone_2'];
    commercialName3 = json['commercial_name_3'];
    commercialPhone3 = json['commercial_phone_3'];
    currency = json['currency'];
    country = json['country'];
    actionBy = json['action_by'];
    actionEnrollement = json['action_enrollement'];
    isForward = json['is_forward'];
    status = json['status'];
    statusFie = json['status_fie'];
    startDate = json['start_date'];
    expirationDate = json['expiration_date'];
    type = json['type'];
    parentClId = json['parent_cl_id'];
    approvedCreditLineAmount = json['approved_credit_line_amount'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }
}
