import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/repository/repository_wholesaler.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/payment_methods_model.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../../services/navigation/navigation_service.dart';
import '../../../../widgets/alert/confirmation_dialog.dart';

class PaymentMethodViewModel extends BaseViewModel {
  PaymentMethodViewModel() {
    getPaymentMethods();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final NavigationService _nav = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  PaymentMethodsModel paymentMethodsModel = PaymentMethodsModel();
  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  Future<void> getPaymentMethods() async {
    setBusy(true);
    notifyListeners();
    paymentMethodsModel = await _wholesaler.getPaymentMethods();
    setBusy(false);
    notifyListeners();
  }

  gotoDetails(int v, BuildContext context, {String? id, String? title}) async {
    if (v == 0) {
      context.goNamed(Routes.paymentMethodEditView,
          queryParameters: {'id': id, 'title': title});
    } else if (v == 2) {
      context.goNamed(Routes.paymentMethodAddView);
    } else if (v == 1) {
      bool confirm = await _nav.animatedDialog(const SizedBox(
        width: 200,
        child: ConfirmationDialog(
            ifYesNo: true, title: "Do you really want to delete this item?"),
      ));
      if (confirm) {
        setBusy(true);
        notifyListeners();
        ResponseMessageModel responseMessageModel =
            await _wholesaler.deletePaymentMethods(id);

        paymentMethodsModel = await _wholesaler.getPaymentMethods();
        Utils.toast(responseMessageModel.message!,
            isSuccess: responseMessageModel.success!);

        setBusy(false);
        notifyListeners();
      }
    }
  }
}
