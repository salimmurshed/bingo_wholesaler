import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/repository/repository_components.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../repository/repository_notification.dart';
import '../../../repository/repository_retailer.dart';
import '../../../repository/repository_wholesaler.dart';
import '../sales_add/sales_add_view.dart';

class BottomTabsScreenViewModel extends ReactiveViewModel {
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryNotification _repositoryNotification =
      locator<RepositoryNotification>();

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => _authService.enrollment.value;

  // bool get isKayBoard => _repositoryComponents.isKeyboardOpen.value;

  int get unseenNotification =>
      _repositoryNotification.unseenNotificationNumber.value;

  BottomTabsScreenViewModel() {
    _repositoryRetailer.getStores();
    if (enrollment == UserTypeForWeb.wholesaler) {
      getWholesalerData();
    }
  }

  getNotification(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getNewNotification(context);
    });
  }

  getNewNotification(BuildContext context) {
    // _repositoryNotification.notificationCounter();
    if (context.mounted) {
      onChangedTab(context, 4);
    }
  }

  int numberOfTabs = 5;

  int get selectedNumber => _repositoryComponents.selectedNumberMainTab.value;
  final double iconHeight = 24;

  void openAddDialog() {
    _navigationService.fullScreenDialog(AddSalesView());
  }

  void onChangedTab(context, int index) {
    print(index);
    _repositoryComponents.onChangedTab(context, index);
    notifyListeners();
  }

  void getWholesalerData() async {
    setBusy(true);
    notifyListeners();
    await _repositoryWholesaler.getWholesalersAssociationData();
    await _repositoryWholesaler.getCreditLinesList();
    setBusy(false);
    notifyListeners();
  }

  Future<bool> showExitPopup(context) async {
    if (_repositoryComponents.selectedNumberMainTab.value == 2) {
      _repositoryComponents.onChangedTab1(context);
      notifyListeners();
    } else {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.whiteColor,
              title: Text(AppLocalizations.of(context)!.exitApp),
              content: Text(AppLocalizations.of(context)!.exitAppBody),
              actions: [
                Row(
                  children: [
                    SubmitButton(
                      width: 30.0.wp,
                      onPressed: () => Navigator.of(context).pop(false),
                      //return false when click on "NO"
                      text: (AppLocalizations.of(context)!.noText),
                    ),
                    SubmitButton(
                      width: 30.0.wp,
                      onPressed: () => Navigator.of(context).pop(true),
                      //return true when click on "Yes"
                      text: (AppLocalizations.of(context)!.yesText),
                    ),
                  ],
                ),
              ],
            ),
          ) ??
          false;
    }
    return false;
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryComponents, _repositoryNotification];
}
