import 'dart:io';
import 'package:bingo/data_models/enums/user_roles_files.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';

import '../../widgets/utils_folder/validation_text.dart';
import '/app/app_secrets.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/app_styles/app_box_decoration.dart';
import '/const/utils.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import '/presentation/widgets/cards/single_lin_shimmer.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stacked/stacked.dart';
import '../../../data_models/models/store_model/store_model.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/google_place_new.dart';
import '../../widgets/cards/loader/loader.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import 'add_store_screen_view_model.dart';

class AddStoreView extends StatelessWidget {
  const AddStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddStoreViewModel>.reactive(
      viewModelBuilder: () => AddStoreViewModel(),
      onViewModelReady: (AddStoreViewModel model) {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          model.setDetails(
              ModalRoute.of(context)!.settings.arguments as StoreData);
        }
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarColorRetailer,
            title: AppBarText(model.title.toUpperCase()),
          ),
          body: model.isBusy
              ? const LoaderWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: AppPaddings.bodyVertical,
                    child: ShadowCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          NameTextField(
                            controller: model.locationNameController,
                            fieldName: AppLocalizations.of(context)!
                                .locationName
                                .isRequired,
                          ),
                          model.locationNameValidation.validate(),
                          20.0.giveHeight,
                          model.isBusy
                              ? const SingleLineShimmerScreen()
                              : SelectedDropdown<String>(
                                  onChange: (String value) {
                                    model.changeCountry(value);
                                  },
                                  dropdownValue: model.selectedCountry,
                                  hintText: AppLocalizations.of(context)!
                                      .selectCountry,
                                  fieldName: AppLocalizations.of(context)!
                                      .country
                                      .isRequired,
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: model.allCountryData,
                                      child: Text(model.allCountryData),
                                    ),
                                  ],
                                ),
                          model.selectedCountryValidation.validate(),
                          20.0.giveHeight,
                          model.isBusy
                              ? const SingleLineShimmerScreen()
                              : SelectedDropdown<String>(
                                  onChange: (String value) {
                                    model.changeCity(value);
                                  },
                                  dropdownValue: model.selectedCity,
                                  hintText:
                                      AppLocalizations.of(context)!.selectCity,
                                  fieldName: AppLocalizations.of(context)!
                                      .city
                                      .isRequired,
                                  items: model.allCityData
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                ),
                          model.selectedCityValidation.validate(),
                          20.0.giveHeight,
                          CommonText(
                            AppLocalizations.of(context)!.address.isRequired,
                            style: AppTextStyles.formTitleTextStyle
                                .copyWith(color: AppColors.blackColor),
                          ),
                          10.0.giveHeight,
                          SizedBox(
                            // height: 100,
                            width: 100.0.wp,
                            child: PlacesAutocompleteWidget(
                              getController: model.addressController,
                              apiKey: AppSecrets.kGoogleApiKey,
                              offset: 0,
                              onchange: (Prediction v) async {
                                await model.displayPrediction(v);
                              },
                              components: [
                                Component('country',
                                    model.getCountryShortCode(model.country))
                              ],
                              types: const [],
                              hint: AppLocalizations.of(context)!
                                  .profileViewAddressHintText,
                              radius: 1000,
                              strictbounds: false,
                              region: "us",
                              language: "en",
                              mode: Mode.overlay,
                              // location: location,
                              logo: Image.asset(
                                AppAsset.loginLogo,
                                height: 20,
                              ),
                            ),
                          ),
                          if (model.addressValidation.isNotEmpty)
                            Text(
                              model.addressValidation,
                              style: AppTextStyles.errorTextStyle,
                            ),
                          20.0.giveHeight,
                          CommonText(
                            AppLocalizations.of(context)!
                                .frontBusinessPhoto
                                .isRequired,
                            style: AppTextStyles.successStyle
                                .copyWith(color: AppColors.blackColor),
                          ),
                          10.0.giveHeight,
                          if (model.isEdit)
                            SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: Image.network(
                                model.frontImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: Image.asset(
                                      AppAsset.errorImage,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          10.0.giveHeight,
                          SubmitButton(
                            onPressed: model.pickFrontBusinessPhoto,
                            active: true,
                            text: AppLocalizations.of(context)!.chooseFiles,
                            width: 99.0,
                          ),
                          if (!model.isEdit)
                            model.frontPhotoValidation.validate(),
                          20.0.giveHeight,
                          model.frontBusinessPhoto != null
                              ? Container(
                                  decoration: AppBoxDecoration.borderDecoration,
                                  child: Image.file(
                                    File(model.frontBusinessPhoto!.path),
                                  ),
                                )
                              : const SizedBox(),
                          if (model.frontBusinessPhoto != null) 20.0.giveHeight,
                          CommonText(
                            AppLocalizations.of(context)!
                                .signBoardPhoto
                                .isRequired,
                            style: AppTextStyles.successStyle
                                .copyWith(color: AppColors.blackColor),
                          ),
                          10.0.giveHeight,
                          if (model.isEdit)
                            SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: Image.network(
                                model.signBoardImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    height: 100.0,
                                    width: 100.0,
                                    child: Image.asset(
                                      AppAsset.errorImage,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            ),
                          10.0.giveHeight,
                          SubmitButton(
                            onPressed: model.pickSignBoardPhoto,
                            active: true,
                            text: AppLocalizations.of(context)!.chooseFiles,
                            width: 99.0,
                          ),
                          if (!model.isEdit)
                            if (model.signBoardPhotoValidation.isNotEmpty)
                              ValidationText(model.signBoardPhotoValidation),
                          20.0.giveHeight,
                          if (model.signBoardPhoto != null)
                            Container(
                              decoration: AppBoxDecoration.borderDecoration,
                              child: Image.file(
                                File(model.signBoardPhoto!.path),
                              ),
                            ),
                          if (model.signBoardPhoto != null) 20.0.giveHeight,
                          CommonText(
                            AppLocalizations.of(context)!.remark.isRequired,
                            style: AppTextStyles.formTitleTextStyle
                                .copyWith(color: AppColors.blackColor),
                          ),
                          10.0.giveHeight,
                          TextField(
                            style: AppTextStyles.formFieldTextStyle,
                            controller: model.remarkController,
                            decoration: AppInputStyles.ashOutlineBorder
                                .copyWith(
                                    hintStyle:
                                        AppTextStyles.formFieldHintTextStyle),
                            maxLines: 6,
                          ),
                          model.remarksValidation.validate(),
                          25.0.giveHeight,
                          model.isButtonBusy
                              ? SizedBox(
                                  height: 110.0,
                                  child: Center(
                                    child: Utils.loaderBusy(),
                                  ),
                                )
                              : Column(
                                  children: [
                                    if (model.isUserHaveAccess(
                                        UserRolesFiles.addStoreButton))
                                      SubmitButton(
                                        onPressed: model.addStore,
                                        active: true,
                                        text: model.submitButton.toUpperCase(),
                                        width: 100.0.wp,
                                        height: 45.0,
                                      ),
                                    if (model.isEdit) 10.0.giveHeight,
                                    if (model.isEdit)
                                      SubmitButton(
                                        onPressed: model.requestInactive,
                                        color: (model.status.toLowerCase() ==
                                                "active")
                                            ? AppColors.statusConfirmed
                                            : AppColors.statusVerified,
                                        active: true,
                                        text: (model.status.toLowerCase() ==
                                                "active")
                                            ? AppLocalizations.of(context)!
                                                .inactiveButton
                                                .toUpperCase()
                                            : AppLocalizations.of(context)!
                                                .activeButton
                                                .toUpperCase(),
                                        width: 100.0.wp,
                                        height: 45.0,
                                      ),
                                    10.0.giveHeight,
                                    SubmitButton(
                                      onPressed: model.removeRequest,
                                      color: AppColors.statusReject,
                                      active: true,
                                      text: AppLocalizations.of(context)!
                                          .cancelButton
                                          .toUpperCase(),
                                      width: 100.0.wp,
                                      height: 45.0,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
