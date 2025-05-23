import 'package:bingo/presentation/widgets/text/common_text.dart';

import '../../widgets/numeric_keypad.dart';
import '../../widgets/text_fields/pin_field.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../widgets/buttons/submit_button.dart';
import 'lock_screen_view_model.dart';

class LockScreenView extends StatelessWidget {
  const LockScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LockScreenViewModel>.reactive(
        viewModelBuilder: () => LockScreenViewModel(),
        onViewModelReady: (LockScreenViewModel model) {
          model.startBio(context);
        },
        builder: (context, model, child) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                model.changeKeyboard(false);
              },
              child: !model.isBioSwitch
                  ? Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppLocalizations.of(context)!
                                      .pinLockHeader),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding:
                                                AppPaddings.loginScreenMainCard,
                                            child: Card(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0,
                                                ),
                                                // width: 280.0,
                                                decoration: AppBoxDecoration
                                                    .loginScreenCardDecoration,
                                                child: Form(
                                                  key: model.formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(AppLocalizations.of(
                                                              context)!
                                                          .bioFailedError),
                                                      Text(AppLocalizations.of(
                                                              context)!
                                                          .putPinToUnlock),
                                                      15.0.giveHeight,
                                                      SizedBox(
                                                        width: 222,
                                                        height: 73,
                                                        child: Image.asset(
                                                          AppAsset.loginLogo,
                                                        ),
                                                      ),
                                                      15.0.giveHeight,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CommonText(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .pin
                                                                .isRequired,
                                                            style: AppTextStyles
                                                                .formTitleTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .blackColor),
                                                          ),
                                                          10.0.giveHeight,
                                                          GestureDetector(
                                                            onTap: () {
                                                              model
                                                                  .changeKeyboard(
                                                                      true);
                                                            },
                                                            child: PinField(
                                                              showPin:
                                                                  model.showPin,
                                                              keyboardActive:
                                                                  (bool v) {
                                                                model
                                                                    .changeKeyboard(
                                                                        v);
                                                              },
                                                              itemNumber:
                                                                  (int v) {
                                                                print(v);
                                                                model
                                                                    .requestFocus(
                                                                        v);
                                                              },
                                                              pinV: model
                                                                  .pinSingleValue,
                                                              controller: model
                                                                  .textEditingControllers,
                                                              focuses: model
                                                                  .textEditingFocusNode,
                                                              fieldNumber: 6,
                                                              onCompleted:
                                                                  (String
                                                                      value) {},
                                                            ),
                                                          ),
                                                          if (model
                                                              .passwordError
                                                              .isNotEmpty)
                                                            Text(
                                                              model
                                                                  .passwordError,
                                                              style: AppTextStyles
                                                                  .errorTextStyle,
                                                            ),
                                                        ],
                                                      ),
                                                      20.0.giveHeight,
                                                      model.isLoginAttempt
                                                          ? const SizedBox(
                                                              height: 20.0,
                                                              width: 20.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: AppColors
                                                                    .loader1,
                                                              ),
                                                            )
                                                          : SubmitButton(
                                                              height: 45.0,
                                                              onPressed: () {
                                                                model.unlockProfile(
                                                                    context);
                                                              },
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .login
                                                                  .toUpperCase(),
                                                            ),
                                                      20.0.giveHeight,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (model.isKeyboardOpen == true)
                          SizedBox(
                            height: 220,
                            child: Column(
                              children: [
                                Expanded(
                                  child: NumericKeyPad(
                                    show: model.show,
                                    onInputNumber: (int value) {
                                      model.onInputNumber(value);
                                    },
                                    onClearLastInput: model.onClearLastInput,
                                    onClearAll: () {},
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        // if (model.isKeyboardOpen == true)
                        //   SizedBox(
                        //     height: 200,
                        //     child: NumericKeyPad(
                        //       onInputNumber: (int value) {
                        //         model.onInputNumber(value);
                        //       },
                        //       onClearLastInput: model.onClearLastInput,
                        //       onClearAll: () {},
                        //     ),
                        //   )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(AppLocalizations.of(context)!
                              .bioMetricLockMessage)),
                    ),
            ),
          );
        });
  }
}
