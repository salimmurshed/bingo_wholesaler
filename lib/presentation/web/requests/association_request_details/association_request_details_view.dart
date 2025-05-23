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
import '../../../../data_models/enums/status_name.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/internal_configuration_list_model.dart';
import '../../../widgets/utils_folder/validation_text.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../association_actions.dart';
import 'association_request_details_view_model.dart';

class AssociationRequestDetailsView extends StatelessWidget {
  const AssociationRequestDetailsView({super.key, this.id, this.uri});

  final String? id;
  final String? uri;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssociationRequestDetailsViewModel>.reactive(
        onViewModelReady: (AssociationRequestDetailsViewModel model) {
          model.prefill(id, context, uri);
        },
        viewModelBuilder: () => AssociationRequestDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: model.enrollment == UserTypeForWeb.wholesaler
                          ? "View Association Request Information"
                          : (uri == "wholesaler_request")
                              ? "View Wholesaler Association Request Information"
                              : "View Institution Association Request Information",
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
                              h1: model.enrollment == UserTypeForWeb.wholesaler
                                  ? "View Association Request Information"
                                  : (uri == "wholesaler_request")
                                      ? "View Wholesaler Association Request Information"
                                      : "View Institution Association Request Information",
                            ),
                          Container(
                            padding: AppPaddings.webBodyPadding,
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100.0.wp,
                                        child: Flex(
                                          direction: device == ScreenSize.small
                                              ? Axis.vertical
                                              : Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                NavButton(
                                                  isBottom: model.item == 0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .associationDetailsScreen_tab1,
                                                  onTap: () {
                                                    model.changeItem(0);
                                                  },
                                                ),
                                                NavButton(
                                                  isBottom: model.item == 1,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .associationDetailsScreen_tab2,
                                                  onTap: () {
                                                    model.changeItem(1);
                                                  },
                                                ),
                                                if (model.enrollment ==
                                                    UserTypeForWeb.wholesaler)
                                                  NavButton(
                                                    isBottom: model.item == 2,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .associationDetailsScreen_tab3,
                                                    onTap: () {
                                                      model.changeItem(2);
                                                    },
                                                  ),
                                                if (model.enrollment ==
                                                    UserTypeForWeb.wholesaler)
                                                  NavButton(
                                                    isBottom: model.item == 3,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .associationDetailsScreen_tab4,
                                                    onTap: () {
                                                      model.changeItem(3);
                                                    },
                                                  ),
                                              ],
                                            ),
                                            Flex(
                                              direction:
                                                  device == ScreenSize.small
                                                      ? Axis.vertical
                                                      : Axis.horizontal,
                                              children: [
                                                if (model.isButtonBusy)
                                                  Utils.webLoader(),
                                                if (!model.isButtonBusy)
                                                  if (model.item == 0)
                                                    model.enrollment ==
                                                            UserTypeForWeb
                                                                .wholesaler
                                                        ? Flex(
                                                            direction: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? Axis.vertical
                                                                : Axis
                                                                    .horizontal,
                                                            children: [
                                                              if (model.currentStatus !=
                                                                      StatusNames
                                                                          .rejected &&
                                                                  model.currentStatus !=
                                                                      StatusNames
                                                                          .inProcess)
                                                                SubmitButton(
                                                                  width: device ==
                                                                          ScreenSize
                                                                              .small
                                                                      ? 100.0.wp
                                                                      : 100,
                                                                  onPressed:
                                                                      () {
                                                                    if (model.currentStatus ==
                                                                            StatusNames
                                                                                .accepted ||
                                                                        model.currentStatus ==
                                                                            StatusNames
                                                                                .verified) {
                                                                      model.openActivationCodeDialog(
                                                                          3,
                                                                          context,
                                                                          uri!);
                                                                    } else if (model
                                                                            .currentStatus ==
                                                                        StatusNames
                                                                            .pending) {
                                                                      model.changeAction(
                                                                          context,
                                                                          AssociationActions
                                                                              .accepted,
                                                                          uri!);
                                                                    } else if (model
                                                                            .currentStatus ==
                                                                        StatusNames
                                                                            .completed) {
                                                                      model.changeAction(
                                                                          context,
                                                                          AssociationActions
                                                                              .approve,
                                                                          uri!);
                                                                    }
                                                                  },
                                                                  text: model.currentStatus ==
                                                                              StatusNames
                                                                                  .accepted ||
                                                                          model.currentStatus ==
                                                                              StatusNames
                                                                                  .verified
                                                                      ? AppLocalizations.of(
                                                                              context)!
                                                                          .activationCode
                                                                      : model.currentStatus ==
                                                                              StatusNames.pending
                                                                          ? AppLocalizations.of(context)!.accept
                                                                          : model.currentStatus == StatusNames.completed
                                                                              ? AppLocalizations.of(context)!.approve
                                                                              : "no",
                                                                  color: AppColors
                                                                      .webButtonColor,
                                                                  isRadius:
                                                                      false,
                                                                  height: 45.0,
                                                                ),
                                                              if (model
                                                                      .currentStatus !=
                                                                  StatusNames
                                                                      .rejected)
                                                                SubmitButton(
                                                                  onPressed:
                                                                      () {
                                                                    model.changeAction(
                                                                        context,
                                                                        AssociationActions
                                                                            .rejected,
                                                                        uri!);
                                                                  },
                                                                  isRadius:
                                                                      false,
                                                                  color: AppColors
                                                                      .redColor,
                                                                  width: device ==
                                                                          ScreenSize
                                                                              .small
                                                                      ? 100.0.wp
                                                                      : 100,
                                                                  height: 45,
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .reject,
                                                                ),
                                                            ],
                                                          )
                                                        : Flex(
                                                            direction: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? Axis.vertical
                                                                : Axis
                                                                    .horizontal,
                                                            children: [
                                                              if (model.currentStatus ==
                                                                      StatusNames
                                                                          .inProcess ||
                                                                  model.currentStatus ==
                                                                      StatusNames
                                                                          .verified)
                                                                SubmitButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (model.currentStatus ==
                                                                            StatusNames
                                                                                .accepted ||
                                                                        model.currentStatus ==
                                                                            StatusNames
                                                                                .verified) {
                                                                      model.openActivationCodeDialog(
                                                                          3,
                                                                          context,
                                                                          uri!);
                                                                    } else if (model
                                                                            .currentStatus ==
                                                                        StatusNames
                                                                            .pending) {
                                                                      model.changeAction(
                                                                          context,
                                                                          AssociationActions
                                                                              .accepted,
                                                                          uri!);
                                                                    } else if (model
                                                                            .currentStatus ==
                                                                        StatusNames
                                                                            .completed) {
                                                                      model.changeAction(
                                                                          context,
                                                                          AssociationActions
                                                                              .approve,
                                                                          uri!);
                                                                    }
                                                                  },
                                                                  text: model.currentStatus ==
                                                                          StatusNames
                                                                              .inProcess
                                                                      ? AppLocalizations.of(
                                                                              context)!
                                                                          .accept
                                                                      : model.currentStatus ==
                                                                              StatusNames.verified
                                                                          ? AppLocalizations.of(context)!.addActivationCode
                                                                          : "no",
                                                                  color: AppColors
                                                                      .webButtonColor,
                                                                  isRadius:
                                                                      false,
                                                                  height: 45.0,
                                                                  width: device ==
                                                                          ScreenSize
                                                                              .small
                                                                      ? 100.0.wp
                                                                      : 100,
                                                                ),
                                                              if (model.currentStatus !=
                                                                      StatusNames
                                                                          .rejected ||
                                                                  model.currentStatus !=
                                                                      StatusNames
                                                                          .completed)
                                                                SubmitButton(
                                                                  onPressed:
                                                                      () {
                                                                    model.changeAction(
                                                                        context,
                                                                        AssociationActions
                                                                            .rejected,
                                                                        uri!);
                                                                  },
                                                                  isRadius:
                                                                      false,
                                                                  color: AppColors
                                                                      .redColor,
                                                                  width: device ==
                                                                          ScreenSize
                                                                              .small
                                                                      ? 100.0.wp
                                                                      : 100,
                                                                  height: 45,
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .reject,
                                                                ),
                                                            ],
                                                          ),
                                                if (model.item != 0)
                                                  const SizedBox(),
                                                SubmitButton(
                                                  onPressed: () {
                                                    model.goToList(
                                                        context, uri!);
                                                  },
                                                  isRadius: false,
                                                  color:
                                                      AppColors.webButtonColor,
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 100.0.wp
                                                          : 100,
                                                  height: 45,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .viewAll,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      Flex(
                                        mainAxisAlignment: device ==
                                                ScreenSize.wide
                                            ? MainAxisAlignment.spaceBetween
                                            : MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            device == ScreenSize.wide
                                                ? CrossAxisAlignment.center
                                                : CrossAxisAlignment.start,
                                        direction: device == ScreenSize.wide
                                            ? Axis.horizontal
                                            : Axis.vertical,
                                        children: [
                                          Text(
                                            model.item == 0
                                                ? AppLocalizations.of(context)!
                                                    .associationDetailsScreen_tab1
                                                : model.item == 1
                                                    ? (model.enrollment ==
                                                            UserTypeForWeb
                                                                .wholesaler
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .associationDetailsScreen_tab2Title
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .associationDetailsScreen_tab2)
                                                    : model.item == 2
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .associationDetailsScreen_tab3
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .associationDetailsScreen_tab4,
                                            style: AppTextStyles.headerText,
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                      model.item == 0
                                          ? tab1(model, context)
                                          : model.item == 1
                                              ? tab2(model, context)
                                              : model.item == 2
                                                  ? tab3(model, context)
                                                  : tab4(model, context)
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

  SizedBox tab1(
      AssociationRequestDetailsViewModel model, BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Wrap(
        runSpacing: 20.0,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          model.enrollment == UserTypeForWeb.retailer
              ? field(model.companyNameController,
                  AppLocalizations.of(context)!.companyName.isRequired, context,
                  width: 45.0.wp)
              : field(
                  model.retailerNameController,
                  AppLocalizations.of(context)!.retailerName.isRequired,
                  context),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              child: SelectedDropdown(
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
                style: AppTextStyles.formFieldTextStyle,
                isDisable: true,
                hintText: AppLocalizations.of(context)!.taxIdType,
                dropdownValue: model.selectedTaxIdType,
                fieldName: AppLocalizations.of(context)!.taxIdType.isRequired,
                items: [
                  for (var i = 0; i < model.taxIdType.length; i++)
                    DropdownMenuItem<String>(
                      value: model.taxIdType[0],
                      child: Text(model.taxIdType[0]),
                    )
                ],
                onChange: (Object? v) {},
              ),
            ),
          field(model.taxIdController,
              AppLocalizations.of(context)!.taxId.isRequired, context,
              width: model.enrollment == UserTypeForWeb.retailer
                  ? 45.0.wp
                  : 30.0.wp),
          model.enrollment == UserTypeForWeb.retailer
              ? field(
                  isCalender: true,
                  model.associationDateController,
                  AppLocalizations.of(context)!.associationDate.isRequired,
                  context,
                  width: 45.0.wp)
              : field(
                  model.phoneController,
                  AppLocalizations.of(context)!.phoneNumber.isRequired,
                  context),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              child: SelectedDropdown(
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
                style: AppTextStyles.formFieldTextStyle,
                isDisable: true,
                fieldName: AppLocalizations.of(context)!.category.isRequired,
                hintText: AppLocalizations.of(context)!.category,
                dropdownValue: model.selectedCategory,
                items: [
                  for (var i = 0; i < model.category.length; i++)
                    DropdownMenuItem<String>(
                      value: model.category[0],
                      child: Text(model.category[0]),
                    )
                ],
                onChange: (Object? v) {},
              ),
            ),
          if (device != ScreenSize.small)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
            ),
          SizedBox(
            width: 100.0.wp,
            child: NameTextField(
                readOnly: true,
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
                style: AppTextStyles.formFieldTextStyle,
                controller: model.addressController,
                fieldName:
                    AppLocalizations.of(context)!.companyAddress.isRequired),
          ),
          const Divider(
            color: AppColors.dividerColor,
          ),
          SubmitButton(
            color: model.enrollment == UserTypeForWeb.retailer
                ? AppColors.webButtonColor
                : AppColors.bingoGreen,
            width: 60,
            height: 45,
            isRadius: false,
            text: "${AppLocalizations.of(context)!.nextButton} >",
            onPressed: model.nextItem,
          )
        ],
      ),
    );
  }

  SizedBox tab2(
      AssociationRequestDetailsViewModel model, BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Wrap(
        runSpacing: 20.0,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          field(model.firstNameController,
              AppLocalizations.of(context)!.firstName.isRequired, context),
          field(model.lastNameController,
              AppLocalizations.of(context)!.lastName.isRequired, context),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            field(model.emailController,
                AppLocalizations.of(context)!.email.isRequired, context),
          if (model.enrollment == UserTypeForWeb.retailer)
            field(model.positionController,
                AppLocalizations.of(context)!.position.isRequired, context),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              child: SelectedDropdown(
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
                style: AppTextStyles.formFieldTextStyle,
                isDisable: true,
                fieldName: AppLocalizations.of(context)!.idType.isRequired,
                hintText: AppLocalizations.of(context)!.idType,
                dropdownValue: model.selectedIdType,
                items: [
                  for (var i = 0; i < model.idType.length; i++)
                    DropdownMenuItem<String>(
                      value: model.idType[0],
                      child: Text(model.idType[0]),
                    )
                ],
                onChange: (Object? v) {},
              ),
            ),
          field(model.idController, AppLocalizations.of(context)!.id.isRequired,
              context),
          field(model.phoneController,
              AppLocalizations.of(context)!.phoneNumber.isRequired, context),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              child: SelectedDropdown(
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
                style: AppTextStyles.formFieldTextStyle,
                isDisable: true,
                fieldName: AppLocalizations.of(context)!.country.isRequired,
                hintText: AppLocalizations.of(context)!.country,
                dropdownValue: model.selectedCountry,
                items: [
                  for (var i = 0; i < model.country.length; i++)
                    DropdownMenuItem<String>(
                      value: model.country[0],
                      child: Text(model.country[0]),
                    )
                ],
                onChange: (Object? v) {},
              ),
            ),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              child: SelectedDropdown(
                hintStyle: AppTextStyles.formTitleTextStyleNormal,
                style: AppTextStyles.formFieldTextStyle,
                isDisable: true,
                fieldName: AppLocalizations.of(context)!.city.isRequired,
                hintText: AppLocalizations.of(context)!.city,
                dropdownValue: model.selectedCity,
                items: [
                  for (var i = 0; i < model.city.length; i++)
                    DropdownMenuItem<String>(
                      value: model.city[0],
                      child: Text(model.city[0]),
                    )
                ],
                onChange: (Object? v) {},
              ),
            ),
          if (model.enrollment == UserTypeForWeb.retailer)
            if (device != ScreenSize.small)
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              ),
          if (model.enrollment == UserTypeForWeb.wholesaler)
            field(model.positionController,
                AppLocalizations.of(context)!.position.isRequired, context),
          SubmitButton(
            width: 60,
            height: 35,
            isRadius: true,
            color: AppColors.webButtonColor,
            text: AppLocalizations.of(context)!.viewDocuments,
            onPressed: model.viewDocuments,
          ),
          const Divider(
            color: AppColors.dividerColor,
          ),
          Row(
            children: [
              SubmitButton(
                width: 60,
                height: 45,
                isRadius: false,
                color: AppColors.webButtonColor,
                text: "< ${AppLocalizations.of(context)!.backButton}",
                onPressed: model.previousItem,
              ),
              if (model.enrollment == UserTypeForWeb.wholesaler)
                SubmitButton(
                  width: 60,
                  height: 45,
                  isRadius: false,
                  text: "${AppLocalizations.of(context)!.nextButton} >",
                  onPressed: model.nextItem,
                ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox tab3(
      AssociationRequestDetailsViewModel model, BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.0.wp,
            child: Wrap(
              runSpacing: 20.0,
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    field(
                        readOnly: false,
                        model.internalIdController,
                        AppLocalizations.of(context)!.internalID.isRequired,
                        context),
                    if (model.internalIdValidation.isNotEmpty)
                      ValidationText(model.internalIdValidation)
                  ],
                ),
                SizedBox(
                  width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectedDropdown(
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        fieldName: AppLocalizations.of(context)!
                            .customerType
                            .isRequired,
                        hintText: AppLocalizations.of(context)!.customerType,
                        dropdownValue: model.selectedCustomerType,
                        items: [
                          for (var i = 0; i < model.customerType.length; i++)
                            DropdownMenuItem<CustomerType>(
                              value: model.customerType[i],
                              child: Text(model.customerType[i].customerType!),
                            )
                        ],
                        onChange: (CustomerType? v) {
                          model.changeInternalInformationCustomerType(v!);
                        },
                      ),
                      if (model.customerTypeValidation.isNotEmpty)
                        ValidationText(model.customerTypeValidation)
                    ],
                  ),
                ),
                SizedBox(
                  width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectedDropdown(
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        fieldName: AppLocalizations.of(context)!
                            .gracePeriodGroups
                            .isRequired,
                        hintText:
                            AppLocalizations.of(context)!.gracePeriodGroups,
                        dropdownValue: model.selectedGracePeriod,
                        items: [
                          for (var i = 0; i < model.gracePeriod.length; i++)
                            DropdownMenuItem<GracePeriod>(
                              value: model.gracePeriod[i],
                              child:
                                  Text(model.gracePeriod[i].gracePeriodGroup!),
                            )
                        ],
                        onChange: (GracePeriod? v) {
                          model.changeInternalInformationGracePeriod(v);
                        },
                      ),
                      if (model.gracePeriodValidation.isNotEmpty)
                        ValidationText(model.gracePeriodValidation)
                    ],
                  ),
                ),
                SizedBox(
                  width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectedDropdown(
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        fieldName: AppLocalizations.of(context)!
                            .pricingGroups
                            .isRequired,
                        hintText: AppLocalizations.of(context)!.pricingGroups,
                        dropdownValue: model.selectedPricingGroup,
                        items: [
                          for (var i = 0; i < model.pricingGroup.length; i++)
                            DropdownMenuItem<PricingGroups>(
                              value: model.pricingGroup[i],
                              child: Text(model.pricingGroup[i].pricingGroups!),
                            )
                        ],
                        onChange: (PricingGroups? v) {
                          model.changeInternalInformationPricingGroup(v);
                        },
                      ),
                      if (model.pricingGroupValidation.isNotEmpty)
                        ValidationText(model.pricingGroupValidation)
                    ],
                  ),
                ),
                SizedBox(
                  width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectedDropdown(
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        fieldName:
                            AppLocalizations.of(context)!.salesZone.isRequired,
                        hintText: AppLocalizations.of(context)!.salesZone,
                        dropdownValue: model.selectedSalesZone,
                        items: [
                          for (var i = 0; i < model.salesZone.length; i++)
                            DropdownMenuItem<SaleZones>(
                              value: model.salesZone[i],
                              child: Text(model.salesZone[i].zoneName!),
                            )
                        ],
                        onChange: (SaleZones? v) {
                          model.changeInternalInformationSaleZones(v);
                        },
                      ),
                      if (model.salesZoneValidation.isNotEmpty)
                        ValidationText(model.salesZoneValidation)
                    ],
                  ),
                ),
                SizedBox(
                  width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectedDropdown(
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        fieldName: AppLocalizations.of(context)!
                            .allowOrders
                            .isRequired,
                        hintText: AppLocalizations.of(context)!.allowOrders,
                        dropdownValue: model.selectedAllowOrders,
                        items: [
                          for (var i = 0; i < model.allowOrders.length; i++)
                            DropdownMenuItem<String>(
                              value: model.allowOrders[i],
                              child: Text(model.allowOrders[i]),
                            )
                        ],
                        onChange: (String? v) {
                          model.changeInternalInformationAllowOrder(v);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          20.0.giveHeight,
          Text(
            AppLocalizations.of(context)!.viewRetailerStores,
            style: AppTextStyles.headerText,
          ),
          const Divider(
            color: AppColors.dividerColor,
          ),
          Scrollbar(
            controller: model.scrollController,
            thickness: 10,
            child: SingleChildScrollView(
              controller: model.scrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: device != ScreenSize.wide ? null : 100.0.wp - 64 - 64,
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: AppColors.tableHeaderBody),
                  columnWidths: {
                    0: const FixedColumnWidth(70.0),
                    1: device != ScreenSize.wide
                        ? const FixedColumnWidth(120.0)
                        : const FlexColumnWidth(),
                    2: const FixedColumnWidth(200.0),
                    3: device != ScreenSize.wide
                        ? const FixedColumnWidth(200.0)
                        : const FlexColumnWidth(),
                    4: const FixedColumnWidth(200.0),
                  },
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(
                        color: AppColors.tableHeaderColor,
                      ),
                      children: [
                        dataCellHd(AppLocalizations.of(context)!.table_srNO),
                        dataCellHd(
                            AppLocalizations.of(context)!.table_storeName),
                        dataCellHd(
                            AppLocalizations.of(context)!.table_location),
                        dataCellHd(AppLocalizations.of(context)!
                            .table_wholesalerStoreId),
                        dataCellHd(
                            AppLocalizations.of(context)!.table_salesZone),
                      ],
                    ),
                    for (int i = 0;
                        i <
                            model.data!.data![0].internalInformation![0]
                                .retailerStoreDetails!.length;
                        i++)
                      TableRow(
                        decoration: BoxDecoration(
                          border: Utils.tableBorder,
                          color: AppColors.whiteColor,
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: dataCell(
                              "${1 + i}",
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: dataCell(
                              model.data!.data![0].internalInformation![0]
                                  .retailerStoreDetails![i].storeName!,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: dataCell(
                              model.data!.data![0].internalInformation![0]
                                  .retailerStoreDetails![i].location!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NameTextField(
                                  controller: model.storeIdListController[i],
                                  hintText: "Wholesaler Store Id",
                                  hintStyle:
                                      AppTextStyles.formTitleTextStyleNormal,
                                ),
                                if (model
                                    .storeWholesalerIdValidations[i].isNotEmpty)
                                  ValidationText(
                                      model.storeWholesalerIdValidations[i])
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectedDropdown(
                                  hintStyle:
                                      AppTextStyles.formTitleTextStyleNormal,
                                  style: AppTextStyles.formFieldTextStyle,
                                  dropdownValue: model.storeSaleZoneList[i],
                                  items: [
                                    for (var i = 0;
                                        i < model.salesZone.length;
                                        i++)
                                      DropdownMenuItem<SaleZones>(
                                        value: model.salesZone[i],
                                        child:
                                            Text(model.salesZone[i].zoneName!),
                                      )
                                  ],
                                  onChange: (SaleZones v) {
                                    model.changeStoreSaleZone(i, v);
                                  },
                                ),
                                if (model
                                    .storeSaleZoneValidations[i].isNotEmpty)
                                  ValidationText(
                                      model.storeSaleZoneValidations[i])
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            color: AppColors.dividerColor,
          ),
          Row(
            children: [
              SubmitButton(
                width: 60,
                height: 45,
                isRadius: false,
                color: AppColors.webButtonColor,
                text: "< ${AppLocalizations.of(context)!.backButton}",
                onPressed: model.previousItem,
              ),
              SubmitButton(
                width: 60,
                height: 45,
                isRadius: false,
                text: "${AppLocalizations.of(context)!.nextButton} >",
                onPressed: model.nextItem,
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox tab4(
      AssociationRequestDetailsViewModel model, BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Wrap(
        runSpacing: 20.0,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: model.changeCustomerSinceDate,
            child: AbsorbPointer(
              child: field(
                  isCalender: true,
                  model.customerSinceDateController,
                  AppLocalizations.of(context)!.customerSinceDate.isRequired,
                  context,
                  validation: model.customerSinceDateValidation),
            ),
          ),
          field(
              readOnly: false,
              model.monthlySaleController,
              AppLocalizations.of(context)!.monthlySales.isRequired,
              context,
              isDouble: true,
              validation: model.monthlySalesValidation),
          field(
              readOnly: false,
              model.averageTicketController,
              AppLocalizations.of(context)!.averageSalesTicket.isRequired,
              context,
              isDouble: true,
              validation: model.averageSalesValidation),
          SizedBox(
            width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectedDropdown(
                  hintStyle: AppTextStyles.formTitleTextStyleNormal,
                  style: AppTextStyles.formFieldTextStyle,
                  hintText: AppLocalizations.of(context)!.visitFrequency,
                  dropdownValue: model.selectedVisitFrequency,
                  fieldName:
                      AppLocalizations.of(context)!.visitFrequency.isRequired,
                  items: [
                    for (var i = 0; i < model.visitFrequency.length; i++)
                      DropdownMenuItem<VisitFrequentListModel>(
                        value: model.visitFrequency[i],
                        child: Text(StatusFile.visitFrequent(
                            'en', model.visitFrequency[i].id!)),
                      )
                  ],
                  onChange: (VisitFrequentListModel? v) {
                    model.changeSelectedVisitFrequency(v);
                  },
                ),
                if (model.visitFrequencyValidation.isNotEmpty)
                  ValidationText(model.visitFrequencyValidation)
              ],
            ),
          ),
          field(
              readOnly: false,
              model.suggestedCreditLineAmountController,
              AppLocalizations.of(context)!
                  .suggestedCreditLineAmount
                  .isRequired,
              context,
              isDouble: true,
              validation: model.suggestCreditLineValidation),
          if (device != ScreenSize.small)
            SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
            ),
          const Divider(
            color: AppColors.dividerColor,
          ),
          model.isButtonBusy
              ? Utils.webLoader()
              : Row(
                  children: [
                    SubmitButton(
                      width: 60,
                      height: 45,
                      isRadius: false,
                      color: AppColors.webButtonColor,
                      text: "< ${AppLocalizations.of(context)!.backButton}",
                      onPressed: model.previousItem,
                    ),
                    SubmitButton(
                      width: 60,
                      height: 45,
                      isRadius: false,
                      text: AppLocalizations.of(context)!.setPricing,
                      onPressed: model.setPricing,
                    ),
                  ],
                )
        ],
      ),
    );
  }

  SizedBox field(
      TextEditingController controller, String title, BuildContext context,
      {double? width,
      String? validation,
      bool readOnly = true,
      bool isDouble = false,
      bool isCalender = false,
      Widget? widget}) {
    return SizedBox(
      width: device == ScreenSize.small ? 80.0.wp : width ?? 30.0.wp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameTextField(
              widget: widget,
              isCalender: isCalender,
              isFloat: isDouble,
              readOnly: readOnly,
              hintStyle: AppTextStyles.formTitleTextStyleNormal,
              style: AppTextStyles.formFieldTextStyle,
              controller: controller,
              hintText: title.replaceAll("*", ""),
              fieldName: title),
          if (validation != null)
            if (validation.isNotEmpty) ValidationText(validation)
        ],
      ),
    );
  }
}
