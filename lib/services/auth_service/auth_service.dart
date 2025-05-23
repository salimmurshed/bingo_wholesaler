import 'dart:convert' as convert;
import 'dart:convert';
import 'package:bingo/data_models/models/response_message_model/response_message_model.dart';
import 'package:bingo/repository/order_repository.dart';
import 'package:bingo/repository/order_repository.dart' as i5;
import 'package:encrypt/encrypt.dart' as encrypt;

import 'dart:io' show Platform;
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as w;

import '../../const/connectivity.dart';
import '../../const/special_key.dart';
import '../../data_models/enums/user_roles_files.dart';
import '../../presentation/widgets/alert/bool_return_alert_dialog.dart';
import '../../presentation/widgets/alert/bio/unlock_selector_screen_alert.dart';
import '../../repository/repository_retailer.dart';
import 'package:injectable/injectable.dart' as i1;
import '/repository/repository_retailer.dart' as i2;
import '/repository/repository_wholesaler.dart' as i3;
import '/repository/repository_components.dart' as i4;
import '../../repository/repository_wholesaler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/app/app_secrets.dart';
import '/const/utils.dart';
import '/presentation/widgets/alert/alert_dialog.dart';
import '/repository/repository_components.dart';
import '/services/notification_service/notification_servicee.dart';
import '../../data_models/enums/user_type_for_web.dart';
import '/my_app_files/my_app_mobile.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/src/widgets/framework.dart';
import 'package:dio/dio.dart' as dio;

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../app/router.dart';
import '../../const/database_helper.dart';
import '../../data_models/models/logged_user_model/logged_user_model.dart';
import '../../data_models/models/term_condition_model/term_condition_model.dart';
import '../../data_models/models/user_model/user_model.dart';
import '../../main.dart';
import '../local_data/local_data.dart';
import '../local_data/table_names.dart';
import '../navigation/navigation_service.dart';
import '../network/network_info.dart';
import '../network/network_urls.dart';
import '../network/web_service.dart';
import '../storage/db.dart';
import '../storage/device_storage.dart';

@lazySingleton
class AuthService with ListenableServiceMixin {
  final http.Client _client = http.Client();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();
  final LocalData _localData = locator<LocalData>();
  final NotificationServices _notificationService =
      locator<NotificationServices>();
  final RepositoryComponents _repositoryComponents =
      locator<RepositoryComponents>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WebService _webService = locator<WebService>();
  ReactiveValue<List<LoggedUserModel>> allLoggedUser = ReactiveValue([]);
  final dbHelper = DatabaseHelper.instance;
  ReactiveValue<UserModel> user = ReactiveValue(UserModel());

  // ReactiveValue<bool> isRetailer = ReactiveValue(false);
  ReactiveValue<UserTypeForWeb> enrollment =
      ReactiveValue(UserTypeForWeb.retailer);
  SalesZones? salesZone;
  SalesRoutes? salesRoute;

  // SalesZones? salesZone;
  // SalesRoutes? salesRoute;
  Stores? salesStore;

  // AllLanguage? selectedLanguage;
  var networkInfo = locator<NetworkInfoService>();
  bool isRememberMe = false;

  AuthService() {
    listenToReactiveValues([user, allLoggedUser, enrollment, isUserHaveAccess]);
  }

  // Future<Position> getLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  //   fPrint(position.latitude);
  //   debugPrint(position.longitude);
  //   return position;
  // }

  Future setLanguage(v) async {
    await _storage.setString(DataBase.userLanguage, convert.jsonEncode(v));
    notifyListeners();
  }

  void changeRememberMe() {
    isRememberMe = !isRememberMe;
    notifyListeners();
  }

  String selectedLanguageCode = '';

  Future getLanguage() async {
    if (_storage.getString(DataBase.userLanguage).isNotEmpty) {
      selectedLanguageCode = _storage.getString(DataBase.userLanguage);
    } else {
      Locale deviceLocale = window.locale;
      String langCode = deviceLocale.languageCode;
      selectedLanguageCode =
          langCode != "en" || langCode != "es" ? "en" : langCode;
      _storage.setString(DataBase.userLanguage, selectedLanguageCode);
    }
    await Future.delayed(Duration.zero);
    if (activeContext.mounted) {
      MyAppMobile.setLocale(activeContext, Locale(selectedLanguageCode));
    }
  }

  void clearLanguage() {
    selectedLanguageCode = '';
    notifyListeners();
  }

  Future setLastUser(String email) async {
    await _storage.setString(DataBase.lastUser, email);
    debugPrint(email);
    debugPrint(_storage.getString(DataBase.lastUser));
  }

  String getLastUser() {
    return _storage.getString(DataBase.lastUser);
  }

  UserZoneRouteModel? zoneRoutes;

  Future setSalesZone(UserZoneRouteModel v, {required bool isHeader}) async {
    await _storage.setString(
        DataBase.selectedZoneRoute, jsonEncode(v.toJson()));
    await _storage.setBool(DataBase.zoneRouterHeaderOption, isHeader);
    zoneRoutes = v;
    // _storage.clearSingleData(DataBase.userRoute);
    notifyListeners();
  }

  cleanZoneRoute(UserZoneRouteModel v) async {
    await _storage.clearSingleData(DataBase.selectedZoneRoute);
    await _storage.clearSingleData(DataBase.zoneRouterHeaderOption);

    await _storage.setString(
        DataBase.selectedZoneRoute, jsonEncode(v.toJson()));
  }

  Future setSalesRoute(UserZoneRouteModel v, {required bool isHeader}) async {
    await _storage.setString(
        DataBase.selectedZoneRoute, jsonEncode(v.toJson()));
    await _storage.setBool(DataBase.zoneRouterHeaderOption, isHeader);
    zoneRoutes = v;
    // _storage.clearSingleData(DataBase.userZone);
    notifyListeners();
  }

  Future setSalesStore(Stores v) async {
    await _storage.setString(DataBase.userStore, convert.jsonEncode(v));
    salesStore = v;
    notifyListeners();
  }

  setClear() {
    _storage.clearSingleData(DataBase.userZone);
    _storage.clearSingleData(DataBase.userRoute);
    _storage.clearSingleData(DataBase.userStore);
    _storage.clearSingleData(DataBase.userStoreId);
    _storage.clearSingleData(DataBase.selectedZoneRoute);
    // _storage.clearSingleData(DataBase.salesZoneId);
    // _storage.clearSingleData(DataBase.salesRouteId);
    zoneRoutes = null;
    salesStore = null;
    notifyListeners();
  }

  // getUserZoneRoute() {
  //   if (_storage.getString(DataBase.userZone).isNotEmpty) {
  //     salesZone = SalesZones.fromJson(
  //         convert.jsonDecode(_storage.getString(DataBase.userZone)));
  //   }
  //   if (_storage.getString(DataBase.userRoute).isNotEmpty) {
  //     salesRoute = SalesRoutes.fromJson(
  //         convert.jsonDecode(_storage.getString(DataBase.userRoute)));
  //   }
  // }

  getUserStores() {
    if (_storage.getString(DataBase.userStore).isNotEmpty) {
      salesStore = Stores.fromJson(
          convert.jsonDecode(_storage.getString(DataBase.userStore)));
    }
  }

  void getLoggedUserDetails() {
    user.value = UserModel.fromJson(
        convert.jsonDecode(_storage.getString(DataBase.userData)));

    enrollment.value = getEnrollType();
    notifyListeners();
    checkRole(user.value);
    getTerm();

    if (_storage.getString(DataBase.userStore).isNotEmpty) {
      salesStore = Stores.fromJson(
          convert.jsonDecode(_storage.getString(DataBase.userStore)));
      notifyListeners();
    }
  }

  List<TermConditionData> termConditions = [];

  Future getTerm() async {
    String response = _storage.getString(DataBase.terms);
    try {
      if (response.isNotEmpty) {
        TermConditionModel responseData =
            TermConditionModel.fromJson(jsonDecode(response));
        termConditions = responseData.data!;
        // notifyListeners();
      } else {
        final response =
            await _webService.postRequest(NetworkUrls.getPageTerms, {});
        debugPrint(response.body);
        debugPrint(NetworkUrls.getPageTerms);
        TermConditionModel responseData =
            TermConditionModel.fromJson(jsonDecode(response.body));
        _storage.setString(DataBase.terms, (response.body));
        termConditions = responseData.data!;
        notifyListeners();
      }
    } on Exception catch (_) {}
  }

  // Future<UserModel?> loginWithBio(String email, String password,
  //     BuildContext context, Position position) async {
  //   bool userLockSet = await _navigationService.animatedDialog(
  //           const UnlockSelectorScreen(),
  //           barrierDismissible: false) ??
  //       false;
  //   if (userLockSet) {
  //     if (context.mounted) {
  //       UserModel user = await login(email, password, context, position);
  //       return user;
  //     }
  //   }
  //   return null;
  // }

  checkEnrollment() {
    // user.value = UserModel.fromJson(
    //     convert.jsonDecode(_storage.getString(DataBase.userData)));
    // isRetailer.value = _storage.getString(DataBase.userType).toLowerCase() ==
    //         "Retailer".toLowerCase()
    //     ? true
    //     : false;

    enrollment.value = getEnrollType();
  }

  Future<UserModel> login(String email, String password, BuildContext context,
      String lat, String long) async {
    if (!kIsWeb) {
      if (Utils.hasSSL()) {
        await _notificationService.getFcmDeviceToken();
      }
    } else {
      await _notificationService.getFcmDeviceToken();
    }
    // String fcm = await FirebaseMessaging.instance.getToken();
    await Future.delayed(Duration.zero);
    String url = NetworkUrls.loginUrl;
    debugPrint(url);
    var body = {
      'email': email,
      'password': password,
      'device_type': kIsWeb
          ? "web"
          : Platform.isAndroid
              ? "android"
              : "ios",
      'device_token': (!kReleaseMode)
          ? "abcd"
          : kIsWeb
              ? "abcd"
              : _notificationService.fcmDeviceToken,
      'latitude': lat,
      'longitude': long
    };
    final response = await _client.post(Uri.parse(url), body: body);
    debugPrint('responseresponse');
    debugPrint(response.body);
    try {
      final responseData = UserModel.fromJson(jsonDecode(response.body));
      user.value = responseData;
      if (responseData.success!) {
        // _storage.setString(DataBase.userSettings, jsonEncode(body));
        _storage.setInt(DataBase.lastActiveTime, 0);
        _storage.setBool(DataBase.accountStatus, false);
        _storage.setString(DataBase.userData, jsonEncode(responseData));
        user.value = responseData;
        _storage.setString(DataBase.userToken, user.value.data!.token);
        debugPrint('_notificationService.fcmDeviceToken');
        debugPrint(_notificationService.fcmDeviceToken);
        _storage.setString(
            DataBase.fcmToken, _notificationService.fcmDeviceToken);
        _storage.setString(DataBase.userType, user.value.data!.enrollmentType);
        _storage.setString(
            DataBase.userLanguage, user.value.data!.languageCode);

        selectedLanguageCode = user.value.data!.languageCode!;

        checkRole(user.value);
        if (!kIsWeb) {
          int? unlockTypeBio = prefs.getInt(DataBase.unlockTypeBio);
          // debugPrint('unlockTypeBio');
          // debugPrint(unlockTypeBio.toString());
          if (unlockTypeBio == null || unlockTypeBio == 2) {
            bool userLockSet = await _navigationService.animatedDialog(
                    UnlockSelectorScreen(
                      screen: user.value.data!.isPinSet! ? 1 : 0,
                    ),
                    barrierDismissible: false) ??
                false;
          }
        }
        // if (userLockSet) {
        //   if (context.mounted) {
        //     UserModel user = await login(email, password, context, position);
        //     return user;
        //   }
        // }
        enrollment.value = getEnrollType();
        if (isRememberMe) {
          Map<String, dynamic> body = {
            DataBaseHelperKeys.uniqueId: user.value.data!.uniqueId!,
            DataBaseHelperKeys.email: user.value.data!.email!,
            DataBaseHelperKeys.firstName: user.value.data!.firstName!,
            DataBaseHelperKeys.lastName: user.value.data!.lastName!,
            DataBaseHelperKeys.profileImage: user.value.data!.profileImage!
          };
          if (!kIsWeb) {
            _localData.insertSingleData(TableNames.allLoggedUsers, body);
          }
        }
        if (user.value.data!.languageCode == null) {
          setLang();
        }

        await getTerm();
        // isRetailer.value =
        //     _storage.getString(DataBase.userType).toLowerCase() ==
        //             "Retailer".toLowerCase()
        //         ? true
        //         : false;
        notifyListeners();
        if (!kIsWeb) {
          if (enrollment.value == UserTypeForWeb.wholesaler) {
            await _repositoryComponents.getComponentsReady();
          } else if (enrollment.value == UserTypeForWeb.retailer) {
            await _repositoryComponents.getComponentsRetailerReady();
          } else {}
        }
        notifyListeners();
        return responseData;
      } else {
        print(jsonEncode(responseData));
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
      // return Left(AppExceptions.handle(e).failure);
    }
  }

  UserTypeForWeb getEnrollType() {
    UserTypeForWeb v = _storage.getString(DataBase.userType).toLowerCase() ==
            "retailer"
        ? UserTypeForWeb.retailer
        : _storage.getString(DataBase.userType).toLowerCase() == "wholesaler"
            ? UserTypeForWeb.wholesaler
            : UserTypeForWeb.fie;

    return v;
  }

  Future<UserModel> loginWeb(
      String email, String password, BuildContext context) async {
    await Future.delayed(Duration.zero);
    String url = NetworkUrls.loginUrl;
    debugPrint(url);
    var body = {
      'email': email,
      'password': password,
      'device_type': "web",
      'device_token': "abcd",
      'latitude': "",
      'longitude': ""
    };
    final response = await _client.post(Uri.parse(url), body: body);

    try {
      final responseData = UserModel.fromJson(jsonDecode(response.body));

      user.value = responseData;
      debugPrint(jsonEncode(body));
      if (responseData.success!) {
        _storage.setString(DataBase.userData, jsonEncode(responseData));
        user.value = responseData;
        _storage.setString(DataBase.userToken, user.value.data!.token);
        _storage.setString(DataBase.userType, user.value.data!.enrollmentType);
        _storage.setString(
            DataBase.userLanguage, user.value.data!.languageCode);
        selectedLanguageCode = user.value.data!.languageCode!;
        enrollment.value =
            user.value.data!.enrollmentType!.toLowerCase() == "retailer"
                ? UserTypeForWeb.retailer
                : user.value.data!.enrollmentType!.toLowerCase() == "wholesaler"
                    ? UserTypeForWeb.wholesaler
                    : UserTypeForWeb.fie;
        debugPrint('enrollment.value');
        debugPrint(enrollment.value.toString());
        if (user.value.data!.languageCode == null) {
          setLang();
        }

        await getTerm();

        enrollment.value = getEnrollType();
        // isRetailer.value =
        //     _storage.getString(DataBase.userType).toLowerCase() ==
        //             "Retailer".toLowerCase()
        //         ? true
        //         : false;
        notifyListeners();

        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
      // return Left(AppExceptions.handle(e).failure);
    }
  }

  List<UserRolesFiles> userAccess = [];

  String getEncryptedData(String value) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(SpecialKeys.key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(
      value,
      iv: SpecialKeys.iv,
    );
    return encrypted.base64;
  }

  void checkRole(UserModel value) {
    if (!user.value.data!.isMaster!) {
      List<String> roles =
          user.value.data!.role!.toLowerCase().replaceAll(" ", "").split(',');
      if (roles.contains("admin") ||
          roles.contains("finance") ||
          roles.contains("storemanager")) {
        if (roles.contains("admin")) {
          userAccess.addAll(RolesWiseAccess.admin);
        }
        if (roles.contains("finance")) {
          userAccess.addAll(RolesWiseAccess.finance);
        }
        if (roles.contains("storemanager")) {
          userAccess.addAll(RolesWiseAccess.storemanager);
        }
      } else {
        userAccess = [];
      }
    } else {
      userAccess.addAll(RolesWiseAccess.master);
      print('userAccess');
      print(userAccess);
      // userAccess.addAll(RolesWiseAccess.finance);
      // userAccess.addAll(RolesWiseAccess.admin);
      // userAccess.addAll(RolesWiseAccess.storemanager);
    }
    notifyListeners();
  }

  bool isUserHaveAccess(UserRolesFiles file) {
    if (userAccess.contains(file)) {
      debugPrint(true.toString());
      return true;
    } else {
      debugPrint(false.toString());
      return false;
    }
  }

  Future getAllLoggedUser() async {
    await dbHelper.queryAllRows(TableNames.allLoggedUsers).then((value) {
      allLoggedUser.value =
          value.map((e) => LoggedUserModel.fromJson(e)).toList();
    });
  }

  // Future getAllLoggedUser() async {
  //   await dbHelper.queryAllRows(TableNames.allLoggedUsers).then((value) {
  //     allLoggedUser.value =
  //         value.map((e) => LoggedUserModel.fromJson(e)).toList();
  //   });
  // }

  // Future removeUser(String uniqueId) async {
  //   await dbHelper
  //       .deleteData(TableNames.allLoggedUsers, uniqueId)
  //       .then((value) {
  //     Utils.toast("Account removed", isBottom: true);
  //   });
  //   notifyListeners();
  // }

  setLang() async {
    await MyAppMobile.setLocale(
        activeContext, Locale(user.value.data!.languageCode!));
    await Future.delayed(Duration.zero);
  }

  logoutService() async {
    // String tokern = await _storage.getString(DataBase.userToken);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${_storage.getString(DataBase.userToken)}",
    };
    debugPrint('_storage.getString(DataBase.fcmToken)');
    debugPrint(_storage.getString(DataBase.fcmToken));
    await _client.post(Uri.parse(NetworkUrls.logoutUrl),
        headers: headers,
        body: {"device_token": _storage.getString(DataBase.fcmToken)});
    debugPrint('cxcxcxcx1');
    debugPrint(headers.toString());
    // await _client.post(Uri.parse(NetworkUrls.logoutUrl),
    //     headers: headers,
    //     body: {"device_token": _storage.getString(DataBase.fcmToken)});
  }

  logout(context) async {
    bool connection = await checkConnectivity();
    if (connection) {
      await logoutService();
      final gh = i1.GetItHelper(locator);
      locator<RepositoryComponents>().onChangedTab(context, 0);
      if (locator.isRegistered<RepositoryRetailer>()) {
        locator.unregister<RepositoryRetailer>();
        gh.lazySingleton<i2.RepositoryRetailer>(() => i2.RepositoryRetailer());
      }
      if (locator.isRegistered<RepositoryWholesaler>()) {
        locator.unregister<RepositoryWholesaler>();
        gh.lazySingleton<i3.RepositoryWholesaler>(
            () => i3.RepositoryWholesaler());
      }
      if (locator.isRegistered<RepositoryComponents>()) {
        locator.unregister<RepositoryComponents>();
        gh.lazySingleton<i4.RepositoryComponents>(
            () => i4.RepositoryComponents());
      }
      if (locator.isRegistered<RepositoryOrder>()) {
        locator.unregister<RepositoryOrder>();
        gh.lazySingleton<i5.RepositoryOrder>(() => i5.RepositoryOrder());
      }
      await _storage.clearData();
      Locale deviceLocale = window.locale;
      String langCode = deviceLocale.languageCode;
      MyAppMobile.setLocale(context, Locale(langCode));
      clearLanguage();
      _localData.deleteDB();
      _repositoryComponents.setDashBoardInitialPage(context);
      // _repositoryComponents.setDashBoardInitialPage(context);

      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      Utils.toast(AppLocalizations.of(context)!.logoutNoInternetMessage);
    }
  }

  Future<void> updateProfileWeb(String fName, String lName, String address,
      double lat, double long, String password, String newPassword,
      {Uint8List? img}) async {
    await update(fName, lName, address, lat, long, password, newPassword);
    if (img != null) {
      final multipartFile =
          dio.MultipartFile.fromBytes(img, filename: 'filename');
      final formData = dio.FormData.fromMap({'profile_image': multipartFile});
      final response = await dio.Dio().post(NetworkUrls.updateProfileImage,
          data: formData, options: Options(headers: _webService.headers));
      UserModel oldUser = user.value;
      UserModel responseBody = UserModel.fromJson(response.data);
      if (responseBody.success == true) {
        oldUser.data!.profileImage = responseBody.data!.profileImage;
        user.value = oldUser;
        _storage.setString(DataBase.userData, convert.jsonEncode(oldUser));
        notifyListeners();
      } else {
        _navigationService
            .animatedDialog(AlertDialogMessage(responseBody.message!));
      }

      Utils.toast(response.statusMessage!);

      w.window.location.reload();
    }
  }

  Future update(
    String fName,
    String lName,
    String address,
    double lat,
    double long,
    String password,
    String newPassword,
  ) async {
    UserModel oldUser = user.value;
    Map<String, String> body;
    debugPrint('api call');
    if (password.isEmpty || newPassword.isEmpty) {
      body = {
        'first_name': fName,
        'last_name': lName,
        'address': address,
        'latitude': lat.toString(),
        'longitude': long.toString(),
      };
    } else {
      body = {
        'first_name': fName,
        'last_name': lName,
        'address': address,
        'latitude': lat.toString(),
        'longitude': long.toString(),
        'old_password': password,
        'new_password': newPassword
      };
    }

    final response =
        await _webService.postRequest(NetworkUrls.updateProfile, body);

    UserModel responseBody = UserModel.fromJson(jsonDecode(response.body));
    if (responseBody.success == true) {
      oldUser.data!.firstName = responseBody.data!.firstName;
      oldUser.data!.lastName = responseBody.data!.lastName;
      oldUser.data!.name = responseBody.data!.name;
      oldUser.data!.address = responseBody.data!.address;
      oldUser.data!.longitude = responseBody.data!.longitude;
      oldUser.data!.latitude = responseBody.data!.latitude;

      user.value = oldUser;

      _storage.setString(DataBase.userData, convert.jsonEncode(oldUser));
      Utils.toast(responseBody.message!, isBottom: true, isSuccess: true);
      notifyListeners();
    } else {
      _navigationService
          .animatedDialog(AlertDialogMessage(responseBody.message!));
    }
  }

  Future updateLanguage(String lang) async {
    UserModel oldUser = user.value;
    Map<String, String> body;
    debugPrint('api call');
    body = {
      'first_name': user.value.data!.firstName!,
      'last_name': user.value.data!.lastName!,
      'address': user.value.data!.address!,
      'latitude': user.value.data!.latitude!.isEmpty
          ? '0.0'
          : user.value.data!.latitude!,
      'longitude': user.value.data!.longitude!.isEmpty
          ? '0.0'
          : user.value.data!.longitude!,
      'language_code': lang
    };

    final response =
        await _webService.postRequest(NetworkUrls.updateProfile, body);
    debugPrint('responseresponse');
    debugPrint(body.toString());
    debugPrint(response.body);

    UserModel responseBody = UserModel.fromJson(jsonDecode(response.body));
    if (responseBody.success == true) {
      oldUser.data!.languageCode = responseBody.data!.languageCode;

      user.value = oldUser;

      _storage.setString(DataBase.userData, convert.jsonEncode(oldUser));
      _storage.setString(
          DataBase.userLanguage, responseBody.data!.languageCode);
      getLanguage();
      Utils.toast(responseBody.message!, isSuccess: true);
      notifyListeners();
    } else {
      _navigationService
          .animatedDialog(AlertDialogMessage(responseBody.message!));
    }
  }

  Future uploadImage(String img) async {
    var response = await _webService.sendImage(
        NetworkUrls.updateProfileImage, 'profile_image', img);
    UserModel oldUser = user.value;
    UserModel responseBody =
        UserModel.fromJson(convert.jsonDecode(response.body));
    if (responseBody.success == true) {
      oldUser.data!.profileImage = responseBody.data!.profileImage;
      user.value = oldUser;
      _storage.setString(DataBase.userData, convert.jsonEncode(oldUser));
      notifyListeners();
    } else {
      _navigationService
          .animatedDialog(AlertDialogMessage(responseBody.message!));
    }
  }

  checkLockForResume() async {
    String token = _storage.getString(DataBase.userToken);
    if (token.isNotEmpty) {
      int storedTime = (prefs.getInt(DataBase.lastActiveTime) ?? 0);
      int nowTime = DateTime.now().millisecondsSinceEpoch;
      if (storedTime != 0) {
        if (nowTime - storedTime > SpecialKeys.lockTiming) {
          await _storage.setBool(DataBase.accountStatus, true);
          _navigationService.pushReplacementNamed(Routes.lockScreenView);
        }
      }
    } else {
      Utils.fPrint("no user");
    }
  }

  Future<bool> unlockProfile(context, {String? password, isBio = false}) async {
    if (isBio) {
      await _storage.setInt(
          DataBase.lastActiveTime, DateTime.now().millisecondsSinceEpoch);
      await _storage.setBool(DataBase.accountStatus, false);
      return true;
    } else {
      ResponseMessageModel? response = await verifyPin(password!);

      if (response != null) {
        if (response.success!) {
          await _storage.setInt(
              DataBase.lastActiveTime, DateTime.now().millisecondsSinceEpoch);
          await _storage.setBool(DataBase.accountStatus, false);
          return true;
        }
      }
      return false;
      // String sfData = ''; // _storage.getString(DataBase.unlockPin);

      // if (sfData.isEmpty) {
      //   bool confirm = (await _navigationService.animatedDialog(
      //           const BoolReturnAlertDialog(
      //               "You are facing password issue, \nWanted logout")) ??
      //       false);
      //   if (confirm) {
      //     await logout(context);
      //   }
      //   return false;
      // } else {
      //   // final responseData = jsonDecode(sfData);
      //   if (password == sfData) {
      //     await Future.delayed(const Duration(seconds: 2));
      //     await _storage.setInt(
      //         DataBase.lastActiveTime, DateTime.now().millisecondsSinceEpoch);
      //     await _storage.setBool(DataBase.accountStatus, false);
      //     return true;
      //   } else {
      //     bool confirm = (await _navigationService.animatedDialog(
      //             const BoolReturnAlertDialog(
      //                 "Wrong password, do you forgot your account, wanted logout")) ??
      //         false);
      //     if (confirm) {
      //       await logout(context);
      //     }
      //     await Future.delayed(const Duration(seconds: 2));
      //     return false;
      //   }
      // }
    }
  }

  Future<ResponseMessageModel?> changePin(body) async {
    bool connection = await checkConnectivity();
    if (connection) {
      http.Response response =
          await _webService.postRequest(NetworkUrls.changeMobileAppPin, body);
      ResponseMessageModel res =
          ResponseMessageModel.fromJson(jsonDecode(response.body));
      return res;
    }
    return null;
  }

  Future<ResponseMessageModel?> setPin(String pin) async {
    bool connection = await checkConnectivity();
    if (connection) {
      http.Response response = await _webService.postRequest(
          NetworkUrls.setMobileAppPin, {"app_pin": pin, "confirm_pin": pin});
      debugPrint(response.body);
      debugPrint('response.body');
      debugPrint(response.body);
      ResponseMessageModel res =
          ResponseMessageModel.fromJson(jsonDecode(response.body));
      if (res.success!) {
        UserModel u = user.value;
        u.data!.isPinSet = true;
        _storage.setString(DataBase.userData, jsonEncode(u));
      }
      return res;
    }
    return null;
  }

  Future<ResponseMessageModel?> verifyPin(String pin) async {
    bool connection = await checkConnectivity();
    if (connection) {
      http.Response response = await _webService
          .postRequest(NetworkUrls.verifyMobileAppPin, {"app_pin": pin});
      debugPrint('responseresponse');
      debugPrint(response.body);
      ResponseMessageModel res =
          ResponseMessageModel.fromJson(jsonDecode(response.body));

      return res;
    }
    return null;
  }
}
