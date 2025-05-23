import 'package:json_annotation/json_annotation.dart';

part 'wholesaler_credit_line_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WholesalerCreditLineModel {
  bool? success;
  String? message;
  Data? data;

  WholesalerCreditLineModel({this.success, this.message, this.data});

  factory WholesalerCreditLineModel.fromJson(Map<String, dynamic> json) =>
      _$WholesalerCreditLineModelFromJson(json);
  Map<String, dynamic> toJson() => _$WholesalerCreditLineModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Data {
  @JsonKey(defaultValue: 0, name: "current_page")
  int? currentPage;
  @JsonKey(defaultValue: [], name: "data")
  List<WholesalerCreditLineData>? data;
  @JsonKey(defaultValue: "", name: "first_page_url")
  String? firstPageUrl;
  @JsonKey(defaultValue: 0, name: "from")
  int? from;
  @JsonKey(defaultValue: 0, name: "last_page")
  int? lastPage;
  @JsonKey(defaultValue: "", name: "last_page_url")
  String? lastPageUrl;
  @JsonKey(defaultValue: [], name: "links")
  List<Links>? links;
  @JsonKey(defaultValue: "", name: "next_page_url")
  String? nextPageUrl;
  @JsonKey(defaultValue: "", name: "path")
  String? path;
  @JsonKey(defaultValue: 0, name: "per_page")
  int? perPage;
  @JsonKey(defaultValue: "", name: "prev_page_url")
  String? prevPageUrl;
  @JsonKey(defaultValue: 0, name: "to")
  int? to;
  @JsonKey(defaultValue: 0, name: "total")
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

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class WholesalerCreditLineData {
  @JsonKey(defaultValue: 0, name: "id")
  int? id;
  @JsonKey(defaultValue: "", name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: 0, name: "association_id")
  int? associationId;
  @JsonKey(defaultValue: "", name: "fie_id")
  String? fieId;
  @JsonKey(defaultValue: 0, name: "bp_id_f")
  int? bpIdF;
  @JsonKey(defaultValue: 0, name: "bp_id_r")
  int? bpIdR;
  @JsonKey(defaultValue: "", name: "monthly_purchase")
  String? monthlyPurchase;
  @JsonKey(defaultValue: "", name: "average_purchase_tickets")
  String? averagePurchaseTickets;
  @JsonKey(defaultValue: "", name: "requested_amount")
  String? requestedAmount;
  @JsonKey(defaultValue: "", name: "customer_since_date")
  String? customerSinceDate;
  @JsonKey(defaultValue: "", name: "monthly_sales")
  String? monthlySales;
  @JsonKey(defaultValue: "", name: "average_sales_ticket")
  String? averageSalesTicket;
  @JsonKey(defaultValue: "", name: "rc_crline_amt")
  String? rcCrlineAmt;
  @JsonKey(defaultValue: 0, name: "visit_frequency")
  int? visitFrequency;
  @JsonKey(defaultValue: "", name: "credit_officer_group")
  String? creditOfficerGroup;
  @JsonKey(defaultValue: "", name: "commercial_name_1")
  String? commercialName1;
  @JsonKey(defaultValue: "", name: "commercial_phone_1")
  String? commercialPhone1;
  @JsonKey(defaultValue: "", name: "commercial_name_2")
  String? commercialName2;
  @JsonKey(defaultValue: "", name: "commercial_phone_2")
  String? commercialPhone2;
  @JsonKey(defaultValue: "", name: "commercial_name_3")
  String? commercialName3;
  @JsonKey(defaultValue: "", name: "commercial_phone_3")
  String? commercialPhone3;
  @JsonKey(defaultValue: "", name: "currency")
  String? currency;
  @JsonKey(defaultValue: "", name: "financial_statements")
  String? financialStatements;
  @JsonKey(defaultValue: 0, name: "status")
  int? status;
  @JsonKey(defaultValue: "", name: "country")
  String? country;
  @JsonKey(defaultValue: 0, name: "status_fie")
  int? statusFie;
  @JsonKey(defaultValue: 0.0, name: "approved_credit_line_amount")
  double? approvedCreditLineAmount;
  @JsonKey(defaultValue: "", name: "approved_credit_line_currency")
  String? approvedCreditLineCurrency;
  @JsonKey(defaultValue: "", name: "cl_internal_id")
  String? clInternalId;
  @JsonKey(defaultValue: "", name: "start_date")
  String? startDate;
  @JsonKey(defaultValue: "", name: "expiration_date")
  String? expirationDate;
  @JsonKey(defaultValue: "", name: "cl_approved_date")
  String? clApprovedDate;
  @JsonKey(defaultValue: 0, name: "cl_type")
  int? clType;
  @JsonKey(defaultValue: 0, name: "is_forward")
  int? isForward;
  @JsonKey(defaultValue: "", name: "action_by")
  String? actionBy;
  @JsonKey(defaultValue: "", name: "action_enrollement")
  String? actionEnrollement;
  @JsonKey(defaultValue: "", name: "authorization_date")
  String? authorizationDate;
  @JsonKey(defaultValue: 0, name: "is_fie_respond")
  int? isFieRespond;
  @JsonKey(defaultValue: "", name: "type")
  String? type;
  @JsonKey(defaultValue: 0, name: "parent_cl_id")
  int? parentClId;
  @JsonKey(defaultValue: "", name: "created_at")
  String? createdAt;
  @JsonKey(defaultValue: "", name: "updated_at")
  String? updatedAt;
  @JsonKey(defaultValue: "", name: "fie_name")
  String? fieName;
  @JsonKey(defaultValue: "", name: "retailer_name")
  String? retailerName;
  @JsonKey(defaultValue: "", name: "fie_unique_id")
  String? fieUniqueId;
  @JsonKey(defaultValue: "", name: "wholesaler_unique_id")
  String? wholesalerUniqueId;
  @JsonKey(defaultValue: "", name: "association_unique_id")
  String? associationUniqueId;
  @JsonKey(defaultValue: "", name: "status_description")
  String? statusDescription;
  @JsonKey(defaultValue: "", name: "date_requested")
  String? dateRequested;

  WholesalerCreditLineData(
      {this.id,
      this.uniqueId,
      this.associationId,
      this.fieId,
      this.bpIdF,
      this.bpIdR,
      this.monthlyPurchase,
      this.averagePurchaseTickets,
      this.requestedAmount,
      this.customerSinceDate,
      this.monthlySales,
      this.averageSalesTicket,
      this.rcCrlineAmt,
      this.visitFrequency,
      this.creditOfficerGroup,
      this.commercialName1,
      this.commercialPhone1,
      this.commercialName2,
      this.commercialPhone2,
      this.commercialName3,
      this.commercialPhone3,
      this.currency,
      this.financialStatements,
      this.status,
      this.country,
      this.statusFie,
      this.approvedCreditLineAmount,
      this.approvedCreditLineCurrency,
      this.clInternalId,
      this.startDate,
      this.expirationDate,
      this.clApprovedDate,
      this.clType,
      this.isForward,
      this.actionBy,
      this.actionEnrollement,
      this.authorizationDate,
      this.isFieRespond,
      this.type,
      this.parentClId,
      this.createdAt,
      this.updatedAt,
      this.fieName,
      this.retailerName,
      this.fieUniqueId,
      this.wholesalerUniqueId,
      this.associationUniqueId,
      this.statusDescription,
      this.dateRequested});

  factory WholesalerCreditLineData.fromJson(Map<String, dynamic> json) =>
      _$WholesalerCreditLineDataFromJson(json);
  Map<String, dynamic> toJson() => _$WholesalerCreditLineDataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Links {
  @JsonKey(defaultValue: "", name: "url")
  String? url;
  @JsonKey(defaultValue: "", name: "label")
  String? label;
  @JsonKey(defaultValue: false, name: "active")
  bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
