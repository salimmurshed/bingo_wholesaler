import '../models/retailer_approve_creditline_request/retailer_approve_creditline_request.dart';

class ActiveCreditlineModel {
  String uniqueId;
  String activeDate;
  String minimumCommitmentDate;
  String approveAmount;
  String remainingAmount;
  String currency;
  List<RetailerStoreDetails>? stores;

  // List<BankListData> bankList;
  String? bank;
  bool isEmptyStore;

  ActiveCreditlineModel(
      {required this.activeDate,
      required this.minimumCommitmentDate,
      required this.uniqueId,
      required this.approveAmount,
      required this.remainingAmount,
      required this.currency,
      this.stores,
      // required this.bankList,
      this.bank,
      required this.isEmptyStore});
}
