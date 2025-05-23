// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_wholesaler_equest_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociationWholesalerRequestDetailsModel
    _$AssociationWholesalerRequestDetailsModelFromJson(
            Map<String, dynamic> json) =>
        AssociationWholesalerRequestDetailsModel(
          success: json['success'] as bool?,
          message: json['message'] as String?,
          data: (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$AssociationWholesalerRequestDetailsModelToJson(
    AssociationWholesalerRequestDetailsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  writeNotNull('data', instance.data?.map((e) => e.toJson()).toList());
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      companyInformation: (json['company_information'] as List<dynamic>?)
          ?.map((e) => CompanyInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactInformation: (json['contact_information'] as List<dynamic>?)
          ?.map((e) => ContactInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      internalInformation: (json['internal_information'] as List<dynamic>?)
          ?.map((e) => InternalInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditlineInformation: (json['creditline_information'] as List<dynamic>?)
          ?.map(
              (e) => CreditlineInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('company_information',
      instance.companyInformation?.map((e) => e.toJson()).toList());
  writeNotNull('contact_information',
      instance.contactInformation?.map((e) => e.toJson()).toList());
  writeNotNull('internal_information',
      instance.internalInformation?.map((e) => e.toJson()).toList());
  writeNotNull('creditline_information',
      instance.creditlineInformation?.map((e) => e.toJson()).toList());
  return val;
}

CompanyInformation _$CompanyInformationFromJson(Map<String, dynamic> json) =>
    CompanyInformation(
      uniqueId: json['unique_id'] as String?,
      bpIdR: json['bp_id_r'] as String? ?? '',
      retailerName: json['retailer_name'] as String? ?? '',
      taxIdType: json['tax_id_type'] as String? ?? '',
      taxId: json['tax_id'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      category: json['category'] as String? ?? '',
      companyAddress: json['company_address'] as String? ?? '',
      status: json['status'] as String? ?? '',
      commercialName: json['commercial_name'] as String? ?? '',
      dateFounded: json['date_founded'] as String? ?? '',
      website: json['website'] as String? ?? '',
      bpCompanyAboutUs: json['bp_company_about_us'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyInformationToJson(CompanyInformation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unique_id', instance.uniqueId);
  writeNotNull('bp_id_r', instance.bpIdR);
  writeNotNull('retailer_name', instance.retailerName);
  writeNotNull('tax_id_type', instance.taxIdType);
  writeNotNull('tax_id', instance.taxId);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('category', instance.category);
  writeNotNull('company_address', instance.companyAddress);
  writeNotNull('status', instance.status);
  writeNotNull('commercial_name', instance.commercialName);
  writeNotNull('date_founded', instance.dateFounded);
  writeNotNull('website', instance.website);
  writeNotNull('bp_company_about_us', instance.bpCompanyAboutUs);
  return val;
}

ContactInformation _$ContactInformationFromJson(Map<String, dynamic> json) =>
    ContactInformation(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      idType: json['id_type'] as String? ?? '',
      id: json['id'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      country: json['country'] as String? ?? '',
      city: json['city'] as String? ?? '',
      position: json['position'] as String? ?? '',
      companyDocument: (json['company_document'] as List<dynamic>?)
              ?.map((e) => CompanyDocument.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ContactInformationToJson(ContactInformation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('id_type', instance.idType);
  writeNotNull('id', instance.id);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('country', instance.country);
  writeNotNull('city', instance.city);
  writeNotNull('position', instance.position);
  writeNotNull('company_document',
      instance.companyDocument?.map((e) => e.toJson()).toList());
  return val;
}

CompanyDocument _$CompanyDocumentFromJson(Map<String, dynamic> json) =>
    CompanyDocument(
      url: json['url'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$CompanyDocumentToJson(CompanyDocument instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('name', instance.name);
  return val;
}

InternalInformation _$InternalInformationFromJson(Map<String, dynamic> json) =>
    InternalInformation(
      internalId: json['internal_id'] as String? ?? '',
      customerType: json['customer_type'] as String? ?? '',
      gracePeriodGroup: json['grace_period_group'] as String? ?? '',
      pricingGroup: json['pricing_group'] as String? ?? '',
      salesZone: json['sales_zone'] as String? ?? 'xxxxx',
      allowOrders: (json['allow_orders'] as num?)?.toInt() ?? 0,
      allowOrdersDescription: json['allow_orders_description'] as String? ?? '',
      retailerStoreDetails: (json['retailer_store_details'] as List<dynamic>?)
              ?.map((e) =>
                  RetailerStoreDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$InternalInformationToJson(InternalInformation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('internal_id', instance.internalId);
  writeNotNull('customer_type', instance.customerType);
  writeNotNull('grace_period_group', instance.gracePeriodGroup);
  writeNotNull('pricing_group', instance.pricingGroup);
  writeNotNull('sales_zone', instance.salesZone);
  writeNotNull('allow_orders', instance.allowOrders);
  writeNotNull('allow_orders_description', instance.allowOrdersDescription);
  writeNotNull('retailer_store_details',
      instance.retailerStoreDetails?.map((e) => e.toJson()).toList());
  return val;
}

RetailerStoreDetails _$RetailerStoreDetailsFromJson(
        Map<String, dynamic> json) =>
    RetailerStoreDetails(
      storeId: json['store_id'] as String? ?? '',
      storeName: json['store_name'] as String? ?? '',
      lattitude: json['lattitude'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
      location: json['location'] as String? ?? '',
      wholesalerStoreId: json['wholesaler_store_id'] as String? ?? '',
      salesZone: json['sales_zone'] as String? ?? '',
    );

Map<String, dynamic> _$RetailerStoreDetailsToJson(
    RetailerStoreDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('store_id', instance.storeId);
  writeNotNull('lattitude', instance.lattitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('store_name', instance.storeName);
  writeNotNull('location', instance.location);
  writeNotNull('wholesaler_store_id', instance.wholesalerStoreId);
  writeNotNull('sales_zone', instance.salesZone);
  return val;
}

CreditlineInformation _$CreditlineInformationFromJson(
        Map<String, dynamic> json) =>
    CreditlineInformation(
      customerSinceDate: json['customer_since_date'] as String? ?? '',
      monthlySales: json['monthly_sales'] as String? ?? '',
      averageSalesTicket: json['average_sales_ticket'] as String? ?? '',
      visitFrequency: (json['visit_frequency'] as num?)?.toInt() ?? 0,
      suggestedCreditlineAmount:
          json['suggested_creditline_amount'] as String? ?? '',
    );

Map<String, dynamic> _$CreditlineInformationToJson(
    CreditlineInformation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('customer_since_date', instance.customerSinceDate);
  writeNotNull('monthly_sales', instance.monthlySales);
  writeNotNull('average_sales_ticket', instance.averageSalesTicket);
  writeNotNull('visit_frequency', instance.visitFrequency);
  writeNotNull(
      'suggested_creditline_amount', instance.suggestedCreditlineAmount);
  return val;
}
