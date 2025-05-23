import 'package:json_annotation/json_annotation.dart';
part 'country_list_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CountryListModel {
  bool? success;
  String? message;
  List<CountryData>? data;

  CountryListModel({this.success, this.message, this.data});
  factory CountryListModel.fromJson(Map<String, dynamic> json) =>
      _$CountryListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryListModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CountryData {
  @JsonKey(defaultValue: 0, name: "id")
  int? id;
  @JsonKey(defaultValue: '', name: "country")
  String? country;
  @JsonKey(defaultValue: '', name: "timezone")
  String? timezone;
  @JsonKey(defaultValue: 0, name: "gl_id")
  int? glId;
  @JsonKey(defaultValue: '', name: "status")
  String? status;
  @JsonKey(defaultValue: '', name: "date")
  String? date;
  @JsonKey(defaultValue: '', name: "currency")
  String? currency;
  @JsonKey(defaultValue: '', name: "branch_legal")
  String? branchLegal;
  @JsonKey(defaultValue: '', name: "address")
  String? address;
  @JsonKey(defaultValue: '', name: "taxid")
  String? taxid;
  @JsonKey(defaultValue: '', name: "tax_id_type")
  String? taxIdType;
  @JsonKey(defaultValue: '', name: "country_code")
  String? countryCode;
  @JsonKey(defaultValue: '', name: "language")
  String? language;

  CountryData(
      {this.id,
      this.country,
      this.timezone,
      this.glId,
      this.status,
      this.date,
      this.currency,
      this.branchLegal,
      this.address,
      this.taxid,
      this.taxIdType,
      this.countryCode,
      this.language});
  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDataToJson(this);
}

class CountryDataModel {
  int? id;
  String? country;
  String? timezone;
  @JsonKey(name: "gl_id")
  int? glId;
  String? status;
  String? date;
  String? currency;
  @JsonKey(name: "branch_legal")
  String? branchLegal;
  String? address;
  String? taxid;
  @JsonKey(name: "tax_id_type")
  String? taxIdType;
  @JsonKey(name: "country_code")
  String? countryCode;
  String? language;

  CountryDataModel(
      this.id,
      this.country,
      this.timezone,
      this.glId,
      this.status,
      this.date,
      this.currency,
      this.branchLegal,
      this.address,
      this.taxid,
      this.taxIdType,
      this.countryCode,
      this.language);
}
