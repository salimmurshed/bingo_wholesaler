import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/utils.dart';
import '../../../const/web _utils.dart';
import '../../../const/web_devices.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/text_fields/name_text_field.dart';
import '../../widgets/text_fields/text_area.dart';
import '../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../widgets/web_widgets/app_bars/web_app_bar.dart';
import 'edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
        viewModelBuilder: () => EditProfileViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: AppLocalizations.of(context)!.editProfile_header,
                    ),
                  ),
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            body: SingleChildScrollView(
              controller: model.scrollController,
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      WebAppBar(
                          onTap: (String v) {
                            model.changeTab(context, v);
                          },
                          tabNumber: model.tabNumber),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (device != ScreenSize.small)
                            SecondaryNameAppBar(
                              h1: AppLocalizations.of(context)!
                                  .editProfile_header,
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .editProfile_header2,
                                        style: AppTextStyles.headerText,
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : 30.0.wp,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 190,
                                                  child: Center(
                                                    child: model.platformImage !=
                                                            null
                                                        ? SizedBox(
                                                            height: 190.0,
                                                            width: 150.0,
                                                            child: Image.memory(
                                                                model
                                                                    .platformImage!),
                                                          )
                                                        : model.img.isEmpty
                                                            ? Image.asset(
                                                                AppAsset
                                                                    .loginLogo)
                                                            : WebUtils.image(
                                                                context,
                                                                model.img,
                                                                width: 190,
                                                                height: 190),
                                                  ),
                                                ),
                                                5.0.giveHeight,
                                                CommonText(AppLocalizations.of(
                                                        context)!
                                                    .changeYourProfilePicture
                                                    .isRequired),
                                                5.0.giveHeight,
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .cardShadow),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  child: Row(
                                                    children: [
                                                      SubmitButton(
                                                        onPressed: () {
                                                          model.uploadFile();
                                                        },
                                                        fontColor: AppColors
                                                            .blackColor,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .chooseFile,
                                                        width: 35.0,
                                                        color: AppColors
                                                            .webBackgroundColor,
                                                      ),
                                                      Text(model
                                                              .platformImageName
                                                              .isNotEmpty
                                                          ? model
                                                              .platformImageName
                                                          : AppLocalizations.of(
                                                                  context)!
                                                              .noFileSelected),
                                                      20.0.giveWidth
                                                    ],
                                                  ),
                                                ),
                                                if (device == ScreenSize.small)
                                                  20.0.giveHeight,
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : 55.0.wp,
                                            child: Column(
                                              children: [
                                                Flex(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  direction:
                                                      device == ScreenSize.small
                                                          ? Axis.vertical
                                                          : Axis.horizontal,
                                                  children: [
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 25.0.wp,
                                                      height: 70,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          NameTextField(
                                                            height: 35,
                                                            controller: model
                                                                .fNameController,
                                                            fieldName:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .firstName
                                                                    .isRequired,
                                                            hintStyle: AppTextStyles
                                                                .formTitleTextStyleNormal,
                                                          ),
                                                          Utils.errorShow(model
                                                              .firstnameErrorMessage),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 25.0.wp,
                                                      height: 70,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          NameTextField(
                                                            height: 35,
                                                            controller: model
                                                                .lNameController,
                                                            fieldName:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .lastName
                                                                    .isRequired,
                                                            hintStyle: AppTextStyles
                                                                .formTitleTextStyleNormal,
                                                          ),
                                                          Utils.errorShow(model
                                                              .lastNameErrorMessage),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 55.0.wp,
                                                  height: 70,
                                                  child: NameTextField(
                                                    readOnly: true,
                                                    enable: false,
                                                    height: 35,
                                                    controller:
                                                        model.emailController,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .email,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 55.0.wp,
                                                  height: 130,
                                                  child: NameTextField(
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .address
                                                            .isRequired,
                                                    controller:
                                                        model.addressController,
                                                    maxLine: 4,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Divider(
                                          color: AppColors.dividerColor,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .changePassword,
                                        style: AppTextStyles.headerText,
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Container(
                                        width: 100.0.wp,
                                        decoration: AppBoxDecoration
                                            .dashboardCardDecoration
                                            .copyWith(
                                          borderRadius:
                                              AppRadius.salesDetailsRadius,
                                        ),
                                        child: Flex(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          direction: device == ScreenSize.small
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                          children: [
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 25.0.wp,
                                              height: 70,
                                              child: NameTextField(
                                                onChanged: (a) {
                                                  model.checkPassword(context);
                                                },
                                                obscureText: !model
                                                    .isCurrentPasswordVisible,
                                                controller: model
                                                    .currentPasswordController,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .currentPassword,
                                                widget: GestureDetector(
                                                  onTap: model
                                                      .changeCurrentPasswordVisibility,
                                                  child: model
                                                          .isCurrentPasswordVisible
                                                      ? const Icon(
                                                          Icons.remove_red_eye,
                                                          color: AppColors
                                                              .ashColor,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .visibility_off_sharp,
                                                          color: AppColors
                                                              .ashColor,
                                                        ),
                                                ),
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                              ),
                                            ),
                                            20.0.giveHeight,
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 25.0.wp,
                                              height: 70,
                                              child: NameTextField(
                                                onChanged: (a) {
                                                  model.checkPassword(context);
                                                },
                                                obscureText:
                                                    !model.isNewPasswordVisible,
                                                controller:
                                                    model.newPasswordController,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .newPassword,
                                                widget: GestureDetector(
                                                  onTap: model
                                                      .changeNewPasswordVisibility,
                                                  child: model
                                                          .isNewPasswordVisible
                                                      ? const Icon(
                                                          Icons.remove_red_eye,
                                                          color: AppColors
                                                              .ashColor,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .visibility_off_sharp,
                                                          color: AppColors
                                                              .ashColor,
                                                        ),
                                                ),
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                              ),
                                            ),
                                            20.0.giveHeight,
                                            SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 25.0.wp,
                                              height: 70,
                                              child: NameTextField(
                                                onChanged: (a) {
                                                  model.checkPassword(context);
                                                },
                                                obscureText: !model
                                                    .isRetypePasswordVisible,
                                                controller: model
                                                    .retypePasswordController,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .retypePassword,
                                                widget: GestureDetector(
                                                  onTap: model
                                                      .changeRetypePasswordVisibility,
                                                  child: model
                                                          .isRetypePasswordVisible
                                                      ? const Icon(
                                                          Icons.remove_red_eye,
                                                          color: AppColors
                                                              .ashColor,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .visibility_off_sharp,
                                                          color: AppColors
                                                              .ashColor,
                                                        ),
                                                ),
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                              ),
                                            ),
                                            20.0.giveHeight,
                                          ],
                                        ),
                                      ),
                                      Text(
                                        model.errorPasswordMessage,
                                        style: AppTextStyles.buttonText
                                            .copyWith(
                                                color: model.isPassError
                                                    ? AppColors.redColor
                                                    : AppColors.greenColor),
                                      ),
                                      SubmitButton(
                                        onPressed: model.updateProfile,
                                        isPadZero: true,
                                        width: device == ScreenSize.small
                                            ? 80.0.wp
                                            : 25.0.wp,
                                        isRadius: false,
                                        height: 45.0,
                                        color: AppColors.bingoGreen,
                                        text: AppLocalizations.of(context)!
                                            .updateProfile,
                                      )
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
