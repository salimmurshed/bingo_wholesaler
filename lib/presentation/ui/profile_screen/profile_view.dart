import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';

import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) {
          print(model.user.data!.profileImage!);
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBar(
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
              title: AppBarText(
                  AppLocalizations.of(context)!.editProfile.toUpperCase()),
            ),
            body: Padding(
              padding: AppPaddings.cardBody,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.editYourProfile,
                      style: AppTextStyles.statusCardTitle,
                    ),
                    10.0.giveHeight,
                    Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.salesDetailsRadius,
                      ),
                      child: Container(
                        width: 100.0.wp,
                        margin: AppMargins.salesDetailsMainCardMargin,
                        decoration:
                            AppBoxDecoration.dashboardCardDecoration.copyWith(
                          borderRadius: AppRadius.salesDetailsRadius,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 159.0,
                              width: 159.0,
                              child: model.user.data!.profileImage!.isNotEmpty
                                  ? SizedBox(
                                      height: 159.0,
                                      width: 159.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(160.0),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              model.user.data!.profileImage!,
                                          height: 159.0,
                                          width: 159.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Image.asset(
                                      AppAsset.profileImage,
                                      height: 159.0,
                                      width: 159.0,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            11.0.giveHeight,
                            SubmitButton(
                              onPressed: model.picImage,
                              color: AppColors.borderColors,
                              active: false,
                              width: 167.0,
                              height: 45.0,
                              text: AppLocalizations.of(context)!
                                  .changeYourProfilePicture,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                33.0.giveHeight,
                                NameTextField(
                                  controller: model.fNameController,
                                  fieldName: AppLocalizations.of(context)!
                                      .firstName
                                      .isRequired,
                                  hintText:
                                      AppLocalizations.of(context)!.firstName,
                                ),
                                Text(
                                  model.firstnameErrorMessage,
                                  style: AppTextStyles.buttonText
                                      .copyWith(color: AppColors.redColor),
                                ),
                                20.0.giveHeight,
                                NameTextField(
                                  controller: model.lNameController,
                                  fieldName: AppLocalizations.of(context)!
                                      .lastName
                                      .isRequired,
                                  hintText:
                                      AppLocalizations.of(context)!.lastName,
                                ),
                                Text(
                                  model.lastNameErrorMessage,
                                  style: AppTextStyles.buttonText
                                      .copyWith(color: AppColors.redColor),
                                ),
                                20.0.giveHeight,
                                NameTextField(
                                  enable: false,
                                  controller: model.emailController,
                                  fieldName:
                                      AppLocalizations.of(context)!.email,
                                  hintText: AppLocalizations.of(context)!.email,
                                ),
                                20.0.giveHeight,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText(
                                      AppLocalizations.of(context)!
                                          .address
                                          .isRequired,
                                      style: AppTextStyles.formTitleTextStyle
                                          .copyWith(
                                              color: AppColors.blackColor),
                                    ),
                                    10.0.giveHeight,
                                    GestureDetector(
                                      onTap: () {
                                        model.addAddress(context);
                                      },
                                      child: SizedBox(
                                        height: 45.0 * 4 - (30 * (4 - 1)),
                                        child: TextFormField(
                                          scrollPadding: EdgeInsets.zero,

                                          maxLines: 4,
                                          style: AppTextStyles
                                              .formFieldTextStyle
                                              .copyWith(
                                                  color: AppColors.ashColor),
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          readOnly: true,
                                          decoration: AppInputStyles
                                              .ashOutlineBorder
                                              .copyWith(
                                                  hintText: AppLocalizations.of(
                                                          context)!
                                                      .address,
                                                  hintStyle: AppTextStyles
                                                      .formFieldHintTextStyle),
                                          // decoration: AppInputStyles.ashOutlineBorder.copyWith(
                                          //     fillColor:
                                          //         enable ? AppColors.whiteColor : AppColors.disableColor),
                                          controller: model.addressController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  model.addressPasswordMessage,
                                  style: AppTextStyles.buttonText.copyWith(
                                      color: model.isPassError
                                          ? AppColors.redColor
                                          : AppColors.greenColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    33.0.giveHeight,
                    Text(
                      AppLocalizations.of(context)!.changePassword,
                      style: AppTextStyles.statusCardTitle,
                    ),
                    10.0.giveHeight,
                    Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.salesDetailsRadius,
                      ),
                      child: Container(
                        width: 100.0.wp,
                        margin: AppMargins.salesDetailsMainCardMargin,
                        decoration:
                            AppBoxDecoration.dashboardCardDecoration.copyWith(
                          borderRadius: AppRadius.salesDetailsRadius,
                        ),
                        child: Column(
                          children: [
                            NameTextField(
                              onChanged: (a) {
                                model.checkPassword();
                              },
                              obscureText: !model.isCurrentPasswordVisible,
                              controller: model.currentPasswordController,
                              fieldName: AppLocalizations.of(context)!
                                  .currentPassword
                                  .isRequired,
                              widget: GestureDetector(
                                onTap: model.changeCurrentPsswordVisibility,
                                child: model.isCurrentPasswordVisible
                                    ? const Icon(
                                        Icons.remove_red_eye,
                                        color: AppColors.ashColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_sharp,
                                        color: AppColors.ashColor,
                                      ),
                              ),
                            ),
                            20.0.giveHeight,
                            NameTextField(
                              onChanged: (a) {
                                model.checkPassword();
                              },
                              obscureText: !model.isNewPasswordVisible,
                              controller: model.newPasswordController,
                              fieldName: AppLocalizations.of(context)!
                                  .newPassword
                                  .isRequired,
                              widget: GestureDetector(
                                onTap: model.changeNewPsswordVisibility,
                                child: model.isNewPasswordVisible
                                    ? const Icon(
                                        Icons.remove_red_eye,
                                        color: AppColors.ashColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_sharp,
                                        color: AppColors.ashColor,
                                      ),
                              ),
                            ),
                            20.0.giveHeight,
                            NameTextField(
                              onChanged: (a) {
                                model.checkPassword();
                              },
                              obscureText: !model.isRetypePasswordVisible,
                              controller: model.retypePasswordController,
                              fieldName: AppLocalizations.of(context)!
                                  .retypePassword
                                  .isRequired,
                              widget: GestureDetector(
                                onTap: model.changeRetypePasswordVisibility,
                                child: model.isRetypePasswordVisible
                                    ? const Icon(
                                        Icons.remove_red_eye,
                                        color: AppColors.ashColor,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_sharp,
                                        color: AppColors.ashColor,
                                      ),
                              ),
                            ),
                            Text(
                              model.errorPasswordMessage,
                              style: AppTextStyles.buttonText.copyWith(
                                  color: model.isPassError
                                      ? AppColors.redColor
                                      : AppColors.greenColor),
                            ),
                            20.0.giveHeight,
                          ],
                        ),
                      ),
                    ),
                    10.0.giveHeight,
                    Center(
                      child: model.isBusy
                          ? Utils.loaderBusy()
                          : SubmitButton(
                              height: 45.0,
                              onPressed: model.updateProfile,
                              text: AppLocalizations.of(context)!.updateProfile,
                            ),
                    ),
                    10.0.giveHeight,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
