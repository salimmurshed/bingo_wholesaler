import 'package:flutter/services.dart';

import '../../../const/special_key.dart';
import '../../../main.dart';
import '../../../services/storage/db.dart';
import '../../../workable.dart';
import '../../widgets/checked_box.dart';
import '../../widgets/text/common_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/app_styles/app_box_decoration.dart';
import '/presentation/widgets/buttons/submit_button.dart';

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_secrets.dart';
import '../../../const/web_devices.dart';
import 'login_screen_view_model.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // prefs.remove(DataBase.unlockTypeBio);
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                SizedBox(
                  height: 100.0.hp,
                  width: 100.0.wp,
                  child: Image.asset(
                    kIsWeb
                        ? (kDebugMode
                            ? AppAsset.loginBackgroundWebDev
                            : AppAsset.loginBackgroundWeb)
                        : AppAsset.loginBg,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: SizedBox(
                    width: 40.0.wp,
                    child: TextButton(
                      onPressed: model.signUp,
                      child: Text(
                        AppLocalizations.of(context)!.createAccount,
                        style: AppTextStyles.addRequestTabBar,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: AppPaddings.loginScreenMainCard,
                      child: Card(
                        child: Container(
                          width: device == ScreenSize.small
                              ? 100.0.wp
                              : device == ScreenSize.medium
                                  ? 60.0.wp
                                  : 30.0.wp,
                          padding: AppPaddings.loginScreenInnerCard,
                          // width: 280.0,
                          decoration:
                              AppBoxDecoration.loginScreenCardDecoration,
                          child: Form(
                              key: model.formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // ElevatedButton(
                                  //     onPressed: () async {
                                  //       await model.copyDeviceToken();
                                  //     },
                                  //     child: const Text(
                                  //       "Copy device token",
                                  //       style: TextStyle(color: Colors.black87),
                                  //     )),
                                  // ElevatedButton(
                                  //       AppSettings.openAppSettings(
                                  //           type: AppSettingsType.location);
                                  //     },
                                  //     child: SizedBox()),
                                  //
                                  // if (!kReleaseMode) devView(model),
                                  // if (!kReleaseMode)
                                  //   ElevatedButton(
                                  //     child: Text(""),
                                  //     onPressed: () {
                                  //       mainCallFunction();
                                  //     },
                                  //   ),
                                  //
                                  // ElevatedButton(
                                  //     onPressed: () async {
                                  //       await model.gettoken();
                                  //     },
                                  //     child: const Text(
                                  //       'GetToken',
                                  //       style: AppTextStyles.addRequestHeader,
                                  //     )),
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
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        AppLocalizations.of(context)!
                                            .emailAddress
                                            .isRequired,
                                        // AppLocalizations.of(context)!.emailAddress.isRequired,
                                        style: AppTextStyles.formTitleTextStyle
                                            .copyWith(
                                                color: AppColors.blackColor),
                                      ),
                                      10.0.giveHeight,
                                      SizedBox(
                                        // height: 45.0,
                                        width: 62.0.wp,
                                        child: TextFormField(
                                          onFieldSubmitted: (v) {
                                            model.login(context);
                                          },
                                          style:
                                              AppTextStyles.formFieldTextStyle,
                                          scrollPadding:
                                              const EdgeInsets.all(1.0),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          maxLines: 1,
                                          validator: (v) =>
                                              model.checkEmail(v!),
                                          decoration:
                                              AppInputStyles.ashOutlineBorder,
                                          enableSuggestions: false,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          controller: model.nameController,
                                        ),
                                      ),
                                      if (model.emailError.isNotEmpty)
                                        Text(
                                          model.emailError,
                                          style: AppTextStyles.errorTextStyle,
                                        ),
                                    ],
                                  ),
                                  20.0.giveHeight,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        AppLocalizations.of(context)!
                                            .password
                                            .isRequired,
                                        style: AppTextStyles.formTitleTextStyle
                                            .copyWith(
                                                color: AppColors.blackColor),
                                      ),
                                      10.0.giveHeight,
                                      SizedBox(
                                        // height: 45.0,
                                        width: 62.0.wp,
                                        child: TextFormField(
                                          onFieldSubmitted: (v) {
                                            model.login(context);
                                          },
                                          style:
                                              AppTextStyles.formFieldTextStyle,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          maxLines: 1,
                                          obscureText: !model.isVisible,
                                          decoration: AppInputStyles
                                              .ashOutlineBorder
                                              .copyWith(
                                            suffixIconConstraints:
                                                const BoxConstraints(
                                                    maxHeight: 14),
                                            suffixIcon: GestureDetector(
                                              onTap: model.changeVisibility,
                                              child: model.isVisible
                                                  ? const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Icon(
                                                        Icons.remove_red_eye,
                                                        color:
                                                            AppColors.ashColor,
                                                      ),
                                                    )
                                                  : const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Icon(
                                                        Icons
                                                            .visibility_off_sharp,
                                                        color:
                                                            AppColors.ashColor,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          controller: model.passwordController,
                                          validator: (v) =>
                                              model.checkPassword(v!),
                                        ),
                                      ),
                                      if (model.passwordError.isNotEmpty)
                                        Text(
                                          model.passwordError,
                                          style: AppTextStyles.errorTextStyle,
                                        ),
                                    ],
                                  ),
                                  20.0.giveHeight,
                                  Center(
                                    child: InkWell(
                                      onTap: model.changeRememberMe,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CheckedBox(
                                            check: model.isRememberMe,
                                          ),
                                          10.0.giveWidth,
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .rememberMe,
                                              style:
                                                  AppTextStyles.loginTitleStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.0.giveHeight,
                                  model.isLoginAttempt
                                      ? const SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator(
                                            color: AppColors.loader1,
                                          ),
                                        )
                                      : SubmitButton(
                                          height: 45.0,
                                          onPressed: () {
                                            print(MediaQuery.of(context)
                                                .size
                                                .height);
                                            model.login(context);
                                          },
                                          text: AppLocalizations.of(context)!
                                              .login
                                              .toUpperCase(),
                                        ),
                                  20.0.giveHeight,
                                  TextButton(
                                    onPressed: model.forgotPasswordButton,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .forgotPassword,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.loginTitleStyle,
                                    ),
                                  ),
                                  10.0.giveWidth,
                                  Text(
                                    (SpecialKeys.appVersion)
                                        .toString()
                                        .toUpperCase(),
                                    style: AppTextStyles.loginTitleStyle,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                if (!model.connection)
                  Container(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    decoration:
                        const BoxDecoration(color: AppColors.messageColorError),
                    child: Center(
                      child: Container(
                        width: 85.0.wp,
                        height: 55.0.hp,
                        padding: AppPaddings.loginScreenInnerCard,
                        // width: 280.0,
                        decoration: AppBoxDecoration.loginScreenCardDecoration,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.noInternetError,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  devView(LoginScreenViewModel model) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: model.retailerPrefill,
          child: const Text(
            "Retailer",
            style: AppTextStyles.addRequestHeader,
          ),
        ),
        ElevatedButton(
          onPressed: model.wholesalerPrefill,
          child: const Text(
            "Wholesaler",
            style: AppTextStyles.addRequestHeader,
          ),
        ),
      ],
    );
  }
}
