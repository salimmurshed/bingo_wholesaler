// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer_wholesaler_association_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerAssociationRequestDetailsModel
    _$RetailerAssociationRequestDetailsModelFromJson(
            Map<String, dynamic> json) =>
        RetailerAssociationRequestDetailsModel(
          success: json['success'] as bool?,
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$RetailerAssociationRequestDetailsModelToJson(
        RetailerAssociationRequestDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      companyInformation: (json['company_information'] as List<dynamic>?)
          ?.map((e) =>
              CompanyInformationRetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactInformation: (json['contact_information'] as List<dynamic>?)
          ?.map((e) =>
              ContactInformationRetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'company_information':
          instance.companyInformation?.map((e) => e.toJson()).toList(),
      'contact_information':
          instance.contactInformation?.map((e) => e.toJson()).toList(),
    };

CompanyInformationRetails _$CompanyInformationRetailsFromJson(
        Map<String, dynamic> json) =>
    CompanyInformationRetails(
      uniqueId: json['unique_id'] as String? ?? '',
      bpIdW: json['bp_id_r'] as String? ?? '',
      bpIdF: json['bp_id_f'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      taxId: json['tax_id'] as String? ?? '',
      associationDate: json['association_date'] as String? ?? '',
      companyAddress: json['company_address'] as String? ?? '',
      status: json['status'] as String? ?? '',
      statusFie: json['status_fie'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyInformationRetailsToJson(
        CompanyInformationRetails instance) =>
    <String, dynamic>{
      'unique_id': instance.uniqueId,
      'bp_id_r': instance.bpIdW,
      'bp_id_f': instance.bpIdF,
      'company_name': instance.companyName,
      'tax_id': instance.taxId,
      'association_date': instance.associationDate,
      'company_address': instance.companyAddress,
      'status': instance.status,
      'status_fie': instance.statusFie,
    };

ContactInformationRetails _$ContactInformationRetailsFromJson(
        Map<String, dynamic> json) =>
    ContactInformationRetails(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      position: json['position'] as String? ?? '',
      id: json['id'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      companyDocument: (json['company_document'] as List<dynamic>?)
              ?.map((e) => CompanyDocument.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ContactInformationRetailsToJson(
        ContactInformationRetails instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'position': instance.position,
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'company_document':
          instance.companyDocument?.map((e) => e.toJson()).toList(),
    };

CompanyDocument _$CompanyDocumentFromJson(Map<String, dynamic> json) =>
    CompanyDocument(
      url: json['url'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyDocumentToJson(CompanyDocument instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
    };
