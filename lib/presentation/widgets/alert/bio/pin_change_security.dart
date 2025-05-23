import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/locator.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../main.dart';
import '../../../../services/storage/db.dart';
import '../../buttons/submit_button.dart';
import '../../cards/app_bar_text.dart';
import '../../cards/shadow_card.dart';
import '../../numeric_keypad.dart';
import '../../text/common_text.dart';
import '../../text_fields/pin_field.dart';

class PinChangeSecurityView extends StatefulWidget {
  const PinChangeSecurityView({Key? key}) : super(key: key);

  @override
  State<PinChangeSecurityView> createState() => _PinChangeSecurityViewState();
}

class _PinChangeSecurityViewState extends State<PinChangeSecurityView> {
  List<TextEditingController> textEditingControllersOld = [];
  List<FocusNode> textEditingFocusNodeOld = [];
  List<TextEditingController> textEditingControllersNew = [];
  List<FocusNode> textEditingFocusNodeNew = [];
  List<TextEditingController> textEditingControllersConfirm = [];
  List<FocusNode> textEditingFocusNodeConfirm = [];
  int pinSingleValueOld = 0;
  int pinSingleValueNew = 0;
  int pinSingleValueConfirm = 0;
  String pinOldError = "";
  String pinNewError = "";
  String pinConfirmError = "";
  String pinOld = "";
  String pinNew = "";
  String pinConfirm = "";
  bool isButtonBusy = false;
  bool showPinOld = true;
  bool showPinNew = true;
  bool showPinConfirm = true;
  bool isKeyboardOpen = false;

  // bool isRetailer = false;

  UserTypeForWeb enrollment = UserTypeForWeb.wholesaler;

  @override
  void initState() {
    textEditingFocusNodeOld = List.generate(6, (i) => FocusNode());
    textEditingControllersOld =
        List.generate(6, (i) => TextEditingController());
    textEditingFocusNodeNew = List.generate(6, (i) => FocusNode());
    textEditingControllersNew =
        List.generate(6, (i) => TextEditingController());
    textEditingFocusNodeConfirm = List.generate(6, (i) => FocusNode());
    textEditingControllersConfirm =
        List.generate(6, (i) => TextEditingController());
    // isRetailer = locator<AuthService>().isRetailer.value;
    enrollment = locator<AuthService>().enrollment.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isKeyboardOpen = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            SizedBox(
              width: 15.0,
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
            ),
          ),
          title: AppBarText(AppLocalizations.of(context)!.security),
          backgroundColor: enrollment == UserTypeForWeb.retailer
              ? AppColors.appBarColorRetailer
              : AppColors.appBarColorWholesaler,
        ),
        body: Column(
          children: [
            ShadowCard(
              // isChild: true,
              child: SizedBox(
                width: 100.0.wp,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pinField(
                        AppLocalizations.of(context)!.currentPin,
                        textEditingControllersOld,
                        textEditingFocusNodeOld,
                        pinSingleValueOld,
                        pinOldError,
                        showPinOld),
                    pinField(
                        AppLocalizations.of(context)!.newPin,
                        textEditingControllersNew,
                        textEditingFocusNodeNew,
                        pinSingleValueNew,
                        pinNewError,
                        showPinNew),
                    pinField(
                        AppLocalizations.of(context)!.confirmNewPin,
                        textEditingControllersConfirm,
                        textEditingFocusNodeConfirm,
                        pinSingleValueConfirm,
                        pinConfirmError,
                        showPinConfirm),
                    20.0.giveHeight,
                    isButtonBusy
                        ? SizedBox(
                            width: 100.0.wp,
                            height: 45.0,
                            child: Center(
                              child: Utils.loaderBusy(),
                            ),
                          )
                        : Center(
                            child: SubmitButton(
                              onPressed: () {
                                savePin(context);
                              },
                              text: AppLocalizations.of(context)!.pinChange,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            if (isKeyboardOpen)
              SizedBox(
                height: 220,
                child: Column(
                  children: [
                    Expanded(
                      child: NumericKeyPad(
                        onInputNumber: (int value) {
                          if (textEditingFocusNodeOld
                              .any((element) => element.hasFocus)) {
                            int i = textEditingFocusNodeOld
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingControllersOld[i].text.isEmpty) {
                              textEditingControllersOld[i].text =
                                  value.toString();
                              debugPrint(textEditingControllersOld[i].text);
                              textEditingFocusNodeOld[i].nextFocus();
                            } else {
                              textEditingFocusNodeOld[i].unfocus();
                            }
                          }
                          if (textEditingFocusNodeNew
                              .any((element) => element.hasFocus)) {
                            int i = textEditingFocusNodeNew
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingControllersNew[i].text.isEmpty) {
                              textEditingControllersNew[i].text =
                                  value.toString();
                              debugPrint(textEditingControllersNew[i].text);
                              textEditingFocusNodeNew[i].nextFocus();
                            } else {
                              textEditingFocusNodeNew[i].unfocus();
                            }
                          }
                          if (textEditingFocusNodeConfirm
                              .any((element) => element.hasFocus)) {
                            int i = textEditingFocusNodeConfirm
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingControllersConfirm[i].text.isEmpty) {
                              debugPrint(textEditingControllersConfirm[i].text);
                              textEditingControllersConfirm[i].text =
                                  value.toString();
                              textEditingFocusNodeConfirm[i].nextFocus();
                            } else {
                              textEditingFocusNodeConfirm[i].unfocus();
                            }
                          }
                          if (textEditingControllersOld
                                  .every((e) => e.text.isNotEmpty) &&
                              textEditingControllersNew
                                  .every((e) => e.text.isNotEmpty) &&
                              textEditingControllersConfirm
                                  .every((e) => e.text.isNotEmpty)) {
                            isKeyboardOpen = false;
                            setState(() {});
                          }

                          setState(() {});
                        },
                        onClearLastInput: () {
                          if (textEditingFocusNodeOld
                              .any((element) => element.hasFocus)) {
                            int i = textEditingFocusNodeOld
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingFocusNodeOld
                                .any((element) => element.hasFocus)) {
                              if (textEditingControllersOld[i]
                                  .text
                                  .isNotEmpty) {
                                textEditingControllersOld[i].clear();
                              } else {
                                if (i != 0) {
                                  textEditingControllersOld[i - 1].clear();
                                  textEditingFocusNodeOld[i].previousFocus();
                                }
                              }
                            }
                          } else if (textEditingFocusNodeNew
                              .any((element) => element.hasFocus)) {
                            int i = textEditingFocusNodeNew
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingFocusNodeNew
                                .any((element) => element.hasFocus)) {
                              if (textEditingControllersNew[i]
                                  .text
                                  .isNotEmpty) {
                                textEditingControllersNew[i].clear();
                              } else {
                                if (i != 0) {
                                  textEditingControllersNew[i - 1].clear();
                                  textEditingFocusNodeNew[i].previousFocus();
                                }
                              }
                            }
                          } else {
                            int i = textEditingFocusNodeConfirm
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingFocusNodeConfirm
                                .any((element) => element.hasFocus)) {
                              if (textEditingControllersConfirm[i]
                                  .text
                                  .isNotEmpty) {
                                textEditingControllersConfirm[i].clear();
                              } else {
                                if (i != 0) {
                                  textEditingControllersConfirm[i - 1].clear();
                                  textEditingFocusNodeConfirm[i]
                                      .previousFocus();
                                }
                              }
                            }
                          }
                        },
                        onClearAll: clearFormRows,
                        show: () {
                          if (textEditingFocusNodeOld
                              .any((element) => element.hasFocus)) {
                            showPinOld = !showPinOld;
                          }
                          if (textEditingFocusNodeNew
                              .any((element) => element.hasFocus)) {
                            showPinNew = !showPinNew;
                          }
                          if (textEditingFocusNodeConfirm
                              .any((element) => element.hasFocus)) {
                            showPinConfirm = !showPinConfirm;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Column pinField(
      String title,
      List<TextEditingController> textEditingController,
      List<FocusNode> textEditingFocusNodes,
      int pinValue,
      String errorMessage,
      bool showPin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        20.0.giveHeight,
        CommonText(
          title.isRequired,
          style: AppTextStyles.salesScannerDialog,
        ),
        10.0.giveHeight,
        GestureDetector(
          onTap: () {
            setState(() {
              isKeyboardOpen = true;
            });
          },
          child: PinField(
            showPin: showPin,
            keyboardActive: (bool v) {
              setState(() {
                isKeyboardOpen = v;
              });
            },
            itemNumber: (int v) {
              textEditingFocusNodes[v].requestFocus();
            },
            controller: textEditingController,
            focuses: textEditingFocusNodes,
            pinV: pinValue,
            fieldNumber: 6,
            onCompleted: (String value) {},
          ),
        ),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: AppTextStyles.errorTextStyle,
        ),
      ],
    );
  }

  savePin(BuildContext context) async {
    if (textEditingControllersOld.any((e) => e.text.isEmpty) ||
        textEditingControllersNew.any((e) => e.text.isEmpty) ||
        textEditingControllersConfirm.any((e) => e.text.isEmpty)) {
      if (textEditingControllersOld.any((e) => e.text.isEmpty)) {
        pinOldError = AppLocalizations.of(context)!.pinNotSelectionError;
      } else {
        pinOldError = "";
      }
      if (textEditingControllersNew.any((e) => e.text.isEmpty)) {
        pinNewError = AppLocalizations.of(context)!.pinNotSelectionError;
      } else {
        pinNewError = "";
      }
      if (textEditingControllersConfirm.any((e) => e.text.isEmpty)) {
        pinConfirmError = AppLocalizations.of(context)!.pinNotSelectionError;
      } else {
        pinConfirmError = "";
      }
    } else {
      List<String> dataOld =
          List.generate(6, (i) => textEditingControllersOld[i].text);
      List<String> dataNew =
          List.generate(6, (i) => textEditingControllersNew[i].text);
      List<String> dataConfirm =
          List.generate(6, (i) => textEditingControllersConfirm[i].text);
      pinOld = dataOld.join();
      pinNew = dataNew.join();
      pinConfirm = dataConfirm.join();
      pinOldError = "";
      pinNewError = "";
      pinConfirmError = "";
    }
    // String getOldPin = prefs.getString(DataBase.unlockPin) ?? '';
    // debugPrint('getOldPin');
    // debugPrint(getOldPin);
    if (pinOldError.isEmpty && pinNewError.isEmpty && pinConfirmError.isEmpty) {
      // if (getOldPin.isNotEmpty) {

      var pins = {
        "old_pin": pinOld,
        "new_pin": pinNew,
        "confirm_pin": pinConfirm
      };
      Navigator.pop(context, pins);

      ///comment out to move this setting local to api based
      ///local changes
      // if (getOldPin == pinOld) {
      //   if (pinOld == pinNew) {
      //     pinConfirmError = AppLocalizations.of(context)!.needDifferentPin;
      //     setState(() {});
      //   } else if (pinNew == pinConfirm) {
      //     setState(() {
      //       isButtonBusy = true;
      //     });
      //
      //
      //     // await prefs.setString(DataBase.unlockPin, pinNew);
      //     // await Future.delayed(const Duration(seconds: 2));
      //
      //     isKeyboardOpen = false;
      //     pinConfirmError = "";
      //     clearForm();
      //     setState(() {
      //       isButtonBusy = false;
      //     });
      //     if (context.mounted) {
      //       Utils.toast(
      //         AppLocalizations.of(context)!.pinChangeSuccess,
      //         isSuccess: true,
      //       );
      //       Navigator.pop(context);
      //       setState(() {
      //         isKeyboardOpen = false;
      //       });
      //     }
      //   } else {
      //     pinConfirmError = AppLocalizations.of(context)!.pinNotMatchWithNew;
      //   }
      //   pinOldError = "";
      // } else {
      //   pinOldError = AppLocalizations.of(context)!.pinNotMatchWithOld;
      // }
      ///local changes
      // }
    }

    setState(() {});
  }

  clearFormRows() {
    if (textEditingFocusNodeNew.any((element) => element.hasFocus)) {
      for (int i = 0; i < textEditingControllersNew.length; i++) {
        textEditingControllersNew[i].clear();
        textEditingFocusNodeNew[0].requestFocus();
      }
    }
    if (textEditingFocusNodeOld.any((element) => element.hasFocus)) {
      for (int i = 0; i < textEditingControllersOld.length; i++) {
        textEditingControllersOld[i].clear();
        textEditingFocusNodeOld[0].requestFocus();
      }
    }
    if (textEditingFocusNodeConfirm.any((element) => element.hasFocus)) {
      for (int i = 0; i < textEditingControllersConfirm.length; i++) {
        textEditingControllersConfirm[i].clear();
        textEditingFocusNodeConfirm[0].requestFocus();
      }
    }
  }

  clearForm() {
    for (int i = 0; i < textEditingControllersConfirm.length; i++) {
      textEditingControllersOld[i].clear();
      textEditingControllersNew[i].clear();
      textEditingControllersConfirm[i].clear();
    }
  }
}
