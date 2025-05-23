import '/const/app_extensions/amount_extension.dart';
import '/data_models/models/customer_creditline_list/customer_creditline_list.dart';
import '/services/auth_service/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';

class CustomerCreditlineDetailsViewModel extends BaseViewModel {
  CustomerCreditlineData customerCreditlineData = CustomerCreditlineData();
  final AuthService _authService = locator<AuthService>();

  String get language => _authService.selectedLanguageCode;

  void setData(CustomerCreditlineData arguments) {
    customerCreditlineData = arguments;
    notifyListeners();
  }

  String availableAmount() {
    double amount = double.parse(customerCreditlineData
            .approvedCreditLineAmount!
            .replaceAll(",", "")) -
        double.parse(
            customerCreditlineData.consumedAmount!.replaceAll(",", ""));

    return amount.getFormattedDouble();
  }

  double getFrictionOfAvailability() {
    double friction = double.parse(
            customerCreditlineData.consumedAmount!.replaceAll(",", "")) /
        double.parse(customerCreditlineData.approvedCreditLineAmount!
            .replaceAll(",", ""));
    return friction;
  }
}
