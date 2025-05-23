import 'package:json_annotation/json_annotation.dart';

part 'association_wholesaler_equest_details_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AssociationWholesalerRequestDetailsModel {
  bool? success;
  String? message;
  List<Data>? data;

  AssociationWholesalerRequestDetailsModel(
      {this.success, this.message, this.data});

  factory AssociationWholesalerRequestDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      _$AssociationWholesalerRequestDetailsModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AssociationWholesalerRequestDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Data {
  @JsonKey(name: "company_information")
  List<CompanyInformation>? companyInformation;
  @JsonKey(name: "contact_information")
  List<ContactInformation>? contactInformation;
  @JsonKey(name: "internal_information")
  List<InternalInformation>? internalInformation;
  @JsonKey(name: "creditline_information")
  List<CreditlineInformation>? creditlineInformation;

  Data(
      {this.companyInformation,
      this.contactInformation,
      this.internalInformation,
      this.creditlineInformation});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CompanyInformation {
  @JsonKey(name: "unique_id")
  String? uniqueId;
  @JsonKey(defaultValue: "", name: "bp_id_r")
  String? bpIdR;
  @JsonKey(defaultValue: "", name: "retailer_name")
  String? retailerName;
  @JsonKey(defaultValue: "", name: "tax_id_type")
  String? taxIdType;
  @JsonKey(defaultValue: "", name: "tax_id")
  String? taxId;
  @JsonKey(defaultValue: "", name: "phone_number")
  String? phoneNumber;
  @JsonKey(defaultValue: "", name: "category")
  String? category;
  @JsonKey(defaultValue: "", name: "company_address")
  String? companyAddress;
  @JsonKey(defaultValue: "", name: "status")
  String? status;
  @JsonKey(defaultValue: "", name: "commercial_name")
  String? commercialName;
  @JsonKey(defaultValue: "", name: "date_founded")
  String? dateFounded;
  @JsonKey(defaultValue: "", name: "website")
  String? website;
  @JsonKey(defaultValue: "", name: "bp_company_about_us")
  String? bpCompanyAboutUs;

  CompanyInformation(
      {this.uniqueId,
      this.bpIdR,
      this.retailerName,
      this.taxIdType,
      this.taxId,
      this.phoneNumber,
      this.category,
      this.companyAddress,
      this.status,
      this.commercialName,
      this.dateFounded,
      this.website,
      this.bpCompanyAboutUs});
  factory CompanyInformation.fromJson(Map<String, dynamic> json) =>
      _$CompanyInformationFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyInformationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ContactInformation {
  @JsonKey(defaultValue: "", name: "first_name")
  String? firstName;
  @JsonKey(defaultValue: "", name: "last_name")
  String? lastName;
  @JsonKey(defaultValue: "", name: "email")
  String? email;
  @JsonKey(defaultValue: "", name: "id_type")
  String? idType;
  @JsonKey(defaultValue: "", name: "id")
  String? id;
  @JsonKey(defaultValue: "", name: "phone_number")
  String? phoneNumber;
  @JsonKey(defaultValue: "", name: "country")
  String? country;
  @JsonKey(defaultValue: "", name: "city")
  String? city;
  @JsonKey(defaultValue: "", name: "position")
  String? position;
  @JsonKey(defaultValue: [], name: "company_document")
  List<CompanyDocument>? companyDocument;

  ContactInformation(
      {this.firstName,
      this.lastName,
      this.email,
      this.idType,
      this.id,
      this.phoneNumber,
      this.country,
      this.city,
      this.position,
      this.companyDocument});
  factory ContactInformation.fromJson(Map<String, dynamic> json) =>
      _$ContactInformationFromJson(json);
  Map<String, dynamic> toJson() => _$ContactInformationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InternalInformation {
  @JsonKey(defaultValue: "", name: "internal_id")
  String? internalId;
  @JsonKey(defaultValue: "", name: "customer_type")
  String? customerType;
  @JsonKey(defaultValue: "", name: "grace_period_group")
  String? gracePeriodGroup;
  @JsonKey(defaultValue: "", name: "pricing_group")
  String? pricingGroup;
  @JsonKey(defaultValue: "xxxxx", name: "sales_zone")
  String? salesZone;
  @JsonKey(defaultValue: 0, name: "allow_orders")
  int? allowOrders;
  @JsonKey(defaultValue: "", name: "allow_orders_description")
  String? allowOrdersDescription;
  @JsonKey(defaultValue: [], name: "retailer_store_details")
  List<RetailerStoreDetails>? retailerStoreDetails;

  InternalInformation(
      {this.internalId,
      this.customerType,
      this.gracePeriodGroup,
      this.pricingGroup,
      this.salesZone,
      this.allowOrders,
      this.allowOrdersDescription,
      this.retailerStoreDetails});
  factory InternalInformation.fromJson(Map<String, dynamic> json) =>
      _$InternalInformationFromJson(json);
  Map<String, dynamic> toJson() => _$InternalInformationToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RetailerStoreDetails {
  @JsonKey(defaultValue: "", name: "store_id")
  String? storeId;
  @JsonKey(defaultValue: "", name: "lattitude")
  String? lattitude;
  @JsonKey(defaultValue: "", name: "longitude")
  String? longitude;
  @JsonKey(defaultValue: "", name: "store_name")
  String? storeName;
  @JsonKey(defaultValue: "", name: "location")
  String? location;
  @JsonKey(defaultValue: "", name: "wholesaler_store_id")
  String? wholesalerStoreId;
  @JsonKey(defaultValue: "", name: "sales_zone")
  String? salesZone;

  RetailerStoreDetails(
      {this.storeId,
      this.storeName,
      this.lattitude,
      this.longitude,
      this.location,
      this.wholesalerStoreId,
      this.salesZone});
  factory RetailerStoreDetails.fromJson(Map<String, dynamic> json) =>
      _$RetailerStoreDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$RetailerStoreDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CreditlineInformation {
  @JsonKey(defaultValue: "", name: "customer_since_date")
  String? customerSinceDate;
  @JsonKey(defaultValue: "", name: "monthly_sales")
  String? monthlySales;
  @JsonKey(defaultValue: "", name: "average_sales_ticket")
  String? averageSalesTicket;
  @JsonKey(defaultValue: 0, name: "visit_frequency")
  int? visitFrequency;
  @JsonKey(defaultValue: "", name: "suggested_creditline_amount")
  String? suggestedCreditlineAmount;

  CreditlineInformation(
      {this.customerSinceDate,
      this.monthlySales,
      this.averageSalesTicket,
      this.visitFrequency,
      this.suggestedCreditlineAmount});
  factory CreditlineInformation.fromJson(Map<String, dynamic> json) =>
      _$CreditlineInformationFromJson(json);
  Map<String, dynamic> toJson() => _$CreditlineInformationToJson(this);
}
