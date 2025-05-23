class TodayDeclineReasonsModel {
  bool? success;
  String? message;
  List<TodayDeclineReasonsData>? data;

  TodayDeclineReasonsModel({this.success, this.message, this.data});

  TodayDeclineReasonsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TodayDeclineReasonsData>[];
      json['data'].forEach((v) {
        data!.add(TodayDeclineReasonsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayDeclineReasonsData {
  int? id;
  String? uniqueId;
  String? country;
  String? enrollmentType;
  String? declineReason;
  String? createdAt;
  String? updatedAt;

  TodayDeclineReasonsData(
      {this.id,
      this.uniqueId,
      this.country,
      this.enrollmentType,
      this.declineReason,
      this.createdAt,
      this.updatedAt});

  TodayDeclineReasonsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    country = json['country'];
    enrollmentType = json['enrollment_type'];
    declineReason = json['decline_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unique_id'] = uniqueId;
    data['country'] = country;
    data['enrollment_type'] = enrollmentType;
    data['decline_reason'] = declineReason;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
