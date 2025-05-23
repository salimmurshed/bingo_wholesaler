import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../app/app_secrets.dart';
import '../../../const/special_key.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/today_route_list_model/today_route_list_model.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/bool_return_alert_dialog.dart';
import '../../widgets/alert/route_zone_filter_dialog.dart';
import '/app/router.dart';
import '/my_app_files/my_app_mobile.dart';
import '/repository/repository_sales.dart';
import '/repository/repository_wholesaler.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import '/services/storage/device_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../const/connectivity.dart';
import '../../../const/utils.dart';
import '../../../data/data_source/languages.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../../main.dart';
import '../../../repository/repository_components.dart';
import '../../../repository/repository_customer.dart';
import '../../../repository/repository_retailer.dart';
import '../../../services/local_data/local_data.dart';
import '../../../services/storage/db.dart';

class MyDrawerModel extends ReactiveViewModel {
  MyDrawerModel() {
    setLanguage();
    _storage.clearSingleData(DataBase.userZone);
  }

  final ZDeviceStorage _storage = locator<ZDeviceStorage>();

  final _deviceStorage = locator<ZDeviceStorage>();
  final _repositoryComponents = locator<RepositoryComponents>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final _nav = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _localData = locator<LocalData>();
  final _repositorySales = locator<RepositorySales>();
  final _repositoryRetailer = locator<RepositoryRetailer>();
  final _repositoryCustomer = locator<CustomerRepository>();

  UserModel get user => _authService.user.value;

  List<PendingToAttendStores>? get pendingToAttendStores =>
      _repositoryWholesaler.todayRouteList.value.pendingToAttendStores;

// getPendingData(){pendingToAttendStores =
// _repositoryWholesaler.todayRouteList.value.pendingToAttendStores;}
  // bool get isRetailer => _authService.isRetailer.value;
  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;

  List<SalesZones> get salesZones =>
      _authService.user.value.data!.salesZones ?? [];

  List<SalesRoutes> get salesRoutes =>
      _authService.user.value.data!.salesRoutes ?? [];

  List<Stores> get salesStores => _authService.user.value.data!.stores!;

  UserZoneRouteModel? selectedZoneRoute;
  Stores? selectedStore;
  AllLanguage? selectedLanguage;
  List<AllLanguage> languages = allLanguages;

  bool isScreenBusy = false;

  setScreenBusy(bool v) {
    isScreenBusy = v;
    notifyListeners();
  }

  List<UserZoneRouteModel> userZoneRouteModel = [];

  String getEncryptedData(String value) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(
      value,
      iv: SpecialKeys.iv,
    );
    return encrypted.base64;
    // return value;
  }

  getUserZoneRoute() {
    if (enrollment == UserTypeForWeb.wholesaler) {
      listCreate();

      if (_storage.getString(DataBase.selectedZoneRoute).isNotEmpty) {
        UserZoneRouteModel zoneRoute = UserZoneRouteModel.fromJson(
            jsonDecode(_storage.getString(DataBase.selectedZoneRoute)));
        selectedZoneRoute = userZoneRouteModel
            .firstWhere((element) => element.id == zoneRoute.id);
      } else {
        selectedZoneRoute = userZoneRouteModel.first;
      }

      notifyListeners();
    } else {
      _authService.getUserStores();
      if (_authService.salesStore != null) {
        selectedStore = salesStores.firstWhere((element) =>
            element.uniqueId == _authService.salesStore!.uniqueId!);
        notifyListeners();
      }
    }
  }

  void listCreate() {
    userZoneRouteModel.clear();
    userZoneRouteModel
        .add(UserZoneRouteModel(id: "all", name: "View All", type: 0, uid: ""));
    userZoneRouteModel
        .add(UserZoneRouteModel(id: "", name: "Zones", type: 3, uid: ""));
    for (int i = 0; i < salesZones.length; i++) {
      userZoneRouteModel.add(UserZoneRouteModel(
          id: salesZones[i].zoneId!,
          name: salesZones[i].zoneName!,
          type: 1,
          uid: salesZones[i].uniqueId));
    }

    userZoneRouteModel
        .add(UserZoneRouteModel(id: "", name: "Routes", type: 3, uid: ""));
    for (int i = 0; i < salesRoutes.length; i++) {
      userZoneRouteModel.add(UserZoneRouteModel(
          id: salesRoutes[i].salesRouteId!,
          name: salesRoutes[i].salesRouteName!,
          type: 2,
          uid: salesRoutes[i].uniqueId));
    }
  }

  setLanguage() {
    _authService.getLanguage().then((v) {
      if (_authService.selectedLanguageCode.isEmpty) {
        Locale deviceLocale = window.locale;
        String langCode = deviceLocale.languageCode;
        if (langCode == 'en' || langCode == 'es') {
          selectedLanguage =
              allLanguages.firstWhere((element) => element.code == langCode);
        } else {
          selectedLanguage =
              allLanguages.firstWhere((element) => element.code == 'en');
        }
        notifyListeners();
      } else {
        if (_authService.selectedLanguageCode == 'en' ||
            _authService.selectedLanguageCode == 'es') {
          selectedLanguage = allLanguages.firstWhere(
              (element) => element.code == _authService.selectedLanguageCode);
        } else {
          selectedLanguage =
              allLanguages.firstWhere((element) => element.code == 'en');
        }
        notifyListeners();
      }
    });
  }

  ///type: wholesaler
  Future<void> clearWholesalerData() async {
    bool connection = await checkConnectivity();
    if (connection) {
      await _localData.deleteWholesalerDataForFilterSearch();
      await _repositorySales.clearSale();
      await _repositoryCustomer.clearCustomer();
    }
  }

  ///type: retailer
  Future<void> clearRetailerData() async {
    bool connection = await checkConnectivity();
    if (connection) {
      await _localData.deleteRetailerDataForFilterSearch();
      await _repositorySales.clearSale();
      await _repositoryRetailer.clearWholesaler();
      await _repositoryRetailer.clearFie();
    }
  }

  void changeSaleStore(Stores v) async {
    bool connection = await checkConnectivity();
    if (connection) {
      print('vvvvv');
      print(jsonEncode(v));
      if (v.uniqueId == null) {
        _nav.animatedDialog(const AlertDialogMessage("Internal error"));
      } else {
        await _storage.setString(DataBase.userStoreId, v.uniqueId);
        setScreenBusy(false);
        await _authService.setSalesStore(v);

        await _repositoryRetailer.getRetailersUser(1);
        // .catchError((_) {
        //   setScreenBusy(false);
        // });
        await clearRetailerData();
        selectedStore = v;
        setScreenBusy(false);
      }
    } else {
      if (activeContext.mounted) {
        Utils.toast(AppLocalizations.of(activeContext)!.noInternetError,
            isBottom: true);
      }
    }
  }

  Future changeLanguage(AllLanguage v, context) async {
    setScreenBusy(true);
    notifyListeners();
    print(isScreenBusy);
    await _authService.updateLanguage(v.code!).then((value) {
      MyAppMobile.setLocale(context, Locale(v.code!));
      selectedLanguage = v;
    }).catchError((_) {
      setScreenBusy(false);
      notifyListeners();
    });

    setScreenBusy(false);
    notifyListeners();
  }

  gotoProfile() {
    _nav.pushNamed(Routes.profile);
  }

  @override
  bool isBusy = false;

  void refresh(v) {
    isBusy = v;
    notifyListeners();
  }

  void logout(context) async {
    bool connection = await checkConnectivity();
    if (connection) {
      refresh(true);
      await _authService.logout(context);
      // final gh = i1.GetItHelper(locator);
      // locator<RepositoryComponents>().onChangedTab(context, 0);
      // if (locator.isRegistered<RepositoryRetailer>()) {
      //   locator.unregister<RepositoryRetailer>();
      //   gh.lazySingleton<i2.RepositoryRetailer>(() => i2.RepositoryRetailer());
      // }
      // if (locator.isRegistered<RepositoryWholesaler>()) {
      //   locator.unregister<RepositoryWholesaler>();
      //   gh.lazySingleton<i3.RepositoryWholesaler>(
      //       () => i3.RepositoryWholesaler());
      // }
      // if (locator.isRegistered<RepositoryComponents>()) {
      //   locator.unregister<RepositoryComponents>();
      //   gh.lazySingleton<i4.RepositoryComponents>(
      //       () => i4.RepositoryComponents());
      // }
      // await _deviceStorage.clearData();
      // Locale deviceLocale = window.locale;
      // String langCode = deviceLocale.languageCode;
      // MyApp.setLocale(context, Locale(langCode));
      // _authService.clearLanguage();
      // _localData.deleteDB();
      // _repositoryComponents.setDashBoardInitialPage(context);
      // // _repositoryComponents.setDashBoardInitialPage(context);
      refresh(false);
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      Utils.toast(AppLocalizations.of(context)!.logoutNoInternetMessage);
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _authService,
        _repositoryComponents,
        _repositorySales,
        _repositoryWholesaler,
        _repositoryRetailer
      ];

  Future setClear() async {
    setScreenBusy(true);
    selectedZoneRoute = null;
    selectedStore = null;

    _authService.setClear();
    if (enrollment == UserTypeForWeb.retailer) {
      await _repositoryRetailer.getRetailersUser(1);
      await clearRetailerData();
    } else {
      await clearWholesalerData();
    }
    setScreenBusy(false);
  }

  Future<void> changeSaleZoneRoute(
      BuildContext context, UserZoneRouteModel value) async {
    if (value.type == 1) {
      gotoSalesZoneDetails(context, value);
    } else if (value.type == 2) {
      gotoSaleRoutesDetails(context, value);
    } else {
      print(jsonEncode(value));
      setClear();
      await _authService.cleanZoneRoute(value);
      selectedZoneRoute = value;
    }
  }

  Future<void> gotoSaleRoutesDetails(
      BuildContext context, UserZoneRouteModel v) async {
    notifyListeners();
    bool available =
        (_repositoryWholesaler.todayRouteList.value.pendingToAttendStores ?? [])
            .where((e) => e.routeId == v.uid)
            .isNotEmpty;
    int length =
        (_repositoryWholesaler.todayRouteList.value.pendingToAttendStores ?? [])
            .length;
    int? response = await _navigationService
        .animatedDialog(RouteZoneFilterDialog(available, length));
    print('responseresponse');
    print(response);
    if (response != null) {
      if (response == 2) {
        await _authService.setSalesRoute(v, isHeader: true);
        selectedZoneRoute = v;
        setScreenBusy(true);
        await clearWholesalerData();
        setScreenBusy(false);
      } else {
        setScreenBusy(true);
        print('v.uid!');
        print(v.toJson());
        await _repositoryWholesaler
            .addStaticRouteToTodoList(
          v.uid!,
          response,
          isRoute: true,
        )
            .then((value) {
          setScreenBusy(false);
          changeTab(context, 0);
        }).catchError((_) {
          setScreenBusy(false);
        });
        UserZoneRouteModel d = UserZoneRouteModel.fromJson(
            jsonDecode(_storage.getString(DataBase.selectedZoneRoute)));
        print('d.type');
        print(d.id);
        if (d.type != 2) {
          await _authService.setSalesRoute(
              UserZoneRouteModel(id: "all", name: "View All", type: 0, uid: ""),
              isHeader: false);

          selectedZoneRoute =
              UserZoneRouteModel(id: "all", name: "View All", type: 0, uid: "");
          notifyListeners();
        }
      }

      setScreenBusy(false);
      selectedZoneRoute = v;
      notifyListeners();
    }
  }

  Future<void> gotoSalesZoneDetails(context, UserZoneRouteModel v) async {
    print('UserZoneRouteModel');
    print(jsonEncode(v));
    bool available =
        (_repositoryWholesaler.todayRouteList.value.pendingToAttendStores ?? [])
            .where((e) => e.routeId == v.uid)
            .isNotEmpty;
    int length =
        (_repositoryWholesaler.todayRouteList.value.pendingToAttendStores ?? [])
            .length;
    int? response = await _navigationService
        .animatedDialog(RouteZoneFilterDialog(available, length));
    // await _navigationService.animatedDialog(BoolReturnAlertDialog(
    //   d
    //       ? AppLocalizations.of(activeContext)!
    //           .zoneLoaderAlertDialogMessageRemove
    //       : AppLocalizations.of(activeContext)!.zoneLoaderAlertDialogMessageAdd,
    //   yesButton: d
    //       ? AppLocalizations.of(activeContext)!.removeTodoCta
    //       : AppLocalizations.of(activeContext)!.addTodoCta,
    //   noButton: AppLocalizations.of(activeContext)!.filterAppCta,
    // ));
    if (response != null) {
      if (response == 2) {
        await _authService.setSalesZone(v, isHeader: true);
        selectedZoneRoute = v;
        setScreenBusy(true);
        await clearWholesalerData();
        setScreenBusy(false);
      } else {
        setScreenBusy(true);
        await _repositoryWholesaler
            .addStaticRouteToTodoList(
          v.uid!,
          response,
          isRoute: false,
        )
            .then((value) {
          setScreenBusy(false);
          changeTab(context, 0);
        }).catchError((_) {
          setScreenBusy(false);
        });
        UserZoneRouteModel d = UserZoneRouteModel.fromJson(
            jsonDecode(_storage.getString(DataBase.selectedZoneRoute)));
        print('d.type');
        print(d.id);
        if (d.type != 1) {
          await _authService.setSalesRoute(
              UserZoneRouteModel(id: "all", name: "View All", type: 0, uid: ""),
              isHeader: false);

          selectedZoneRoute =
              UserZoneRouteModel(id: "all", name: "View All", type: 0, uid: "");
          notifyListeners();
        }
      }
      setScreenBusy(false);
      selectedZoneRoute = v;
      notifyListeners();
    }
  }

  Future<void> changeTab(BuildContext context, int i) async {
    scaffoldKey.currentState!.closeDrawer();
    _repositoryComponents.onChangedTab(context, 3);
    _repositoryComponents.changeTabFourth(i);
    notifyListeners();
  }
}
