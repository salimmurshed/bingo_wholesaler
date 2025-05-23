import 'dart:convert';

import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/app_sizes/app_sizes.dart';
import '../../../../const/server_status_file/server_status_file.dart';
import '../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/component_models/partner_with_currency_list.dart';
import '../../../widgets/checked_box.dart';
import '../../../widgets/dropdowns/custom_searchable_dropdown.dart';
import '../../../widgets/dropdowns/custom_searchable_dropdown2.dart';
import '../../../widgets/text/common_text.dart';
import '../../../widgets/utils_folder/validation_text.dart';
import 'add_new_creditline_view_model.dart';

class AddNewCreditlineView extends StatelessWidget {
  const AddNewCreditlineView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewCreditlineViewModel>.reactive(
        viewModelBuilder: () => AddNewCreditlineViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'Create Credit Line Information',
                    ),
                  ),
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            body: SingleChildScrollView(
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
                              h1: 'Create Credit Line Information',
                            ),
                          Container(
                            padding: AppPaddings.webBodyPadding,
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : model.wholesalerList.isEmpty
                                    ? Utils.noDataWidget(context,
                                        height: 50.0, name: "Wholesaler")
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Credit Line Information',
                                                style: AppTextStyles.headerText,
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: SubmitButton(
                                                  color: AppColors.bingoGreen,
                                                  isRadius: false,
                                                  height: 40,
                                                  width: 80,
                                                  onPressed: () {
                                                    // Navigator.pop(context);
                                                    model.goBack(context);
                                                  },
                                                  text: "VIEW ALL",
                                                ),
                                              )
                                            ],
                                          ),
                                          20.0.giveHeight,
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          Column(
                                            children: [
                                              if (model
                                                  .wholesalerList.isNotEmpty)
                                                for (int i = 0;
                                                    i < model.itemsCount;
                                                    i++)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: SizedBox(
                                                      width: 100.0.wp,
                                                      // height: 70,
                                                      child: Flex(
                                                        direction: device ==
                                                                ScreenSize.wide
                                                            ? Axis.horizontal
                                                            : Axis.vertical,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 13.0.wp,
                                                            child: SelectedDropdown<
                                                                WholesalerData>(
                                                              dropdownValue: model
                                                                  .selectedWholesaler[i],
                                                              fieldName:
                                                                  "Select Wholesaler"
                                                                      .isRequired,
                                                              items: [
                                                                for (var j = 0;
                                                                    j <
                                                                        model
                                                                            .sortedWholesalerList[
                                                                                i]
                                                                            .length;
                                                                    j++)
                                                                  DropdownMenuItem<
                                                                      WholesalerData>(
                                                                    value: model
                                                                            .sortedWholesalerList[
                                                                        i][j],
                                                                    child: Text(model
                                                                        .sortedWholesalerList[
                                                                            i]
                                                                            [j]
                                                                        .wholesalerName!),
                                                                  )
                                                              ],
                                                              onChange:
                                                                  (WholesalerData?
                                                                      v) {
                                                                model
                                                                    .selectWholesaler(
                                                                        i, v);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 13.0.wp,
                                                            child: SelectedDropdown<
                                                                WholesalerCurrency>(
                                                              dropdownValue: model
                                                                  .currencyList[i],
                                                              fieldName:
                                                                  "Select Currency"
                                                                      .isRequired,
                                                              items: [
                                                                if (model.selectedWholesaler[
                                                                        i] !=
                                                                    null)
                                                                  for (var j =
                                                                          0;
                                                                      j <
                                                                          model
                                                                              .selectedWholesaler[
                                                                                  i]!
                                                                              .wholesalerCurrency!
                                                                              .length;
                                                                      j++)
                                                                    DropdownMenuItem<
                                                                        WholesalerCurrency>(
                                                                      value: model
                                                                          .selectedWholesaler[
                                                                              i]!
                                                                          .wholesalerCurrency![j],
                                                                      child: Text(model
                                                                          .selectedWholesaler[
                                                                              i]!
                                                                          .wholesalerCurrency![
                                                                              j]
                                                                          .currency!),
                                                                    )
                                                              ],
                                                              onChange:
                                                                  (WholesalerCurrency?
                                                                      v) {
                                                                model
                                                                    .selectCurrency(
                                                                        i, v);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 13.0.wp,
                                                            child:
                                                                NameTextField(
                                                              isNumber: true,
                                                              hintStyle: AppTextStyles
                                                                  .formTitleTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .ashColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                              controller: model
                                                                  .monthlyControllers[i],
                                                              fieldName:
                                                                  "Monthly Purchase"
                                                                      .isRequired,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 13.0.wp,
                                                            child:
                                                                NameTextField(
                                                              isNumber: true,
                                                              hintStyle: AppTextStyles
                                                                  .formTitleTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .ashColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                              controller: model
                                                                  .purchasesControllers[i],
                                                              fieldName:
                                                                  "Average Purchase Ticket"
                                                                      .isRequired,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 13.0.wp,
                                                            child: SelectedDropdown<
                                                                VisitFrequentListModel>(
                                                              dropdownValue: model
                                                                  .frequencyList[i],
                                                              fieldName:
                                                                  "Visit Frequency"
                                                                      .isRequired,
                                                              items: [
                                                                for (var j = 0;
                                                                    j <
                                                                        model
                                                                            .visitFrequentlyList
                                                                            .length;
                                                                    j++)
                                                                  DropdownMenuItem<
                                                                      VisitFrequentListModel>(
                                                                    value: model
                                                                        .visitFrequentlyList[j],
                                                                    child: Text(StatusFile.visitFrequent(
                                                                        'en',
                                                                        model
                                                                            .visitFrequentlyList[j]
                                                                            .id!)),
                                                                  )
                                                              ],
                                                              onChange:
                                                                  (VisitFrequentListModel
                                                                      v) {
                                                                model
                                                                    .selectFrequent(
                                                                        i, v);
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 13.0.wp,
                                                            child:
                                                                NameTextField(
                                                              isNumber: true,
                                                              hintStyle: AppTextStyles
                                                                  .formTitleTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .ashColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                              controller: model
                                                                  .amountControllers[i],
                                                              fieldName:
                                                                  "Requested Amount"
                                                                      .isRequired,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              4.0.giveHeight,
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Visibility(
                                                      visible: model
                                                              .wholesalerList
                                                              .length >
                                                          model
                                                              .selectedWholesaler
                                                              .length,
                                                      child: SubmitButton(
                                                        onPressed: () {
                                                          model
                                                              .increaseWholeSalers();
                                                        },
                                                        isRadius: false,
                                                        width: 50,
                                                        color: AppColors
                                                            .webButtonColor,
                                                        text: "+add",
                                                      ),
                                                    ),
                                                    if (model.itemsCount > 1)
                                                      SubmitButton(
                                                        onPressed: model
                                                            .removeWholeSalers,
                                                        isRadius: false,
                                                        width: 50,
                                                        color:
                                                            AppColors.redColor,
                                                        text: "-remove",
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          ValidationText(model
                                              .creditLineInformationErrorMessage),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: Divider(
                                              color: AppColors.dividerColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.0.wp,
                                            child: Wrap(
                                              runSpacing: 20.0,
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              runAlignment:
                                                  WrapAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          enable: true,
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
                                                              .crn1Controller,
                                                          fieldName:
                                                              "Commercial Reference Name 1"
                                                                  .isRequired),
                                                      ValidationText(model
                                                          .crn1ErrorMessage),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NameTextField(
                                                          isNumber: true,
                                                          enable: true,
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
                                                              .crp1Controller,
                                                          fieldName:
                                                              "Commercial Reference Phone No 1"
                                                                  .isRequired),
                                                      ValidationText(model
                                                          .crp1ErrorMessage),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                      enable: true,
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
                                                          model.crn2Controller,
                                                      fieldName:
                                                          "Commercial Reference Name 2"),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                      isNumber: true,
                                                      enable: true,
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
                                                          model.crp2Controller,
                                                      fieldName:
                                                          "Commercial Reference Phone No 2"),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                      enable: true,
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
                                                          model.crn3Controller,
                                                      fieldName:
                                                          "Commercial Reference Name 3"),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                      isNumber: true,
                                                      enable: true,
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
                                                          model.crp3Controller,
                                                      fieldName:
                                                          "Commercial Reference Phone No 3"),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CommonText(
                                                      "Select Financial Institution With Whom You Are Working"
                                                          .isRequired,
                                                      style: AppTextStyles
                                                          .formTitleTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .blackColor),
                                                    ),
                                                    5.0.giveHeight,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .cardShadow)),
                                                          width: device ==
                                                                  ScreenSize
                                                                      .small
                                                              ? 80.0.wp
                                                              : 45.0.wp,
                                                          child:
                                                              CustomSearchableDropDown(
                                                            initialValue: const [],
                                                            close: (i) {
                                                              // model.removeStoreItem(i);
                                                            },
                                                            dropdownHintText:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .selectFie,
                                                            showLabelInMenu:
                                                                false,
                                                            multiSelect: true,
                                                            multiSelectTag:
                                                                true,
                                                            primaryColor:
                                                                AppColors
                                                                    .disableColor,
                                                            menuMode: true,
                                                            labelStyle:
                                                                AppTextStyles
                                                                    .successStyle,
                                                            items:
                                                                model.fieList,
                                                            label: AppLocalizations
                                                                    .of(context)!
                                                                .selectFie,
                                                            dropDownMenuItems:
                                                                model.fieList
                                                                    .map(
                                                                        (item) {
                                                              return '${item.bpName}';
                                                            }).toList(),
                                                            onChanged:
                                                                (List value) {
                                                              model
                                                                  .selectedFieData(
                                                                      value);
                                                            },
                                                          ),
                                                        ),
                                                        ValidationText(model
                                                            .fieListErrorMessage),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CommonText(
                                                          "Upload Financial Statements"
                                                              .isRequired,
                                                          style: AppTextStyles
                                                              .formTitleTextStyle
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .blackColor)),
                                                      5.0.giveHeight,
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .cardShadow),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        child: Row(
                                                          children: [
                                                            SubmitButton(
                                                              onPressed: () {
                                                                model
                                                                    .uploadFile();
                                                              },
                                                              fontColor: AppColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .chooseFile,
                                                              width: 35.0,
                                                              color: AppColors
                                                                  .webBackgroundColor,
                                                            ),
                                                            CommonText(
                                                                model.files
                                                                        .isNotEmpty
                                                                    ? "${model.files.length} files selected"
                                                                    : AppLocalizations.of(
                                                                            context)!
                                                                        .noFileSelected,
                                                                style: AppTextStyles
                                                                    .formTitleTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .blackColor)),
                                                            20.0.giveWidth
                                                          ],
                                                        ),
                                                      ),
                                                      ValidationText(model
                                                          .filesErrorMessage),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          20.0.giveHeight,
                                          CommonText(
                                            "Choose Options".isRequired,
                                            style: AppTextStyles
                                                .formTitleTextStyle
                                                .copyWith(
                                                    color:
                                                        AppColors.blackColor),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  model.changeOption(0);
                                                },
                                                child: model.selectedOption == 0
                                                    ? const Icon(
                                                        Icons.circle,
                                                        color: AppColors
                                                            .bingoGreen,
                                                      )
                                                    : const Icon(
                                                        Icons.circle_outlined),
                                              ),
                                              CommonText(
                                                  "Allow Bingo to forward this Credit Line Request to As Many Financial Institutions deemed appropriate",
                                                  style: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  model.changeOption(1);
                                                },
                                                child: model.selectedOption == 1
                                                    ? const Icon(
                                                        Icons.circle,
                                                        color: AppColors
                                                            .bingoGreen,
                                                      )
                                                    : const Icon(
                                                        Icons.circle_outlined),
                                              ),
                                              CommonText(
                                                  "Send Credit Line Request To a Specific Financial institution",
                                                  style: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor))
                                            ],
                                          ),
                                          ValidationText(
                                              model.selectedOptionErrorMessage),
                                          10.0.giveHeight,
                                          Visibility(
                                            visible: model.selectedOption == 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommonText(
                                                  "Select FIE".isRequired,
                                                  style: AppTextStyles
                                                      .formTitleTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor),
                                                ),
                                                10.0.giveHeight,
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child:
                                                      CustomSearchableDropDown2(
                                                    items: jsonDecode(
                                                        jsonEncode(
                                                            model.fieList)),
                                                    menuMode: true,
                                                    label: 'Select Name',
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .cardShadow)),
                                                    prefixIcon: const Padding(
                                                      padding:
                                                          EdgeInsets.all(0.0),
                                                      child: Icon(Icons.search),
                                                    ),
                                                    dropDownMenuItems: jsonDecode(
                                                                jsonEncode(model
                                                                    .fieList))
                                                            .map((item) {
                                                          return item[
                                                              'bp_name'];
                                                        }).toList() ??
                                                        [],
                                                    onChanged: (value) {
                                                      model.change(value);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          20.0.giveHeight,
                                          GestureDetector(
                                            onTap: model.changeCheckBox,
                                            child: Row(
                                              children: [
                                                CheckedBox(
                                                  check:
                                                      model.acceptTermCondition,
                                                ),
                                                CommonText(
                                                    "Accept Terms & Condition and authorize BINGO to send Credit Line Request detail to Financial Institutions"
                                                        .isRequired,
                                                    style: AppTextStyles
                                                        .formTitleTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor))
                                              ],
                                            ),
                                          ),
                                          ValidationText(model
                                              .acceptTermConditionErrorMessage),
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          20.0.giveHeight,
                                          model.isButtonBusy
                                              ? Utils.webLoader()
                                              : SubmitButton(
                                                  onPressed: () {
                                                    model
                                                        .addCreditLine(context);
                                                  },
                                                  width: 100,
                                                  height: 45,
                                                  isRadius: false,
                                                  text:
                                                      "Create credit line request",
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
