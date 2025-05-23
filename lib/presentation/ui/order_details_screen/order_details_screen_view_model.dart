import '../../../data_models/enums/user_type_for_web.dart';
import '/const/utils.dart';
import '/repository/order_repository.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../const/connectivity.dart';
import '../../../data_models/models/order_details/order_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetailsScreenViewModel extends ReactiveViewModel {
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  List<OrderDetail> orderDetail = [];

  String get language => _authService.selectedLanguageCode;

  callDetailsData(String orderUId, BuildContext context) async {
    bool connection = await checkConnectivity();
    if (connection) {
      setBusy(true);
      notifyListeners();
      orderDetail.clear();
      await _repositoryOrder.getDetails(orderUId);

      orderDetail.add(_repositoryOrder.orderDetail!);
      setBusy(false);
      notifyListeners();
    } else {
      _navigationService.pop();
      if (context.mounted) {
        Utils.toast(AppLocalizations.of(context)!.noInternet);
      }
    }
  }
}
