import 'package:json_annotation/json_annotation.dart';

import '../../enums/manage_account_from_pages.dart';

part 'retailer_bank_list.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RetailerBankList {
  bool? success;
  String? message;
  List<RetailerBankListData>? data;

  RetailerBankList({this.success, this.message, this.data});

  factory RetailerBankList.fromJson(Map<String, dynamic> json) =>
      _$RetailerBankListFromJson(json);
  Map<String, dynamic> toJson() => _$RetailerBankListToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RetailerBankListData {
  @JsonKey(defaultValue: "", name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: 0, name: "status")
  int? status;
  @JsonKey(defaultValue: 0, name: "bank_account_type")
  int? bankAccountType;
  @JsonKey(defaultValue: "", name: "currency")
  String? currency;
  @JsonKey(defaultValue: "", name: "bank_account_number")
  String? bankAccountNumber;
  @JsonKey(defaultValue: "", name: "iban")
  String? iban;
  @JsonKey(defaultValue: "", name: "updated_at")
  String? updatedAt;
  @JsonKey(defaultValue: "", name: "fie_id")
  String? fieId;
  @JsonKey(defaultValue: "", name: "fie_name")
  String? fieName;
  @JsonKey(defaultValue: "", name: "status_description")
  String? statusDescription;
  @JsonKey(defaultValue: "", name: "updated_at_date")
  String? updatedAtDate;
  @JsonKey(defaultValue: "", name: "bank_account_type_description")
  String? bankAccountTypeDescription;

  RetailerBankListData({
    this.uniqueId,
    this.status,
    this.bankAccountType,
    this.currency,
    this.bankAccountNumber,
    this.iban,
    this.updatedAt,
    this.fieId,
    this.fieName,
    this.statusDescription,
    this.updatedAtDate,
    this.bankAccountTypeDescription,
  });

  factory RetailerBankListData.fromJson(Map<String, dynamic> json) =>
      _$RetailerBankListDataFromJson(json);
  Map<String, dynamic> toJson() => _$RetailerBankListDataToJson(this);
}

class ScreenBasedRetailerBankListData {
  RetailerBankListData? data;
  ManageAccountFromPages page;
  ScreenBasedRetailerBankListData({this.data, required this.page});
}
