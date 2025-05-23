import 'package:json_annotation/json_annotation.dart';

part 'retailer_creditline_request_details_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RetailerCreditLineReqDetailsModel {
  bool? success;
  String? message;
  Data? data;

  RetailerCreditLineReqDetailsModel({this.success, this.message, this.data});
  factory RetailerCreditLineReqDetailsModel.fromJson(
          Map<String, dynamic> json) =>
      _$RetailerCreditLineReqDetailsModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$RetailerCreditLineReqDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Data {
  @JsonKey(defaultValue: "", name: "creditline_unique_id")
  String? creditlineUniqueId;
  @JsonKey(defaultValue: "", name: "wholesaler_name")
  String? wholesalerName;
  @JsonKey(defaultValue: "", name: "fie_name")
  String? fieName;
  @JsonKey(defaultValue: "", name: "wholesaler_unique_id")
  String? wholesalerUniqueId;
  @JsonKey(defaultValue: "", name: "fie_unique_id")
  String? fieUniqueId;
  @JsonKey(defaultValue: "", name: "association_unique_id")
  String? associationUniqueId;
  @JsonKey(defaultValue: "", name: "currency")
  String? currency;
  @JsonKey(defaultValue: "", name: "date_requested")
  String? dateRequested;
  @JsonKey(defaultValue: "", name: "monthly_purchase")
  String? monthlyPurchase;
  @JsonKey(defaultValue: "", name: "average_purchase_tickets")
  String? averagePurchaseTickets;
  @JsonKey(defaultValue: 0, name: "visit_frequency")
  int? visitFrequency;
  @JsonKey(defaultValue: "", name: "requested_amount")
  String? requestedAmount;
  @JsonKey(defaultValue: "", name: "commercial_name_one")
  String? commercialNameOne;
  @JsonKey(defaultValue: "", name: "commercial_phone_one")
  String? commercialPhoneOne;
  @JsonKey(defaultValue: "", name: "commercial_name_two")
  String? commercialNameTwo;
  @JsonKey(defaultValue: "", name: "commercial_phone_two")
  String? commercialPhoneTwo;
  @JsonKey(defaultValue: "", name: "commercial_name_three")
  String? commercialNameThree;
  @JsonKey(defaultValue: "", name: "commercial_phone_three")
  String? commercialPhoneThree;
  @JsonKey(defaultValue: 0, name: "status")
  int? status;
  @JsonKey(defaultValue: "", name: "status_description")
  String? statusDescription;
  @JsonKey(defaultValue: [], name: "fie_question_answer")
  List<FieQuestionAnswer>? fieQuestionAnswer;
  @JsonKey(defaultValue: [], name: "supported_documents")
  List<SupportedDocuments>? supportedDocuments;

  Data(
      {this.creditlineUniqueId,
      this.wholesalerName,
      this.fieName,
      this.wholesalerUniqueId,
      this.fieUniqueId,
      this.associationUniqueId,
      this.currency,
      this.dateRequested,
      this.monthlyPurchase,
      this.averagePurchaseTickets,
      this.visitFrequency,
      this.requestedAmount,
      this.commercialNameOne,
      this.commercialPhoneOne,
      this.commercialNameTwo,
      this.commercialPhoneTwo,
      this.commercialNameThree,
      this.commercialPhoneThree,
      this.status,
      this.statusDescription,
      this.fieQuestionAnswer,
      this.supportedDocuments});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class FieQuestionAnswer {
  @JsonKey(defaultValue: "", name: "question_id")
  String? questionId;
  @JsonKey(defaultValue: "", name: "question")
  String? question;
  @JsonKey(defaultValue: "", name: "answer")
  String? answer;

  FieQuestionAnswer({this.questionId, this.question, this.answer});
  factory FieQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$FieQuestionAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$FieQuestionAnswerToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SupportedDocuments {
  @JsonKey(defaultValue: "", name: "retailer_document")
  String? retailerDocument;

  SupportedDocuments({this.retailerDocument});
  factory SupportedDocuments.fromJson(Map<String, dynamic> json) =>
      _$SupportedDocumentsFromJson(json);
  Map<String, dynamic> toJson() => _$SupportedDocumentsToJson(this);
}
