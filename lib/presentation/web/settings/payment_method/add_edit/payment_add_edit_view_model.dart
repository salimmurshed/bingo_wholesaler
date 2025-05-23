import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/utils.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_html/html.dart';
import '../../../../../app/app_config.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../repository/repository_wholesaler.dart';
import '../../../../../services/auth_service/auth_service.dart';

class PaymentAddEditViewModel extends BaseViewModel {
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  bool isEdit = false;
  String id = '';
  String title = '';
  String errorMessage = '';
  ScrollController scrollController = ScrollController();
  TextEditingController paymentMethodController = TextEditingController();
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  void setData(String? getId, String? getTitle) {
    if (getId == null) {
      isEdit = false;
    } else {
      isEdit = true;
      id = getId;
      title = getTitle ?? "";
      paymentMethodController.text = getTitle!;
    }
    notifyListeners();
  }

  editPaymentMethod() async {
    if (paymentMethodController.text.isEmpty) {
      errorMessage = 'Need to enter payment method name';
    } else if (title == paymentMethodController.text) {
      errorMessage = "This name is already stored";
    } else {
      errorMessage = '';
    }
    notifyListeners();
    if (errorMessage.isEmpty) {
      setBusyForObject(paymentMethodController, true);
      notifyListeners();
      ResponseMessageModel response = await _wholesaler.editPaymentMethods(
          paymentMethodController.text, id);
      Utils.toast(response.message!, isSuccess: response.success!);
      if (response.success!) {
        print(ConstantEnvironment.redirectBaseURL);
        window.history.replaceState('', '',
            '${ConstantEnvironment.redirectBaseURL}/${Routes.paymentMethodView}');

        window.history.back();
      }
      setBusyForObject(paymentMethodController, false);
      notifyListeners();
    }
  }
}
