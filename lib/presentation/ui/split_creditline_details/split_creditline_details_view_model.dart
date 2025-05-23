import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../data_models/enums/manage_account_from_pages.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../../services/navigation/navigation_service.dart';

class SplitCreditlineDetailsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  String fieName = "";

  setData(String arguments) {
    fieName = arguments;
    notifyListeners();
  }

  goToAddManageAccount() {
    _navigationService.pushNamed(Routes.addManageAccountView,
        arguments: ScreenBasedRetailerBankListData(
            data: null, page: ManageAccountFromPages.creditline));
  }

  goBack() {
    _navigationService.pop();
  }
}
