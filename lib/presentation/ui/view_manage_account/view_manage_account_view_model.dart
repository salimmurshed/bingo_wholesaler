import '/data_models/models/retailer_bank_list/retailer_bank_list.dart';
import 'package:stacked/stacked.dart';

class ViewManageAccountViewModel extends BaseViewModel {
  RetailerBankListData? bankDetails;

  void setData(RetailerBankListData arguments) {
    bankDetails = arguments;
    notifyListeners();
  }
}
