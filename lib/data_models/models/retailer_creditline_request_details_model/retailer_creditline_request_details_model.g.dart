// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retailer_creditline_request_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RetailerCreditLineReqDetailsModel _$RetailerCreditLineReqDetailsModelFromJson(
        Map<String, dynamic> json) =>
    RetailerCreditLineReqDetailsModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RetailerCreditLineReqDetailsModelToJson(
    RetailerCreditLineReqDetailsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  writeNotNull('data', instance.data?.toJson());
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      creditlineUniqueId: json['creditline_unique_id'] as String? ?? '',
      wholesalerName: json['wholesaler_name'] as String? ?? '',
      fieName: json['fie_name'] as String? ?? '',
      wholesalerUniqueId: json['wholesaler_unique_id'] as String? ?? '',
      fieUniqueId: json['fie_unique_id'] as String? ?? '',
      associationUniqueId: json['association_unique_id'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      dateRequested: json['date_requested'] as String? ?? '',
      monthlyPurchase: json['monthly_purchase'] as String? ?? '',
      averagePurchaseTickets: json['average_purchase_tickets'] as String? ?? '',
      visitFrequency: (json['visit_frequency'] as num?)?.toInt() ?? 0,
      requestedAmount: json['requested_amount'] as String? ?? '',
      commercialNameOne: json['commercial_name_one'] as String? ?? '',
      commercialPhoneOne: json['commercial_phone_one'] as String? ?? '',
      commercialNameTwo: json['commercial_name_two'] as String? ?? '',
      commercialPhoneTwo: json['commercial_phone_two'] as String? ?? '',
      commercialNameThree: json['commercial_name_three'] as String? ?? '',
      commercialPhoneThree: json['commercial_phone_three'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      statusDescription: json['status_description'] as String? ?? '',
      fieQuestionAnswer: (json['fie_question_answer'] as List<dynamic>?)
              ?.map(
                  (e) => FieQuestionAnswer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      supportedDocuments: (json['supported_documents'] as List<dynamic>?)
              ?.map(
                  (e) => SupportedDocuments.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('creditline_unique_id', instance.creditlineUniqueId);
  writeNotNull('wholesaler_name', instance.wholesalerName);
  writeNotNull('fie_name', instance.fieName);
  writeNotNull('wholesaler_unique_id', instance.wholesalerUniqueId);
  writeNotNull('fie_unique_id', instance.fieUniqueId);
  writeNotNull('association_unique_id', instance.associationUniqueId);
  writeNotNull('currency', instance.currency);
  writeNotNull('date_requested', instance.dateRequested);
  writeNotNull('monthly_purchase', instance.monthlyPurchase);
  writeNotNull('average_purchase_tickets', instance.averagePurchaseTickets);
  writeNotNull('visit_frequency', instance.visitFrequency);
  writeNotNull('requested_amount', instance.requestedAmount);
  writeNotNull('commercial_name_one', instance.commercialNameOne);
  writeNotNull('commercial_phone_one', instance.commercialPhoneOne);
  writeNotNull('commercial_name_two', instance.commercialNameTwo);
  writeNotNull('commercial_phone_two', instance.commercialPhoneTwo);
  writeNotNull('commercial_name_three', instance.commercialNameThree);
  writeNotNull('commercial_phone_three', instance.commercialPhoneThree);
  writeNotNull('status', instance.status);
  writeNotNull('status_description', instance.statusDescription);
  writeNotNull('fie_question_answer',
      instance.fieQuestionAnswer?.map((e) => e.toJson()).toList());
  writeNotNull('supported_documents',
      instance.supportedDocuments?.map((e) => e.toJson()).toList());
  return val;
}

FieQuestionAnswer _$FieQuestionAnswerFromJson(Map<String, dynamic> json) =>
    FieQuestionAnswer(
      questionId: json['question_id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
    );

Map<String, dynamic> _$FieQuestionAnswerToJson(FieQuestionAnswer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('question_id', instance.questionId);
  writeNotNull('question', instance.question);
  writeNotNull('answer', instance.answer);
  return val;
}

SupportedDocuments _$SupportedDocumentsFromJson(Map<String, dynamic> json) =>
    SupportedDocuments(
      retailerDocument: json['retailer_document'] as String? ?? '',
    );

Map<String, dynamic> _$SupportedDocumentsToJson(SupportedDocuments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('retailer_document', instance.retailerDocument);
  return val;
}
