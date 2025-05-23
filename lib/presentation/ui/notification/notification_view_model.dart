import '../../../data_models/enums/user_type_for_web.dart';
import '/app/router.dart';
import '/repository/repository_notification.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app/locator.dart';
import '../../../data_models/enums/data_source.dart';
import '../../../data_models/enums/manage_account_from_pages.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../../data_models/models/notification_model/notification_model.dart';
import '../../../data_models/models/retailer_bank_list/retailer_bank_list.dart';
import '../../../main.dart';
import '../../../repository/repository_sales.dart';
import '../home_screen/home_screen_view_model.dart';

class NotificationViewModel extends ReactiveViewModel {
  NotificationViewModel() {
    // _repositoryNotification.setUnseenNotification();
    getNotification();
    clearNotificationCounter();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryNotification];
  final RepositoryNotification _repositoryNotification =
      locator<RepositoryNotification>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final AuthService _authService = locator<AuthService>();

  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  String get language => _authService.selectedLanguageCode;

  List<NotificationData> get allNotifications =>
      _repositoryNotification.allNotifications.value;

  String get notificationMessage =>
      _repositoryNotification.notificationMessage.value;

  bool get notificationLoadMoreButton =>
      _repositoryNotification.notificationLoadMoreButton;

  int notificationPageNumber = 1;
  bool isLoaderBusy = false;

  setLoaderBusy(bool v) {
    isLoaderBusy = v;
    notifyListeners();
  }

  getNotification() async {
    setBusy(true);
    notifyListeners();
    await _repositoryNotification.getNotification();
    // .catchError((_) {
    //   setBusy(false);
    //   notifyListeners();
    // });
    setBusy(false);
    notifyListeners();
  }

  getNotificationLoadMore() async {
    setLoaderBusy(true);
    await _repositoryNotification.getNotificationLoadMore();

    setLoaderBusy(false);
  }

  String selectedFilter = AppLocalizations.of(activeContext)!.status;

  bool isWaiting = false;

  void makeWaiting(v) {
    isWaiting = v;
    notifyListeners();
  }

  void readQrScanner(BuildContext context) async {
    _repositorySales.startBarcodeScanner2(context,
        enrollment == UserTypeForWeb.retailer, _authService.user.value);
  }

  Future<void> visitScreen(int i) async {
    if (allNotifications[i].notificationType == 10 ||
        allNotifications[i].notificationType == 11 ||
        allNotifications[i].notificationType == 14 ||
        allNotifications[i].notificationType == 15) {
      if (enrollment == UserTypeForWeb.retailer) {
        makeWaiting(true);

        AllSalesData data = await _repositoryNotification
            .getSaleDetails(allNotifications[i].targetUniqueId)
            .catchError((_) {
          makeWaiting(false);
        });
        data.uniqueId = allNotifications[i].targetUniqueId;
        print('allNotifications[i].targetUniqueId ${data.uniqueId}');

        await seenNotificationSend(allNotifications[i].targetUniqueId!);
        makeWaiting(false);
        _navigationService.pushNamed(Routes.salesDetailsScreen,
            arguments: data);
      } else {
        makeWaiting(true);
        AllSalesData data = await _repositoryNotification
            .getSaleDetailsWholesaler(allNotifications[i].targetUniqueId, i)
            .catchError((_) {
          makeWaiting(false);
        });
        print('allNotifications[i].targetUniqueId');
        print(allNotifications[i].targetUniqueId);
        data.uniqueId = allNotifications[i].targetUniqueId;

        await seenNotificationSend(allNotifications[i].uniqueId!);
        makeWaiting(false);
        _navigationService.pushNamed(Routes.salesDetailsScreen,
            arguments: data);
      }
    } else if (allNotifications[i].notificationType == 2) {
      makeWaiting(true);

      await seenNotificationSend(allNotifications[i].uniqueId!);
      makeWaiting(false);
      _navigationService.pushNamed(Routes.associationRequestDetailsScreen,
          arguments: GetId(
            id: allNotifications[i].targetUniqueId!,
            type: RetailerTypeAssociationRequest.fie,
            isFie: true,
          ));
    } else if (allNotifications[i].notificationType == 3 ||
        allNotifications[i].notificationType == 4 ||
        allNotifications[i].notificationType == 5) {
      makeWaiting(true);
      await seenNotificationSend(allNotifications[i].uniqueId!);
      makeWaiting(false);
      _navigationService.pushNamed(Routes.associationRequestDetailsScreen,
          arguments: GetId(
            id: allNotifications[i].targetUniqueId!,
            type: RetailerTypeAssociationRequest.wholesaler,
            isFie: false,
          ));
    } else if (allNotifications[i].notificationType == 13) {
      makeWaiting(true);
      await seenNotificationSend(allNotifications[i].uniqueId!);
      makeWaiting(false);
      _navigationService.pushNamed(Routes.associationRequestDetailsScreen,
          arguments: GetId(
            id: allNotifications[i].targetUniqueId!,
            type: RetailerTypeAssociationRequest.wholesaler,
            isFie: false,
          ));
    } else if (allNotifications[i].notificationType == 6 ||
        allNotifications[i].notificationType == 7 ||
        allNotifications[i].notificationType == 8 ||
        allNotifications[i].notificationType == 9) {
      makeWaiting(true);
      await seenNotificationSend(allNotifications[i].uniqueId!);
      makeWaiting(false);
      _navigationService.pushNamed(Routes.addCreditLineView,
          arguments: allNotifications[i].targetUniqueId!);
    } else if (allNotifications[i].notificationType == 12) {
      makeWaiting(true);
      RetailerBankListData data = await _repositoryNotification
          .getBankDetails(allNotifications[i].targetUniqueId!);
      await seenNotificationSend(allNotifications[i].uniqueId!);
      makeWaiting(false);
      _navigationService.pushNamed(Routes.addManageAccountView,
          arguments: ScreenBasedRetailerBankListData(
              data: data, page: ManageAccountFromPages.notification));
    } else if (allNotifications[i].notificationType == 16) {
      makeWaiting(true);
      await seenNotificationSend(allNotifications[i].uniqueId!);
      makeWaiting(false);
      _navigationService.pushNamed(Routes.orderDetailsScreenView,
          arguments: allNotifications[i].targetUniqueId!);
    } else {}
  }

  Future seenNotificationSend(String id) async {
    print(id);
    await _repositoryNotification.seenNotificationSend(id);
  }

  Future clearNotificationCounter() async {
    _repositoryNotification.clearNotificationCounter();
  }
}
