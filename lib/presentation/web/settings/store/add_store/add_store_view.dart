import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stacked/stacked.dart';
import '../../../../../const/utils.dart';
import '../../../../../const/web _utils.dart';
import '../../../../../const/web_devices.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/all_city_model.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/text/common_text.dart';
import '../../../../widgets/text_fields/name_text_field.dart';
import '../../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import 'add_store_view_model.dart';

class AddStoreView extends StatelessWidget {
  const AddStoreView({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddStoreViewModel>.reactive(
        viewModelBuilder: () => AddStoreViewModel(),
        onViewModelReady: (AddStoreViewModel model) {
          model.prefill(id);
        },
        builder: (context, model, child) {
          return Scaffold(
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: model.isEdit
                          ? AppLocalizations.of(context)!.editStore
                          : AppLocalizations.of(context)!.addStore,
                    ),
                  ),
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
                              h1: model.isEdit
                                  ? AppLocalizations.of(context)!.editStore
                                  : AppLocalizations.of(context)!.addStore,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.store,
                                            style: AppTextStyles.headerText,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: SubmitButton(
                                              color: AppColors.webButtonColor,
                                              isRadius: false,
                                              height: 40,
                                              width: 80,
                                              onPressed: () {
                                                model.goBack(context);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .viewAll,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Flex(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                child: NameTextField(
                                                    height: 45,
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    style: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor),
                                                    controller: model
                                                        .locationNameController,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .locationName
                                                            .isRequired),
                                              ),
                                              Utils.errorShow(model
                                                  .errorLocationNameController),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                child: SelectedDropdown<
                                                    AllCityDataModel>(
                                                  dropdownValue:
                                                      model.selectedCity,
                                                  fieldName:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .city
                                                          .isRequired,
                                                  items: model.cities
                                                      .map((e) =>
                                                          DropdownMenuItem<
                                                              AllCityDataModel>(
                                                            value: e,
                                                            child:
                                                                Text(e.city!),
                                                          ))
                                                      .toList(),
                                                  onChange:
                                                      (AllCityDataModel? v) {
                                                    model.selectCity(v);
                                                  },
                                                ),
                                              ),
                                              Utils.errorShow(
                                                  model.selectedCityValidation),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                child: SelectedDropdown<String>(
                                                  fieldName:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .country
                                                          .isRequired,
                                                  dropdownValue:
                                                      model.selectedCountry,
                                                  items:
                                                      model.country.country ==
                                                              null
                                                          ? []
                                                          : [
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: model
                                                                    .country
                                                                    .country,
                                                                child: Text(model
                                                                    .country
                                                                    .country!),
                                                              )
                                                            ],
                                                  onChange: (String? v) {
                                                    model.selectCountry(v);
                                                  },
                                                ),
                                              ),
                                              Utils.errorShow(model
                                                  .selectedCountryValidation),
                                            ],
                                          ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      Flex(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                child: NameTextField(
                                                    onChanged: (String v) {
                                                      model.getPlaces(v);
                                                    },
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .ashColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                    style: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor),
                                                    controller:
                                                        model.addressController,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .address
                                                            .isRequired),
                                              ),
                                              Utils.errorShow(
                                                  model.errorAddressMessage),
                                              Visibility(
                                                visible: model
                                                    .addressList.isNotEmpty,
                                                child: SizedBox(
                                                  height: 300,
                                                  width: 200,
                                                  child: ListView.builder(
                                                      itemCount: model
                                                          .addressList.length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (ctx, index) {
                                                        var address = model
                                                            .addressList[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              model.openMap(
                                                                  address
                                                                      .description,
                                                                  address
                                                                      .placeId);
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width:
                                                                            25,
                                                                        height:
                                                                            25,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        child: const Center(
                                                                            child: Icon(
                                                                          CupertinoIcons
                                                                              .location_solid,
                                                                          size:
                                                                              14,
                                                                          color:
                                                                              Colors.white,
                                                                        ))),
                                                                    Flexible(
                                                                      fit: FlexFit
                                                                          .tight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                12.0),
                                                                        child:
                                                                            Text(
                                                                          address.description ??
                                                                              '',
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              4.0),
                                                                  child:
                                                                      Divider(
                                                                    color: AppColors
                                                                        .dividerColor,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 150,
                                                      child: Center(
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                    0, 2),
                                                              )
                                                            ],
                                                          ),
                                                          child: model.frontImage !=
                                                                  null
                                                              ? SizedBox(
                                                                  height: 140.0,
                                                                  width: 150.0,
                                                                  child: Image
                                                                      .memory(
                                                                    model
                                                                        .frontImage!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                )
                                                              : model.frontServerImage
                                                                      .isEmpty
                                                                  ? Image.asset(
                                                                      AppAsset
                                                                          .loginLogo)
                                                                  : WebUtils.image(
                                                                      context,
                                                                      model
                                                                          .frontServerImage),
                                                        ),
                                                      ),
                                                    ),
                                                    CommonText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .frontBusinessPhoto
                                                            .isRequired),
                                                    10.0.giveHeight,
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .ashColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: Row(
                                                        children: [
                                                          SubmitButton(
                                                            onPressed: () {
                                                              model.uploadFile(
                                                                  isFrontImage:
                                                                      true);
                                                            },
                                                            fontColor: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            text: AppLocalizations
                                                                    .of(context)!
                                                                .chooseFiles
                                                                .isRequired,
                                                            width: 35.0,
                                                            color: AppColors
                                                                .webBackgroundColor,
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                5.0.giveWidth,
                                                                Expanded(
                                                                  child: Text(
                                                                    model.frontImageName
                                                                            .isNotEmpty
                                                                        ? model
                                                                            .frontImageName
                                                                        : AppLocalizations.of(context)!
                                                                            .noFileSelected,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          20.0.giveWidth
                                                        ],
                                                      ),
                                                    ),
                                                    if (device ==
                                                        ScreenSize.small)
                                                      20.0.giveHeight,
                                                  ],
                                                ),
                                              ),
                                              Utils.errorShow(
                                                  model.frontPhotoValidation),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : (100.0.wp - 218) / 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 150,
                                                      child: Center(
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                    0, 2),
                                                              )
                                                            ],
                                                          ),
                                                          child: model.signImage !=
                                                                  null
                                                              ? SizedBox(
                                                                  height: 140.0,
                                                                  width: 150.0,
                                                                  child: Image
                                                                      .memory(
                                                                    model
                                                                        .signImage!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                )
                                                              : model.signServerImage
                                                                      .isEmpty
                                                                  ? Image.asset(
                                                                      AppAsset
                                                                          .loginLogo)
                                                                  : WebUtils.image(
                                                                      context,
                                                                      model
                                                                          .signServerImage),
                                                        ),
                                                      ),
                                                    ),
                                                    CommonText(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .signBoardPhoto
                                                            .isRequired),
                                                    10.0.giveHeight,
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .ashColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0)),
                                                      child: Row(
                                                        children: [
                                                          SubmitButton(
                                                            onPressed: () {
                                                              model.uploadFile(
                                                                  isFrontImage:
                                                                      false);
                                                            },
                                                            fontColor: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            text: AppLocalizations
                                                                    .of(context)!
                                                                .chooseFiles,
                                                            width: 35.0,
                                                            color: AppColors
                                                                .webBackgroundColor,
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                5.0.giveWidth,
                                                                Expanded(
                                                                  child: Text(
                                                                    model.signImageName
                                                                            .isNotEmpty
                                                                        ? model
                                                                            .signImageName
                                                                        : AppLocalizations.of(context)!
                                                                            .noFileSelected,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          20.0.giveWidth
                                                        ],
                                                      ),
                                                    ),
                                                    if (device ==
                                                        ScreenSize.small)
                                                      20.0.giveHeight,
                                                  ],
                                                ),
                                              ),
                                              Utils.errorShow(model
                                                  .signBoardPhotoValidation),
                                            ],
                                          ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : (100.0.wp - 128),
                                            child: NameTextField(
                                                // height: 100,
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyle
                                                    .copyWith(
                                                        color:
                                                            AppColors.ashColor,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                style: AppTextStyles
                                                    .formTitleTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .blackColor),
                                                controller:
                                                    model.remarksController,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .remark
                                                    .isRequired),
                                          ),
                                          Utils.errorShow(
                                              model.errorRemarksMessage),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      model.isButtonBusy
                                          ? SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : (100.0.wp - 218) / 3,
                                              height: 45,
                                              child: Center(
                                                child: Utils.loaderBusy(),
                                              ),
                                            )
                                          : SubmitButton(
                                              isRadius: false,
                                              text: model.isEdit
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .editStore
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .addStore,
                                              color: AppColors.bingoGreen,
                                              onPressed: () {
                                                model.addStore(context);
                                              },
                                              isPadZero: true,
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : (100.0.wp - 218) / 3,
                                              height: 45,
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
