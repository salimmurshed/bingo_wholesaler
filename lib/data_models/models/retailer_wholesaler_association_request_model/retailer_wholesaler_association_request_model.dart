import 'package:json_annotation/json_annotation.dart';
part 'retailer_wholesaler_association_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RetailerAssociationRequestDetailsModel {
  bool? success;
  String? message;
  List<Data>? data;

  RetailerAssociationRequestDetailsModel(
      {this.success, this.message, this.data});

  factory RetailerAssociationRequestDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      _$RetailerAssociationRequestDetailsModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RetailerAssociationRequestDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  @JsonKey(name: "company_information")
  List<CompanyInformationRetails>? companyInformation;
  @JsonKey(name: "contact_information")
  List<ContactInformationRetails>? contactInformation;

  Data({this.companyInformation, this.contactInformation});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyInformationRetails {
  @JsonKey(defaultValue: "", name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: "", name: "bp_id_r")
  String? bpIdW;
  @JsonKey(defaultValue: "", name: "bp_id_f")
  String? bpIdF;
  @JsonKey(defaultValue: "", name: "company_name")
  String? companyName;
  @JsonKey(defaultValue: "", name: "tax_id")
  String? taxId;
  @JsonKey(defaultValue: "", name: "association_date")
  String? associationDate;
  @JsonKey(defaultValue: "", name: "company_address")
  String? companyAddress;
  @JsonKey(defaultValue: "", name: "status")
  String? status;
  @JsonKey(defaultValue: "", name: "status_fie")
  String? statusFie;

  CompanyInformationRetails(
      {this.uniqueId,
      this.bpIdW,
      this.bpIdF,
      this.companyName,
      this.taxId,
      this.associationDate,
      this.companyAddress,
      this.status,
      this.statusFie});

  factory CompanyInformationRetails.fromJson(Map<String, dynamic> json) =>
      _$CompanyInformationRetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyInformationRetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContactInformationRetails {
  @JsonKey(defaultValue: "", name: "first_name")
  String? firstName;
  @JsonKey(defaultValue: "", name: "last_name")
  String? lastName;
  @JsonKey(defaultValue: "", name: "position")
  String? position;
  @JsonKey(defaultValue: "", name: "id")
  String? id;
  @JsonKey(defaultValue: "", name: "phone_number")
  String? phoneNumber;
  @JsonKey(defaultValue: [], name: "company_document")
  List<CompanyDocument>? companyDocument;

  ContactInformationRetails(
      {this.firstName,
      this.lastName,
      this.position,
      this.id,
      this.phoneNumber,
      this.companyDocument});

  factory ContactInformationRetails.fromJson(Map<String, dynamic> json) =>
      _$ContactInformationRetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ContactInformationRetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyDocument {
  @JsonKey(defaultValue: "", name: "url")
  String? url;
  @JsonKey(defaultValue: "", name: "name")
  String? name;

  CompanyDocument({this.url, this.name});

  factory CompanyDocument.fromJson(Map<String, dynamic> json) =>
      _$CompanyDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyDocumentToJson(this);
}
