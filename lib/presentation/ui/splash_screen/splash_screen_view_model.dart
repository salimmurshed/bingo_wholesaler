import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../const/special_key.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../widgets/alert/bio/unlock_selector_screen_alert.dart';
import '/repository/order_repository.dart';
import '/repository/repository_components.dart';
import '/repository/repository_customer.dart';
import '/services/notification_service/notification_servicee.dart';

import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_secrets.dart';
import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../main.dart';
import '../../../repository/repository_notification.dart';
import '../../../repository/repository_retailer.dart';
import '../../../repository/repository_sales.dart';
import '../../../repository/repository_wholesaler.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../../services/storage/db.dart';
import '../../../services/storage/device_storage.dart';

class SplashScreenViewModel extends ReactiveViewModel {
  SplashScreenViewModel() {
    // checkInactivity();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!kIsWeb) {
        checkPinBioSet();
        print('DataBase.unlockTypeBio');
        print(_storage.getInt(DataBase.unlockTypeBio));
      }
    });
  }

  final ZDeviceStorage _storage = locator<ZDeviceStorage>();

  final NavigationService _navigationService = locator<NavigationService>();
  final NotificationServices _notificationService =
      locator<NotificationServices>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final RepositoryNotification _repositoryNotification =
      locator<RepositoryNotification>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final AuthService _authService = locator<AuthService>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();
  bool isRetailer = false;

  // final String defaultLocale = Platform.localeName;
  // SplashScreenViewModel() {
  //   // checkInactivity();
  //   loginCheckAppRun();
  // }

  // SplashScreenViewModel() {}

  // loginCheckAppRun(BuildContext context) {
  //   print(_storage.getString(DataBase.userData));
  //   if (kIsWeb) {
  //     alreadyLogInWeb();
  //   } else {
  //     alreadyLogIn().then((value) async {
  //       if (_storage.getString(DataBase.userData).isNotEmpty) {
  //         SchedulerBinding.instance.addPostFrameCallback((_) {
  //           _repositoryNotification.getNotification();
  //         });
  //         if (!isRetailer) {
  //           SchedulerBinding.instance.addPostFrameCallback((_) {
  //             _repositoryComponents.getComponentsReady();
  //           });
  //         } else {
  //           SchedulerBinding.instance.addPostFrameCallback((_) {
  //             _repositoryComponents.getComponentsRetailerReady();
  //             _repositoryOrder.getAllOrder(1);
  //           });
  //         }
  //       }
  //       await _notificationService.getFcmDeviceToken();
  //
  //       // await _repositoryNotification.getNotification();
  //     }).then((value) {
  //       SchedulerBinding.instance.addPostFrameCallback((_) {
  //         isRetailer ? getRetailerDocuments() : getWholesalersRequest();
  //       });
  //     });
  //   }
  //
  //   if (kIsWeb) {
  //     // setTabBarDefault();
  //   }
  // }

  checkPinBioSet() async {
    if (_storage.getString(DataBase.userToken).isNotEmpty) {
      // String unLockPin = _storage.getString(DataBase.unlockPin);
      int unlockTypeBio = _storage.getInt(DataBase.unlockTypeBio);
      UserModel user =
          UserModel.fromJson(jsonDecode(_storage.getString(DataBase.userData)));
      if (!user.data!.isPinSet! && unlockTypeBio == 0) {
        bool userLockSet = await _navigationService.animatedDialog(
            UnlockSelectorScreen(
              screen: user.data!.isPinSet! ? 1 : 0,
            ),
            barrierDismissible: false);
        if (userLockSet) {
          loginCheckAppRun();
        }
      } else {
        loginCheckAppRun();
      }
    } else {
      loginCheckAppRun();
    }
  }

  loginCheckAppRun() {
    // checkInactivity();
    alreadyLogIn().then((bool isLock) async {
      await _notificationService.getFcmDeviceToken();
      if (!isLock) {
        if (_storage.getString(DataBase.userData).isNotEmpty) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            _repositoryNotification.getNotification();
          });
          if (!isRetailer) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _repositoryWholesaler.getTodayRouteList();
              _repositoryComponents.getComponentsReady();
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _repositoryComponents.getComponentsRetailerReady();
              _repositoryOrder.getAllOrder(1);
            });
          }
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          isRetailer ? getRetailerDocuments() : getWholesalersRequest();
        });
      }

      // await _repositoryNotification.getNotification();
    });
  }

  // setTabBarDefault() async {
  //   await prefs.setString(DataBase.tabNumber, Routes.dashboardScreen);
  //
  //   _navigationService.pushNamed(Routes.dashboardScreen);
  // }

  void getSalesData() async {
    await _repositorySales.getWholesalersSalesData(1);
    await _repositorySales.getWholesalersSalesDataOffline();
    notifyListeners();
  }

  getRetailerDocuments() async {
    await _repositoryRetailer.getStores();
    await _repositoryRetailer.getWholesaler();
    await _repositoryRetailer.getFia();
    await _repositoryRetailer.getRetailerSettlementList("1");
    // await _repositoryRetailer.getRetailerCreditlineList();
    // await getRetailersRequest();
    await _repositoryRetailer.getRetailersAssociationData();
    await _repositoryRetailer.getRetailersFieAssociationData();
    await _repositoryRetailer.getCreditLinesList();
    await _repositoryRetailer.getRetailerWholesalerList();
    await _repositoryRetailer.getRetailerBankAccounts();
    await _repositoryRetailer.getRetailerFieList(1);
    // await _repositoryRetailer.callWholesalerListForOrder();
    // await getRetailerBankAccounts();
    // getCreditLinesList();
  }

  Future getRetailerBankAccounts() async {
    setBusy(true);
    notifyListeners();
    await _repositoryRetailer.getRetailerWholesalerList();
    await Future.delayed(const Duration(seconds: 1));
    await _repositoryRetailer.getRetailerBankAccounts();
    await _repositoryRetailer.getRetailerFieList(1);
    // associationRequestData = _repositoryRetailer.associationRequestData.value;
    setBusy(false);
    notifyListeners();
  }

  Future getRetailersRequest() async {
    setBusy(true);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    await _repositoryRetailer.getRetailersAssociationData();
    await _repositoryRetailer.getRetailersFieAssociationData();
    await _repositoryRetailer.getCreditLinesList();
    // associationRequestData = _repositoryRetailer.associationRequestData.value;
    setBusy(false);
    notifyListeners();
  }

  getWholesalersRequest() async {
    setBusy(true);
    notifyListeners();
    // await _repositoryWholesaler.getWholesalersAssociationData();
    // await _repositoryWholesaler.getCreditLinesList();
    await _repositoryWholesaler.getWholesalersAssociationDataLocal();
    await _repositoryWholesaler.getCreditLinesListLocal();
    setBusy(false);
    notifyListeners();
  }

  Future<bool> alreadyLogIn() async {
    await Future.delayed(const Duration(seconds: 3));
    if (_storage.getString(DataBase.userToken).isNotEmpty) {
      int storedTime = (prefs.getInt(DataBase.lastActiveTime) ?? 0);
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      _authService.getLoggedUserDetails();
      isRetailer = _authService.enrollment.value == UserTypeForWeb.retailer;
      getSalesData();
      if (storedTime != 0) {
        if (nowTime - storedTime > SpecialKeys.lockTiming) {
          await _storage.setBool(DataBase.accountStatus, true);
          _navigationService.pushReplacementNamed(Routes.lockScreenView);
          return true;
        } else {
          await _storage.setBool(DataBase.accountStatus, false);
          _navigationService.pushReplacementNamed(Routes.dashboardScreen);
          // await _repositoryWholesaler.getDynamicRoutesList();
          await _repositoryWholesaler.getStaticRoutesList();
          await _repositoryWholesaler.getSalesZonesList();
          await _customerRepository.getCustomerOnline(1);
          return false;
        }
      } else {
        _navigationService.pushReplacementNamed(Routes.dashboardScreen);
        // await _repositoryWholesaler.getDynamicRoutesList();
        await _repositoryWholesaler.getStaticRoutesList();
        await _repositoryWholesaler.getSalesZonesList();
        await _customerRepository.getCustomerOnline(1);
        return false;
      }
    } else {
      _navigationService.pushReplacementNamed(Routes.login);
      return false;
    }
  }

  alreadyLogInWeb() async {
    // if (ModalRoute.of(context)!.settings.name == webRoute.Routes.startupView) {
    await Future.delayed(const Duration(seconds: 3));
    if (_storage.getString(DataBase.userToken).isNotEmpty) {
      _authService.getLoggedUserDetails();
      isRetailer = _authService.enrollment.value == UserTypeForWeb.retailer;
      //   context.goNamed(webRoute.Routes.dashboardScreen);
      //   // _navigationService.pushReplacementNamed(Routes.dashboardScreen);
      // } else {
      //   context.goNamed(webRoute.Routes.login);
      // _navigationService.pushReplacementNamed(Routes.login);
    }
    // }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_authService];
}
