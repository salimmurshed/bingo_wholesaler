import 'package:bingo/app/locator.dart';
import 'package:bingo/app/web_route.dart';
import 'package:bingo/data_models/models/delivery_method_model.dart';
import 'package:bingo/services/web_basic_service/WebBasicService.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../const/utils.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../../repository/repository_wholesaler.dart';
import '../../../../../services/auth_service/auth_service.dart';
import '../../../../../services/navigation/navigation_service.dart';
import '../../../../widgets/alert/confirmation_dialog.dart';

class DeliveryMethodListViewModel extends BaseViewModel {
  DeliveryMethodListViewModel() {
    getDeliveryMethods();
  }
  final WebBasicService _webBasicService = locator<WebBasicService>();
  final RepositoryWholesaler _wholesaler = locator<RepositoryWholesaler>();
  final NavigationService _nav = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  UserTypeForWeb get enrollment => _authService.enrollment.value;
  List<WholesalerDeliveryMethods> deliveryMethods = [];
  String get tabNumber => _webBasicService.tabNumber.value;

  ScrollController scrollController = ScrollController();

  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  String saleZones = "";

  Future<void> getDeliveryMethods() async {
    setBusy(true);
    notifyListeners();
    DeliveryMethodModel deliveryMethodModel =
        await _wholesaler.getDeleveryMethods();
    deliveryMethods = deliveryMethodModel.data!.wholesalerDeliveryMethods!;
    setBusy(false);
    notifyListeners();
  }

  String getSaleZones(List<SaleZonesForDelivery> list) {
    return list
        .map((e) => e.zoneName ?? "")
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "");
  }

  gotoDetails(int v, BuildContext context, {String? id, int? status}) async {
    if (v == 0) {
      context
          .goNamed(Routes.deliveryMethodEditView, queryParameters: {'id': id});
    } else if (v == 3) {
      context.goNamed(Routes.deliveryMethodAddView);
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
            await _wholesaler.deleteDeleveryMethods(id);
        DeliveryMethodModel deliveryMethodModel =
            await _wholesaler.getDeleveryMethods();
        deliveryMethods = deliveryMethodModel.data!.wholesalerDeliveryMethods!;
        Utils.toast(responseMessageModel.message!,
            isSuccess: responseMessageModel.success!);

        setBusy(false);
        notifyListeners();
      }
    } else if (v == 2) {
      bool confirm = await _nav.animatedDialog(SizedBox(
        width: 200,
        child: ConfirmationDialog(
            ifYesNo: true,
            title:
                "Do you really want to ${status == 0 ? 'Activate' : 'Inactivate'} this item?"),
      ));
      if (confirm) {
        setBusy(true);
        notifyListeners();
        ResponseMessageModel responseMessageModel = await _wholesaler
            .statusChangeDeleveryMethods(id, status == 0 ? 1 : 0);
        DeliveryMethodModel deliveryMethodModel =
            await _wholesaler.getDeleveryMethods();
        deliveryMethods = deliveryMethodModel.data!.wholesalerDeliveryMethods!;
        Utils.toast(responseMessageModel.message!,
            isSuccess: responseMessageModel.success!);

        setBusy(false);
        notifyListeners();
      }
    }
  }

  void statusChange() {}
}
