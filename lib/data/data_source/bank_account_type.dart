class BankAccountTypeModel {
  int? id;
  String? title;

  BankAccountTypeModel({this.id, this.title});
}

class BankInfo {
  static List<BankAccountTypeModel> bankAccountType = [
    BankAccountTypeModel(
      id: 1,
      title: "Saving Account",
    ),
    // BankAccountTypeModel(
    //   id: 2,
    //   title: "Current Account",
    // ),
    BankAccountTypeModel(
      id: 3,
      title: "Checking Account",
    )
  ];

  static String checkBankAccountType(int i) {
    if (i == 1) {
      return "Saving Account";
    } else if (i == 2) {
      return "Current Account";
    } else if (i == 3) {
      return "Checking Account";
    } else {
      return "error";
    }
  }
}
