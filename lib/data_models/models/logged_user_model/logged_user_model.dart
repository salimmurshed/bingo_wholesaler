class LoggedUserModel {
  String? uniqueId;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;

  LoggedUserModel(
      {this.uniqueId,
      this.email,
      this.firstName,
      this.lastName,
      this.profileImage});

  LoggedUserModel.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'] ?? "";
    email = json['email'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    profileImage = json['profile_image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['unique_id'] = uniqueId;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    return data;
  }
}
