import 'dart:convert';

import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../../const/all_const.dart';
import '../../../../../const/app_styles/app_box_decoration.dart';
import '../../../../../const/utils.dart';
import '../../../../../const/web_devices.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/component_models/tax_id_type_model.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/dropdowns/custom_searchable_dropdown.dart';
import '../../../../widgets/text_fields/name_text_field.dart';
import '../../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import 'add_user_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({this.id, super.key});

  final String? id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddUserViewModel>.reactive(
        onViewModelReady: (AddUserViewModel model) {
          model.editUserCheck(id);
        },
        viewModelBuilder: () => AddUserViewModel(),
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
                      h1: model.isEdit ? 'Edit User' : 'Add User',
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
                              h1: model.isEdit ? 'Edit User' : 'Add User',
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
                                          const Text(
                                            'User',
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
                                                // Navigator.pop(context);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 45.0.wp,
                                                child: NameTextField(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    style: AppTextStyles
                                                        .formFieldTextStyle,
                                                    controller: model
                                                        .firstNameController,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .firstName
                                                            .isRequired),
                                              ),
                                              Utils.errorShow(
                                                  model.errorFirstNameMessage),
                                            ],
                                          ),
                                          if (device != ScreenSize.small)
                                            20.0.giveWidth,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                      hintStyle: AppTextStyles
                                                          .formTitleTextStyleNormal,
                                                      style: AppTextStyles
                                                          .formFieldTextStyle,
                                                      controller: model
                                                          .lastNameController,
                                                      fieldName:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .lastName
                                                              .isRequired)),
                                              Utils.errorShow(
                                                  model.errorLastNameMessage),
                                            ],
                                          ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 90.0.wp +
                                                (device == ScreenSize.small
                                                    ? 0
                                                    : 20),
                                            child: NameTextField(
                                                hintStyle: AppTextStyles
                                                    .formTitleTextStyleNormal,
                                                style: AppTextStyles
                                                    .formFieldTextStyle,
                                                controller:
                                                    model.emailNameController,
                                                fieldName: AppLocalizations.of(
                                                        context)!
                                                    .email
                                                    .isRequired),
                                          ),
                                          Utils.errorShow(
                                              model.errorEmailNameMessage),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : model.enrollment ==
                                                                UserTypeForWeb
                                                                    .retailer
                                                            ? (90.0.wp - 20) / 3
                                                            : 45.0.wp,
                                                child: SelectedDropdown<
                                                        TaxIdTypeData>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    style: AppTextStyles
                                                        .formFieldTextStyle,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .idType,
                                                    dropdownValue:
                                                        model.selectedTaxIdType,
                                                    items: model.taxIdTypeData
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                TaxIdTypeData>(
                                                              value: e,
                                                              child: Text(
                                                                  e.taxIdType!),
                                                            ))
                                                        .toList(),
                                                    onChange:
                                                        (TaxIdTypeData v) {
                                                      model.selectID(v);
                                                    }),
                                              ),
                                              Utils.errorShow(
                                                  model.errorIdTypeMessage),
                                            ],
                                          ),
                                          if (device != ScreenSize.small)
                                            20.0.giveWidth,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: device ==
                                                          ScreenSize.small
                                                      ? 80.0.wp
                                                      : model.enrollment ==
                                                              UserTypeForWeb
                                                                  .retailer
                                                          ? (90.0.wp - 20) / 3
                                                          : 45.0.wp,
                                                  child: NameTextField(
                                                      style: AppTextStyles
                                                          .formFieldTextStyle,
                                                      hintStyle: AppTextStyles
                                                          .formTitleTextStyleNormal,
                                                      controller: model
                                                          .idDocumentNameController,
                                                      fieldName:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .idDocument
                                                              .isRequired)),
                                              Utils.errorShow(
                                                  model.errorIdDocNameMessage),
                                            ],
                                          ),
                                          if (model.enrollment ==
                                              UserTypeForWeb.retailer)
                                            if (device != ScreenSize.small)
                                              20.0.giveWidth,
                                          if (model.enrollment ==
                                              UserTypeForWeb.retailer)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CommonText(
                                                  ("${AppLocalizations.of(context)!.selectStore}s")
                                                      .isRequired,
                                                  style: AppTextStyles
                                                      .formFieldTextStyle,
                                                ),
                                                5.0.giveHeight,
                                                Container(
                                                  decoration: AppBoxDecoration
                                                      .borderDecoration
                                                      .copyWith(
                                                          color: AppColors
                                                              .whiteColor),
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : (90.0.wp - 20) / 3,
                                                  // height: 70,
                                                  child:
                                                      CustomSearchableDropDown(
                                                    initialValue:
                                                        model.dataStore,
                                                    close: (i) {
                                                      model.removeStoreItem(i);
                                                    },
                                                    dropdownHintText:
                                                        "${AppLocalizations.of(context)!.selectStore}s",
                                                    showLabelInMenu: false,
                                                    multiSelect: true,
                                                    multiSelectTag: true,
                                                    primaryColor:
                                                        AppColors.disableColor,
                                                    menuMode: true,
                                                    labelStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    items: jsonDecode(
                                                        jsonEncode(
                                                            model.storeList)),
                                                    label:
                                                        "${AppLocalizations.of(context)!.selectStore}s",
                                                    dropDownMenuItems:
                                                        jsonDecode(jsonEncode(
                                                                model
                                                                    .storeList))
                                                            .map((item) {
                                                      return '${item['name']}-${item['unique_id']}';
                                                    }).toList(),
                                                    onChanged: (List value) {
                                                      model.putSelectedUserList(
                                                          value);
                                                    },
                                                  ),
                                                ),
                                                Utils.errorShow(
                                                    model.errorStoreMessage),
                                              ],
                                            ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        direction: device == ScreenSize.small
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonText(
                                                AppLocalizations.of(context)!
                                                    .role
                                                    .isRequired,
                                                style: AppTextStyles
                                                    .formFieldTextStyle,
                                              ),
                                              5.0.giveHeight,
                                              Container(
                                                decoration: AppBoxDecoration
                                                    .borderDecoration
                                                    .copyWith(
                                                        color: AppColors
                                                            .whiteColor),
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 45.0.wp,
                                                child: CustomSearchableDropDown(
                                                  labelStyle: AppTextStyles
                                                      .successStyle,
                                                  initialValue: model.dataRole,
                                                  close: (String i) {
                                                    model.removeRoleItem(i);
                                                  },
                                                  dropdownHintText:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .role,
                                                  showLabelInMenu: false,
                                                  multiSelect: true,
                                                  // multiSelectTag: 'role_name',
                                                  primaryColor:
                                                      AppColors.disableColor,
                                                  menuMode: true,
                                                  // labelStyle: const TextStyle(
                                                  //     color: Colors.blue,
                                                  //     fontWeight:
                                                  //         FontWeight.bold),
                                                  items: jsonDecode(jsonEncode(
                                                      model.roleList)),
                                                  label: "role_name",
                                                  dropDownMenuItems: jsonDecode(
                                                          jsonEncode(
                                                              model.roleList))
                                                      .map((item) {
                                                    return item['role_name'];
                                                  }).toList(),
                                                  // getValue: (List value) {
                                                  //   model.putSelectedRoleList(
                                                  //       value);
                                                  // },
                                                  onChanged: (List value) {
                                                    model.putSelectedRoleList(
                                                        value);
                                                  },
                                                ),
                                              ),
                                              Utils.errorShow(
                                                  model.errorRoleMessage),
                                            ],
                                          ),
                                          if (device != ScreenSize.small)
                                            10.0.giveWidth,
                                          Column(
                                            children: [
                                              SizedBox(
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 45.0.wp,
                                                child: SelectedDropdown(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    style: AppTextStyles
                                                        .formFieldTextStyle,
                                                    fieldName:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .status,
                                                    dropdownValue:
                                                        model.selectedStatus,
                                                    items: model.status
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: e,
                                                              child: Text(e),
                                                            ))
                                                        .toList(),
                                                    onChange: (v) {
                                                      model.selectStatus(v);
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      20.0.giveHeight,
                                      model.isButtonBusy
                                          ? SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 150,
                                              height: 45,
                                              child: Center(
                                                child: Utils.loaderBusy(),
                                              ),
                                            )
                                          : SubmitButton(
                                              color: AppColors.bingoGreen,
                                              isRadius: false,
                                              text: model.isEdit
                                                  ? "Update User"
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .addUser,
                                              // color: AppColors.webButtonColor,
                                              onPressed: () {
                                                model.addEditUser(context);
                                              },
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 140,
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
