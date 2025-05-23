import 'dart:async';
import '../../../services/storage/db.dart';
import '../../../services/storage/device_storage.dart';
import '/app/locator.dart';
import '/const/utils.dart';
import '/services/auth_service/auth_service.dart';
import '/services/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../main.dart';
import '../../../services/bio_metric/bio_metric.dart';

class LockScreenViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ZDeviceStorage _storage = locator<ZDeviceStorage>();

  String _passwordError = "";
  int pinSingleValue = 0;

  TextEditingController passwordController = TextEditingController(text: "");
  List<FocusNode> textEditingFocusNode = List.generate(6, (i) => FocusNode());
  List<TextEditingController> textEditingControllers =
      List.generate(6, (i) => TextEditingController());
  bool canBioMetric = false;
  int trialCount = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  bool isVisible = false;
  bool isLoginAttempt = false;

  bool isKeyboardOpen = false;

  String get passwordError => _passwordError;
  bool isPasswordValidate = false;
  bool isBioSwitch = true;
  bool showPin = true;
  show() {
    showPin = !showPin;
    notifyListeners();
  }

  Future startBio(context) async {
    int unlockType = _storage.getInt(DataBase.unlockTypeBio);
    if (unlockType == 1) {
      isBioSwitch = true;
      notifyListeners();

      canBioMetric = await BioMetric.getAvailableBiometrics();
      if (canBioMetric) {
        isBioSwitch = await BioMetric.startBio();
        if (isBioSwitch) {
          await unlockProfileVerify(context, true);
        }
        notifyListeners();
      }
    } else {
      isBioSwitch = false;
      notifyListeners();
    }
  }

  String pin = "";

  bool? checkPassword(BuildContext context) {
    if (textEditingControllers.any((e) => e.text.isEmpty)) {
      _passwordError = AppLocalizations.of(context)!.pinNotSelectionError;
      return false;
    } else {
      List<String> data =
          List.generate(6, (i) => textEditingControllers[i].text);
      // textEditingControllers.map((e) => data.add(e.text));
      pin = data.join();
      _passwordError = "";
      return true;
    }
  }

  void makeBusy(bool v) {
    isLoginAttempt = v;
    notifyListeners();
  }

  void changeVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void unlockProfile(BuildContext context) async {
    bool validPassword = checkPassword(context) ?? false;

    if (validPassword) {
      print('isBioisBio');
      await unlockProfileVerify(context, false);
    }
  }

  Future<void> unlockProfileVerify(context, bool isBio) async {
    makeBusy(true);
    bool unLockProfile = await _authService.unlockProfile(context,
        password: isBio
            ? null
            : pin, //Utils.getEncryptedData(passwordController.text),
        isBio: isBio);
    // Utils.toast(unLockProfile.toString());
    if (unLockProfile) {
      Utils.toast(
        "Unlocking success",
        isSuccess: true,
        isBottom: true,
      );
      _navigationService.pushReplacementNamed(Routes.startupView);
      makeBusy(false);
    } else {
      Utils.toast(
        "Unlocking failed",
        isSuccess: false,
        isBottom: true,
      );
      passwordController.clear();
      trialCount += 1;
      if (trialCount >= 5) {
        await _authService.logout(context);
      }
      makeBusy(false);
    }
  }

  // void setPin(String value) {
  //   print(value);
  //   passwordController.text = value;
  //   notifyListeners();
  // }

  void requestFocus(int v) {
    textEditingFocusNode[v].requestFocus();
    notifyListeners();
  }

  void onInputNumber(int value) {
    if (textEditingFocusNode.any((element) => element.hasFocus)) {
      int i = textEditingFocusNode.indexWhere((element) => element.hasFocus);
      if (textEditingControllers[i].text.isEmpty) {
        textEditingControllers[i].text = value.toString();
        textEditingFocusNode[i].nextFocus();
      } else {
        textEditingFocusNode[i].unfocus();
      }
    }

    notifyListeners();
  }

  void onClearLastInput() {
    int i = textEditingFocusNode.indexWhere((element) => element.hasFocus);
    if (textEditingFocusNode.any((element) => element.hasFocus)) {
      if (textEditingControllers[i].text.isNotEmpty) {
        textEditingControllers[i].clear();
      } else {
        if (i != 0) {
          textEditingControllers[i - 1].clear();
          textEditingFocusNode[i].previousFocus();
        }
      }
    }
    notifyListeners();
  }

  changeKeyboard(bool v) {
    isKeyboardOpen = v;
    notifyListeners();
  }

  getItemNumber(int v) {
    textEditingFocusNode[v].requestFocus();
    notifyListeners();
  }
}
