import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bingo/const/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../const/special_key.dart';
import '../../../services/storage/db.dart';
import '/const/email_validator.dart';
import '/data_models/models/user_model/user_model.dart';
import '/repository/repository_components.dart';
import '/repository/repository_customer.dart';
import '/services/auth_service/auth_service.dart';
import '/services/network/network_info.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import '../../../app/app_config.dart';
import '../../../app/app_secrets.dart';
import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../app/web_route.dart' as r;
import '../../../const/connectivity.dart';
import '../../../data_models/models/logged_user_model/logged_user_model.dart';
import '../../../main.dart';
import '../../../repository/order_repository.dart';
import '../../../repository/repository_notification.dart';
import '../../../repository/repository_retailer.dart';
import '../../../repository/repository_sales.dart';
import '../../../repository/repository_wholesaler.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../widgets/alert/alert_dialog.dart';

class LoginScreenViewModel extends ReactiveViewModel {
  LoginScreenViewModel() {
    // prefs.remove(DataBase.lastUser);
    SchedulerBinding.instance.addPostFrameCallback((_) {});
    getAllLoggedUser();
    checkInternet();
    getInfo();
  }

  getInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
  }

  checkInternet() async {
    bool connection = await checkConnectivity();
    if (!connection) {
      locator<RepositoryComponents>().changeInternetStatus(false);
    } else {
      locator<RepositoryComponents>().changeInternetStatus(true);
    }
  }

  getAllLoggedUser() {
    if (_authService.getLastUser().isNotEmpty) {
      nameController.text = _authService.getLastUser();
      notifyListeners();
    }
  }

  final AuthService _authService = locator<AuthService>();
  final RepositoryNotification _repositoryNotification =
      locator<RepositoryNotification>();
  final NavigationService _navigationService = locator<NavigationService>();

  final RepositoryWholesaler _repositoryWholesaler =
      locator<RepositoryWholesaler>();
  final CustomerRepository _customerRepository = locator<CustomerRepository>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final RepositoryRetailer _repositoryRetailer = locator<RepositoryRetailer>();
  final RepositorySales _repositorySales = locator<RepositorySales>();
  final NetworkInfoService _networkService = locator<NetworkInfoService>();
  final RepositoryOrder _repositoryOrder = locator<RepositoryOrder>();

  bool get connection => _repositoryComponents.internetConnection.value;

  bool connectionStatus = false;
  bool hasCalled = false;
  bool hasShownSnackbar = false;

  String _emailError = "";
  String _passwordError = "";
  ScrollController scrollController = ScrollController();

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  bool isVisible = false;
  bool isLoginAttempt = false;

  List<LoggedUserModel> get allLoggedUser => _authService.allLoggedUser.value;

  String get emailError => _emailError;

  String get passwordError => _passwordError;
  bool isEmailValidate = false;
  bool isPasswordValidate = false;

  bool get isRememberMe => _authService.isRememberMe;

  Future setLastUser(String email) async {
    await _authService.setLastUser(email);
  }

  void changeRememberMe() {
    _authService.changeRememberMe();
    notifyListeners();
  }

  void changeVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void getSelectedUser(String? email) async {
    nameController.text = email!;
    notifyListeners();
  }

  void forgotPasswordButton() async {
    if (!await launchUrl(
      Uri.parse(ConstantEnvironment.forgotUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ${ConstantEnvironment.forgotUrl}');
    }
  }

  void signUp() async {
    if (!await launchUrl(
      Uri.parse(ConstantEnvironment.signupUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch ${ConstantEnvironment.signupUrl}');
    }
  }

  String? checkEmail(String v) {
    if (v.isEmpty) {
      _emailError =
          AppLocalizations.of(activeContext)!.emptyEmailValidationText;
      isEmailValidate = false;
      notifyListeners();
    } else if (!EmailValidator.validate(v)) {
      _emailError =
          AppLocalizations.of(activeContext)!.wrongEmailFormatValidationText;
      isEmailValidate = false;
      notifyListeners();
    } else {
      _emailError = "";
      isEmailValidate = true;
      notifyListeners();
    }
    return null;
  }

  String? checkPassword(String v) {
    if (v.isEmpty) {
      isPasswordValidate = false;
      _passwordError =
          AppLocalizations.of(activeContext)!.emptyPasswordValidationText;
      notifyListeners();
    } else if (v.length < 8) {
      isPasswordValidate = false;
      _passwordError = AppLocalizations.of(activeContext)!.wrongCredentials;
      notifyListeners();
    } else {
      _passwordError = "";
      isPasswordValidate = true;
      notifyListeners();
    }
    return null;
  }

  void makeBusy(bool v) {
    isLoginAttempt = v;
    notifyListeners();
  }

  void login(BuildContext context) async {
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
    if (_formKey.currentState!.validate()) {
      if (isEmailValidate && isPasswordValidate) {
        try {
          makeBusy(true);
          try {
            if (!kIsWeb) {
              await _networkService.permissionHandle();
            }
          } catch (_) {
            makeBusy(false);
          }
          // Position? position;
          // if (kIsWeb) {
          //   Position position = await Geolocator.getCurrentPosition(
          //       desiredAccuracy: LocationAccuracy.high);
          //   print(position);
          // }
          UserModel? user;
          if (context.mounted) {
            print(getEncryptedData(nameController.text));
            print(getEncryptedData(passwordController.text));
            if (kIsWeb) {
              user = await _authService.login(
                  getEncryptedData(nameController.text),
                  getEncryptedData(passwordController.text),
                  context,
                  "",
                  "");
            } else {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              print(position);

              user = await _authService.login(
                  getEncryptedData(nameController.text),
                  getEncryptedData(passwordController.text),
                  context,
                  position.latitude.toString(),
                  position.longitude.toString());
            }
            if (isRememberMe) {
              setLastUser(nameController.text);
            }
            makeBusy(false);
            if (user.success!) {
              if (kIsWeb) {
                context.goNamed(r.Routes.dashboard);
              } else {
                _navigationService.pushReplacementNamed(Routes.dashboardScreen);
              }
              if (user.data!.enrollmentType!.toLowerCase() ==
                  "Retailer".toLowerCase()) {
                await getRetailerDocuments();
              } else {
                _repositoryWholesaler.getTodayRouteList();
                await getWholesalersRequest();
              }
              await _repositoryNotification.getNotification();
              getSalesData();
              makeBusy(false);
            } else {
              makeBusy(false);
              _navigationService
                  .animatedDialog(AlertDialogMessage(user.message!));
            }
            makeBusy(false);
          }
        } on Exception catch (_) {
          makeBusy(false);
          // TODO
        }
      }
    }
  }

  Future<void> copyDeviceToken() async {
    String? d = await FirebaseMessaging.instance.getToken();
    await Clipboard.setData(ClipboardData(text: d ?? ""));
  }

  Future getHomeScreenReady() async {
    setBusy(true);
    notifyListeners();
    await _repositorySales.getDashboardPendingSales();
    setBusy(false);
    notifyListeners();
  }

  Future getWholesalersRequest() async {
    setBusy(true);
    notifyListeners();
    // await _repositoryWholesaler.getWholesalersAssociationData();
    // await _repositoryWholesaler.getCreditLinesList();
    await _repositoryWholesaler.getWholesalersAssociationDataLocal();
    await _repositoryWholesaler.getCreditLinesListLocal();
    // await _repositoryWholesaler.getDynamicRoutesList();
    await _repositoryWholesaler.getStaticRoutesList();
    await _repositoryWholesaler.getSalesZonesList();
    await _customerRepository.getCustomerOnline(1);
    setBusy(false);
    notifyListeners();
  }

  Future getRetailerDocuments() async {
    await _repositoryRetailer.getStores();
    await _repositoryRetailer.getWholesaler();
    await _repositoryRetailer.getFia();
    await _repositoryRetailer.getRetailerSettlementList('1');
    // await _repositoryRetailer.getRetailerCreditlineList();
    await _repositoryOrder.getAllOrder(1);
    await getHomeScreenReady();
    // await _repositoryRetailer.callWholesalerListForOrder();
    getRetailersRequest();
    getRetailerBankAccounts();
    // getCreditLinesList();
  }

  void getRetailerBankAccounts() async {
    setBusy(true);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    await _repositoryRetailer.getRetailerBankAccounts();
    await _repositoryRetailer.getRetailerWholesalerList();
    await _repositoryRetailer.getRetailerFieList(1);
    // associationRequestData = _RepositoryRetailer.associationRequestData.value;
    setBusy(false);
    notifyListeners();
  }

  void getRetailersRequest() async {
    setBusy(true);
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    await _repositoryRetailer.getRetailersAssociationData();
    await _repositoryRetailer.getRetailersFieAssociationData();
    await _repositoryRetailer.getCreditLinesList();
    // associationRequestData = _RepositoryRetailer.associationRequestData.value;
    setBusy(false);
    notifyListeners();
  }

  void getSalesData() async {
    await _repositorySales.getWholesalersSalesData(1);
    await _repositorySales.getWholesalersSalesDataOffline();
    notifyListeners();
  }

  String getEncryptedData(String value) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(
      value,
      iv: SpecialKeys.iv,
    );
    return encrypted.base64;
  }

  retailerPrefill() {
    if (ConstantEnvironment.environments == Environment.dev) {
      nameController.text = "anacaona@mailinator.com";
      passwordController.text = "12345678";
    } else {
      nameController.text = "alcantara@mailinator.com";
      passwordController.text = "12345678";
    }
    notifyListeners();
  }

  wholesalerPrefill() {
    if (ConstantEnvironment.environments == Environment.dev) {
      nameController.text = "info@bepensa.com.do";
      passwordController.text = "Password@213";
    } else {
      nameController.text = "wholesaler_dummy@mailinator.com";
      passwordController.text = "12345678";
    }
    notifyListeners();
  }

  Future<void> gettoken() async {
    Utils.toast("dToken");
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      await firebaseMessaging.getAPNSToken();
      print('success');
    } catch (e) {
      print('e.toString()');
      print(e.toString());
    }
    if (Platform.isIOS) {
      String? apnToken = await firebaseMessaging.getAPNSToken();

      Utils.fPrint("dToken");
      if (apnToken != null) {
        String? copy = await firebaseMessaging.getToken();
        Utils.fPrint("dToken($copy)");
        Utils.fPrint("dToken($copy)");
        Clipboard.setData(ClipboardData(text: "$copy"));
      } else {
        Utils.fPrint("dToken");
        Utils.fPrint("token not generated");
      }
    } else {
      Utils.fPrint("it is not ios");
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_repositoryComponents];
}
