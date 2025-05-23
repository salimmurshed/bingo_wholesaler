import 'package:json_annotation/json_annotation.dart';

part 'retailer_credit_line_req_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RetailerCreditLineRequestModel {
  bool? success;
  String? message;
  Data? data;

  RetailerCreditLineRequestModel({this.success, this.message, this.data});
  factory RetailerCreditLineRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RetailerCreditLineRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RetailerCreditLineRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Data {
  @JsonKey(defaultValue: 1, name: "current_page")
  int? currentPage;
  @JsonKey(defaultValue: [], name: "data")
  List<RetailerCreditLineRequestData>? data;
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
class RetailerCreditLineRequestData {
  @JsonKey(defaultValue: "", name: "creditline_unique_id")
  String? creditlineUniqueId;
  @JsonKey(defaultValue: "", name: "type")
  String? type;
  @JsonKey(defaultValue: "", name: "date_requested")
  String? dateRequested;
  @JsonKey(defaultValue: 0, name: "status")
  int? status;
  @JsonKey(defaultValue: "", name: "fie_name")
  String? fieName;
  @JsonKey(defaultValue: "", name: "wholesaler_name")
  String? wholesalerName;
  @JsonKey(defaultValue: "", name: "fie_unique_id")
  String? fieUniqueId;
  @JsonKey(defaultValue: "", name: "wholesaler_unique_id")
  String? wholesalerUniqueId;
  @JsonKey(defaultValue: "", name: "association_unique_id")
  String? associationUniqueId;
  @JsonKey(defaultValue: "", name: "status_description")
  String? statusDescription;
  @JsonKey(defaultValue: "", name: "requested_amount")
  String? requestedAmount;
  @JsonKey(defaultValue: "", name: "currency")
  String? currency;
  RetailerCreditLineRequestData(
      {this.creditlineUniqueId,
      this.type,
      this.dateRequested,
      this.status,
      this.fieName,
      this.wholesalerName,
      this.fieUniqueId,
      this.wholesalerUniqueId,
      this.associationUniqueId,
      this.requestedAmount,
      this.currency,
      this.statusDescription});
  factory RetailerCreditLineRequestData.fromJson(Map<String, dynamic> json) =>
      _$RetailerCreditLineRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$RetailerCreditLineRequestDataToJson(this);
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
