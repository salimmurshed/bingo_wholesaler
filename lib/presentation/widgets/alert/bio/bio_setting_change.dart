import 'package:bingo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../const/all_const.dart';
import '../../../../services/storage/db.dart';
import '../../buttons/submit_button.dart';
import '../../numeric_keypad.dart';
import '../../text_fields/pin_field.dart';

class CheckBioAuth extends StatefulWidget {
  const CheckBioAuth({Key? key}) : super(key: key);

  @override
  State<CheckBioAuth> createState() => _CheckBioAuthState();
}

class _CheckBioAuthState extends State<CheckBioAuth> {
  List<TextEditingController> textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<FocusNode> textEditingFocusNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  String pinError = "";
  bool showPin = true;
  bool isKeyboardOpen = false;
  int pinSingleValue = 0;
  String pin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        backgroundColor: AppColors.whiteColor,
        title: Text(AppLocalizations.of(context)!.pinVerificationHead),
        content: Text(AppLocalizations.of(context)!.pinVerificationBody),
        // titlePadding: EdgeInsets.zero,
        // contentPadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.pin,
                textAlign: TextAlign.center,
                style: AppTextStyles.salesScannerDialog
                    .copyWith(fontWeight: FontWeight.bold),
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SubmitButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                color: AppColors.statusReject,
                text: AppLocalizations.of(context)!.cancelButton.toUpperCase(),
                width: 29.0.wp,
              ),
              SubmitButton(
                color: AppColors.statusVerified,
                onPressed: () {
                  List<String> data =
                      List.generate(6, (i) => textEditingControllers[i].text);
                  pin = data.join();
                  // String storedPin = prefs.getString(DataBase.unlockPin) ?? "";
                  if (pin.length < 6) {
                    pinError = AppLocalizations.of(context)!.fillAllField;
                    // } else if (storedPin != pin) {
                    //   pinError = AppLocalizations.of(context)!.pinNotMatch;
                  } else {
                    Navigator.pop(context, true);
                  }
                  setState(() {});
                },
                text: AppLocalizations.of(context)!.submitButton.toUpperCase(),
                width: 29.0.wp,
              ),
            ],
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 220,
        child: Column(
          children: [
            Expanded(
              child: NumericKeyPad(
                onInputNumber: (int value) {
                  if (textEditingFocusNode.any((element) => element.hasFocus)) {
                    int i = textEditingFocusNode
                        .indexWhere((element) => element.hasFocus);
                    if (textEditingControllers[i].text.isEmpty) {
                      textEditingControllers[i].text = value.toString();
                      debugPrint(textEditingControllers[i].text);
                      textEditingFocusNode[i].nextFocus();
                    } else {
                      isKeyboardOpen = false;
                      textEditingFocusNode[i].unfocus();
                    }
                  }
                  // if (textEditingControllers.every((e) => e.text.isNotEmpty)) {
                  //   isKeyboardOpen = false;
                  //   setState(() {});
                  // }

                  setState(() {});
                },
                onClearLastInput: () {
                  if (textEditingFocusNode.any((element) => element.hasFocus)) {
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
                  }
                },
                onClearAll: () {
                  for (int i = 0; i < 6; i++) {
                    textEditingControllers[i].clear();
                    setState(() {});
                  }
                  textEditingFocusNode[0].requestFocus();
                },
                show: () {
                  showPin = !showPin;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
