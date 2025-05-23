import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/main.dart';
import 'package:bingo/presentation/widgets/buttons/cancel_button.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../app/locator.dart';
import '../../../../const/utils.dart';
import '../../../../data_models/models/response_message_model/response_message_model.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/storage/db.dart';
import '../../numeric_keypad.dart';
import '../../text_fields/pin_field.dart';

class UnlockSelectorScreen extends StatefulWidget {
  const UnlockSelectorScreen({Key? key, this.screen = 0}) : super(key: key);
  final int screen;
  @override
  State<UnlockSelectorScreen> createState() => _UnlockSelectorScreenState();
}

class _UnlockSelectorScreenState extends State<UnlockSelectorScreen> {
  @override
  void initState() {
    canTestBio();
    screenNumber = widget.screen;
    textEditingFocusNode = List.generate(6, (i) => FocusNode());
    textEditingControllers = List.generate(6, (i) => TextEditingController());
    textEditingFocusNodeConfirm = List.generate(6, (i) => FocusNode());
    textEditingControllersConfirm =
        List.generate(6, (i) => TextEditingController());
    setState(() {
      isKeyboardOpen = false;
    });
    super.initState();
  }

  List<TextEditingController> textEditingControllers = [];
  List<TextEditingController> textEditingControllersConfirm = [];
  List<FocusNode> textEditingFocusNode = [];
  List<FocusNode> textEditingFocusNodeConfirm = [];
  bool inPin = false;
  bool showPinNew = true;
  bool showPinConfirm = true;

  String pinError = "";
  String pinConfirmError = "";
  bool isBusy = false;
  bool hasBio = false;
  String pin = "";
  String pinConfirm = "";
  int pinSingleValue = 0;
  int pinSingleValueConfirm = 0;
  bool isKeyboardOpen = false;
  int screenNumber = 0;
  var auth = locator<AuthService>();
  // List<TextEditingController> textEditingControllers =
  //     List.generate(6, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isKeyboardOpen = false;
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: AlertDialog(
                    // shadowColor: AppColors.whiteColor,
                    surfaceTintColor: AppColors.whiteColor,
                    backgroundColor: AppColors.whiteColor,
                    title: Text(
                      screenNumber == 0
                          ? AppLocalizations.of(context)!.enterPin
                          : AppLocalizations.of(context)!.bioSelectionBody,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.salesScannerDialog.copyWith(
                          fontSize: 14,
                          fontWeight: AppFontWeighs.semiBold,
                          color: AppColors.blackColor),
                    ),
                    content: screenNumber == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Image.asset(
                                  AppAsset.pin,
                                  height: 100,
                                ),
                              ),
                              20.0.giveHeight,
                              CommonText(
                                AppLocalizations.of(context)!.pin.isRequired,
                              ),
                              10.0.giveHeight,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isKeyboardOpen = true;
                                  });
                                },
                                child: PinField(
                                  showPin: showPinNew,
                                  keyboardActive: (bool v) {
                                    setState(() {
                                      isKeyboardOpen = v;
                                    });
                                  },
                                  itemNumber: (int v) {
                                    textEditingFocusNode[v].requestFocus();
                                    setState(() {});
                                  },
                                  controller: textEditingControllers,
                                  focuses: textEditingFocusNode,
                                  pinV: pinSingleValue,
                                  fieldNumber: 6,
                                  onCompleted: (String value) {
                                    pin = value;

                                    setState(() {});
                                  },
                                ),
                              ),
                              Text(
                                pinError,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.errorTextStyle,
                              ),
                              20.0.giveHeight,
                              CommonText(
                                AppLocalizations.of(context)!
                                    .pinRetype
                                    .isRequired,
                              ),
                              10.0.giveHeight,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isKeyboardOpen = true;
                                  });
                                },
                                child: PinField(
                                  showPin: showPinConfirm,
                                  keyboardActive: (bool v) {
                                    setState(() {
                                      isKeyboardOpen = v;
                                    });
                                  },
                                  itemNumber: (int v) {
                                    textEditingFocusNodeConfirm[v]
                                        .requestFocus();
                                    setState(() {});
                                  },
                                  controller: textEditingControllersConfirm,
                                  focuses: textEditingFocusNodeConfirm,
                                  pinV: pinSingleValueConfirm,
                                  fieldNumber: 6,
                                  onCompleted: (String value) {
                                    pinConfirm = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              Text(
                                pinConfirmError,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.errorTextStyle,
                              ),
                              10.0.giveHeight,
                              // if (pin.length == 6)
                              if (pin != pinConfirm)
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.pinNotMatch,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.errorTextStyle,
                                  ),
                                ),
                              Center(
                                child: isBusy
                                    ? Utils.loaderBusy()
                                    : SubmitButton(
                                        onPressed: () {
                                          savePin(context);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .submitButton,
                                      ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Image.asset(
                                  AppAsset.bio,
                                  height: 100,
                                ),
                              ),
                              20.0.giveHeight,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: SubmitButton(
                                      active: hasBio,
                                      width: 100.0,
                                      onPressed: () {
                                        if (hasBio) {
                                          setBio();
                                        }
                                      },
                                      text:
                                          AppLocalizations.of(context)!.enable,
                                    ),
                                  ),
                                  Center(
                                    child: CancelButton(
                                      width: 100.0,
                                      onPressed: () {
                                        setPin();
                                      },
                                      text: AppLocalizations.of(context)!.skip,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            if (isKeyboardOpen == true)
              SizedBox(
                height: 220,
                child: Column(
                  children: [
                    Expanded(
                      child: NumericKeyPad(
                        onInputNumber: (int value) {
                          if (textEditingFocusNode
                              .any((element) => element.hasFocus)) {
                            int i = textEditingFocusNode
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingControllers[i].text.isEmpty) {
                              textEditingControllers[i].text = value.toString();
                              debugPrint(textEditingControllers[i].text);
                              textEditingFocusNode[i].nextFocus();
                            } else {
                              textEditingFocusNode[i].unfocus();
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
                          if (textEditingControllers
                                  .every((e) => e.text.isNotEmpty) &&
                              textEditingControllersConfirm
                                  .every((e) => e.text.isNotEmpty)) {
                            isKeyboardOpen = false;
                            setState(() {});
                          }

                          setState(() {});
                        },
                        onClearLastInput: () {
                          if (textEditingFocusNode
                              .any((element) => element.hasFocus)) {
                            debugPrint('element.hasFocusq');
                            int i = textEditingFocusNode
                                .indexWhere((element) => element.hasFocus);
                            if (textEditingFocusNode
                                .any((element) => element.hasFocus)) {
                              if (textEditingControllers[i].text.isNotEmpty) {
                                textEditingControllers[i].clear();
                              } else {
                                if (i != 0) {
                                  textEditingControllers[i - 1].clear();
                                  textEditingFocusNode[i].previousFocus();
                                }
                              }
                            }
                          } else {
                            debugPrint('element.hasFocus');
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
                          if (textEditingFocusNode
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

  clearFormRows() {
    if (textEditingFocusNode.any((element) => element.hasFocus)) {
      for (int i = 0; i < textEditingControllers.length; i++) {
        textEditingControllers[i].clear();
        textEditingFocusNode[0].requestFocus();
      }
    }

    if (textEditingFocusNodeConfirm.any((element) => element.hasFocus)) {
      for (int i = 0; i < textEditingControllersConfirm.length; i++) {
        textEditingControllersConfirm[i].clear();
        textEditingFocusNodeConfirm[0].requestFocus();
      }
    }
  }

  savePin(BuildContext context) async {
    setState(() {
      isBusy = true;
    });

    if (textEditingControllersConfirm.any((e) => e.text.isEmpty) ||
        textEditingControllers.any((e) => e.text.isEmpty)) {
      if (textEditingControllersConfirm.any((e) => e.text.isEmpty)) {
        pinConfirmError = AppLocalizations.of(context)!.pinNotSelectionError;
      } else {
        pinConfirmError = "";
      }
      if (textEditingControllers.any((e) => e.text.isEmpty)) {
        pinError = AppLocalizations.of(context)!.pinNotSelectionError;
      } else {
        pinError = "";
      }
    } else {
      List<String> data =
          List.generate(6, (i) => textEditingControllers[i].text);
      List<String> dataConfirm =
          List.generate(6, (i) => textEditingControllersConfirm[i].text);
      pin = data.join();
      pinConfirm = dataConfirm.join();
      pinError = "";
      pinConfirmError = "";
    }

    if (pinConfirmError.isEmpty && pinError.isEmpty) {
      if (pin == pinConfirm) {
        ResponseMessageModel? response = await auth.setPin(pin);
        if (response != null) {
          Utils.toast(response.message!, isSuccess: response.success!);
        }

        ///local storage
        // await prefs.setString(DataBase.unlockPin, pin);
        await prefs.setInt(DataBase.unlockTypeBio, 0);

        ///local storage
        screenNumber = 1;
        isKeyboardOpen = false;
      }
      // await prefs.setString(DataBase.unlockPin, pin);
      // await prefs.setInt(DataBase.unlockTypeBio, selectedOption);
      // if (context.mounted) {
      //   Navigator.pop(context, true);
      // }
    }
    setState(() {
      isBusy = false;
    });
  }

  setBio() async {
    await prefs.setInt(DataBase.unlockTypeBio, 1);
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  setPin() async {
    await prefs.setInt(DataBase.unlockTypeBio, 0);
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  button(
      {required Widget child,
      required bool isTrue,
      bool active = true,
      required bool selected}) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: active
                  ? Border.all(
                      width: isTrue ? 2 : 0,
                      color: AppColors.accentColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(50),
              color: active
                  ? AppColors.activeButtonColor
                  : AppColors.inactiveButtonColor),
          child: child,
        ),
        if (selected)
          Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: active
                    ? AppColors.selectedButton
                    : AppColors.inactiveButtonColor),
            child: const Center(
              child: Icon(
                Icons.check,
                size: 80,
                color: AppColors.whiteColor,
              ),
            ),
          ),
      ],
    );
  }

  void canTestBio() async {
    setState(() {
      hasBio = false;
      isBusy = true;
    });
    final LocalAuthentication auth = LocalAuthentication();
    List canAuthenticateWithBiometrics = await auth.getAvailableBiometrics();
    setState(() {
      hasBio = canAuthenticateWithBiometrics.isNotEmpty;
      isBusy = false;
    });
    if (!hasBio) {
      // selectedOption = 2;
      setState(() {});
    } else {
      // selectedOption = 0;
      setState(() {});
    }
  }
}
