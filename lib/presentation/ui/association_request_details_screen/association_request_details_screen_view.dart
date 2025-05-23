import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/utils_folder/validation_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_extensions/widgets_extensions.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/utils.dart';
import '/data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '/presentation/ui/home_screen/home_screen_view_model.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/loader/loader.dart';
import '/presentation/widgets/cards/sales_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/server_status_file/server_status_file.dart';
import '../../../data_models/enums/status_name.dart';
import '../../../data_models/models/association_wholesaler_equest_details_model/association_wholesaler_equest_details_model.dart';
import '../../../data_models/models/component_models/sales_zone_model.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'association_request_details_screen_view_model.dart';

class AssociationRequestDetailsScreen extends StatelessWidget {
  const AssociationRequestDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssociationRequestDetailsScreenModel>.reactive(
        onViewModelReady: (AssociationRequestDetailsScreenModel model) {
          model
              .callDetails(ModalRoute.of(context)!.settings.arguments as GetId);
        },
        viewModelBuilder: () => AssociationRequestDetailsScreenModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppAsset.searchIcon),
                ),
                15.0.giveWidth,
              ],
              leading: IconButton(
                onPressed: model.gotoBackScreen,
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.background,
                ),
              ),
              title: AppBarText(
                  AppLocalizations.of(context)!.requestsDetail.toUpperCase()),
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
            ),
            body:
                //ShimmerScreen(number: 2),

                model.setScreenBusy
                    ? SizedBox(
                        width: 100.0.wp,
                        height: 100.0.hp,
                        child: const Center(
                          child: LoaderWidget(),
                        ),
                      )
                    : model.enrollment == UserTypeForWeb.retailer
                        ? retailersBody(model, context)
                        : wholesalerBody(model, context),
          );
        });
  }

  Widget retailersBody(AssociationRequestDetailsScreenModel model, context) {
    return Stack(
      children: [
        Padding(
          padding: AppPaddings.bodyVertical,
          child: RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorWholesaler,
            onRefresh: model.isFie
                ? model.refreshFieDetail
                : model.refreshWholesalerDetail,
            child: SingleChildScrollView(
              physics: Utils.pullScrollPhysic,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Utils.commonText(
                      needPadding: true,
                      AppLocalizations.of(context)!.companyInformation),
                  Utils.cardToTextGaps(),
                  ShadowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Utils.commonText(
                            needPadding: false,
                            "${model.companyInformationRetails.companyName}"),
                        18.0.giveHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils.getNiceText(
                                "${AppLocalizations.of(context)!.taxId}:${model.companyInformationRetails.taxId}",
                                nxtln: true),
                            Utils.getNiceText(
                                "${AppLocalizations.of(context)!.requestDate}:${model.companyInformationRetails.associationDate}",
                                nxtln: true),
                          ],
                        ),
                        12.0.giveHeight,
                        SizedBox(
                          width: 319.0,
                          child: Utils.getNiceText(
                              "${AppLocalizations.of(context)!.companyAddress}:${model.companyInformationRetails.companyAddress}",
                              nxtln: true),
                        ),
                      ],
                    ),
                  ),
                  Utils.cardGaps(),
                  Utils.commonText(
                      needPadding: true,
                      AppLocalizations.of(context)!.contactInformation),
                  Utils.cardToTextGaps(),
                  ShadowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40.0.wp,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Utils.getNiceText(
                                      "${AppLocalizations.of(context)!.firstName}:${model.contactInformationRetails.firstName!.emptyCheck()}",
                                      nxtln: true),
                                  15.0.giveHeight,
                                  Utils.getNiceText(
                                      "${AppLocalizations.of(context)!.position}:${model.contactInformationRetails.position!.emptyCheck()}",
                                      nxtln: true),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Utils.getNiceText(
                                    "${AppLocalizations.of(context)!.lastName}:${model.contactInformationRetails.lastName!.emptyCheck()}",
                                    nxtln: true),
                                15.0.giveHeight,
                              ],
                            ),
                          ],
                        ),
                        15.0.giveHeight,
                        Utils.getNiceText(
                            "${AppLocalizations.of(context)!.companyAddress}:${model.companyInformationRetails.companyAddress!.emptyCheck()}",
                            nxtln: true),
                      ],
                    ),
                  ),
                  if (model.companyInformationRetails.status != null)
                    if (model.companyInformationRetails.status!.toLowerCase() ==
                        (StatusNames.verified).name)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          32.0.giveHeight,
                          Align(
                            alignment: Alignment.topCenter,
                            child: SubmitButton(
                              onPressed: () {
                                model.openActivationCodeSubmitForRetailerDialog(
                                    3);
                              },
                              width: 325.0,
                              height: 45.0,
                              active: true,
                              text:
                                  AppLocalizations.of(context)!.activationCode,
                            ),
                          ),
                        ],
                      )
                ],
              ),
            ),
          ),
        ),
        if (model.isBusy) const LoaderWidget()
      ],
    );
  }

  Widget wholesalerBody(AssociationRequestDetailsScreenModel model, context) {
    return Stack(
      children: [
        Padding(
          padding: AppPaddings.bodyVertical,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.commonText(
                        needPadding: false,
                        model.companyInformation!.retailerName!,
                        style: AppTextStyles.dashboardHeadBoldTitle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const Divider(
                        color: AppColors.dividerColor,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${AppLocalizations.of(context)!.status}:"),
                          SizedBox(
                            width: 100.0.wp,
                            child: Center(
                              child: statusNamesEnumFromServer(
                                      "${model.companyInformation!.status}")
                                  .toStatus(
                                      isCenter: true,
                                      textStyle:
                                          AppTextStyles.statusCardStatus),
                            ),
                          )
                        ],
                      ),
                      const Divider(color: AppColors.dividerColor),
                      SalesDetails(
                        data: [
                          "${AppLocalizations.of(context)!.taxIdType}: ${model.companyInformation!.taxIdType}",
                          "${AppLocalizations.of(context)!.taxId}: ${model.companyInformation!.taxId}",
                          "${AppLocalizations.of(context)!.phoneNumber}: ${model.companyInformation!.phoneNumber}",
                          "${AppLocalizations.of(context)!.category}: ${model.companyInformation!.category}",
                          "${AppLocalizations.of(context)!.companyAddress}: ${model.companyInformation!.companyAddress}",
                        ],
                      ),
                      30.0.giveHeight,
                      if (model.companyInformation!.status!.toLowerCase() ==
                          (StatusNames.accepted).name)
                        Center(
                          child: SubmitButton(
                            onPressed: () {
                              model.openActivationCodeDialog(3);
                            },
                            text: AppLocalizations.of(context)!.activationCode,
                            height: 45.0,
                            width: 325.0,
                          ),
                        ),
                      if (model.companyInformation!.status!.toLowerCase() ==
                          (StatusNames.verified).name)
                        Center(
                          child: SubmitButton(
                            onPressed: () {
                              model.openActivationCodeDialog(3);
                            },
                            text: AppLocalizations.of(context)!.activationCode,
                            height: 45.0,
                            width: 325.0,
                          ),
                        ),
                      // 30.0.giveHeight,
                    ],
                  ),
                ),
                Utils.cardGaps(),
                Utils.commonText(
                    AppLocalizations.of(context)!.ownerLegalRepresentative,
                    style: AppTextStyles.headerText,
                    needPadding: true),
                Utils.cardToTextGaps(),
                ShadowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SalesDetails(
                        data: [
                          "${AppLocalizations.of(context)!.firstName}: ${model.contactInformation!.firstName}",
                          "${AppLocalizations.of(context)!.lastName}: ${model.contactInformation!.lastName}",
                          "${AppLocalizations.of(context)!.email}: ${model.contactInformation!.email}",
                          "${AppLocalizations.of(context)!.idType}: ${model.contactInformation!.idType}",
                          "${AppLocalizations.of(context)!.id}: ${model.contactInformation!.id}",
                          "${AppLocalizations.of(context)!.phoneNumber}: ${model.contactInformation!.phoneNumber}",
                          "${AppLocalizations.of(context)!.country}: ${model.contactInformation!.country}",
                          "${AppLocalizations.of(context)!.city}: ${model.contactInformation!.city}",
                          "${AppLocalizations.of(context)!.position}: ${model.contactInformation!.position}",
                        ],
                      ),
                      if (model.contactInformation!.companyDocument!.isNotEmpty)
                        SubmitButton(
                          onPressed: model.changeViewDocumentOpen,
                          color: !model.isViewDocumentOpen
                              ? AppColors.activeButtonColor
                              : AppColors.toggleConfirmed,
                          height: 30.0,
                          width: 123.0,
                          text: AppLocalizations.of(context)!.viewDocuments,
                        ),
                      if (model.isViewDocumentOpen) 10.0.giveHeight,
                      if (model.isViewDocumentOpen)
                        SizedBox(
                          width: 100.0.wp,
                          child: Wrap(
                            runSpacing: 10.0,
                            spacing: 10.0,
                            runAlignment: WrapAlignment.spaceBetween,
                            children: [
                              for (CompanyDocument doc
                                  in model.contactInformation!.companyDocument!)
                                if (doc.url!.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      if (doc.url != null ||
                                          doc.url!.isNotEmpty) {
                                        model.launchInBrowser(
                                            Uri.parse(doc.url!));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.borderColors,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      height: 100.0,
                                      width: 100.0,
                                      child: Center(
                                        child: Text(doc.name!),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
                Utils.cardGaps(),
                Utils.commonText(
                  AppLocalizations.of(context)!.internalInformation,
                  style: AppTextStyles.headerText,
                  needPadding: true,
                ),
                Utils.cardToTextGaps(),
                ShadowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameTextField(
                        enable: false,
                        controller: model.internalIdController,
                        fieldName: AppLocalizations.of(context)!.internalID,
                      ),
                      if (model.internalIdValidation != "")
                        ValidationText(model.internalIdValidation),
                      24.0.giveHeight,
                      SelectedDropdown<String>(
                        isDisable: true,
                        hintText:
                            AppLocalizations.of(context)!.selectCustomerType,
                        fieldName:
                            AppLocalizations.of(context)!.selectCustomerType,
                        items: model.customerType
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        dropdownValue: model.selectedCustomerType,
                        onChange: (String value) {
                          model.changeCustomerType(value);
                        },
                      ),
                      if (model.selectedCustomerTypeValidation != "")
                        ValidationText(model.selectedCustomerTypeValidation),
                      24.0.giveHeight,
                      SelectedDropdown<String>(
                        isDisable: true,
                        fieldName:
                            AppLocalizations.of(context)!.gracePeriodGroups,
                        hintText:
                            AppLocalizations.of(context)!.gracePeriodGroups,
                        items: model.gracePeriodGroup
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        dropdownValue: model.selectedGracePeriodGroups,
                        onChange: (String value) {
                          model.changeGracePeriodGroups(value);
                        },
                      ),
                      if (model.selectedGracePeriodGroupsValidation != "")
                        ValidationText(
                            model.selectedGracePeriodGroupsValidation),
                      24.0.giveHeight,
                      SelectedDropdown<String>(
                        isDisable: true,
                        fieldName: AppLocalizations.of(context)!.pricingGroups,
                        hintText: AppLocalizations.of(context)!.pricingGroups,
                        items: model.pricingGroup
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        dropdownValue: model.selectedPricingGroups,
                        onChange: (String value) {
                          model.changePricingGroups(value);
                        },
                      ),
                      if (model.selectedPricingGroupsValidation != "")
                        ValidationText(model.selectedPricingGroupsValidation),
                      24.0.giveHeight,
                      SelectedDropdown<SalesZoneModelData>(
                        isDisable: true,
                        fieldName: AppLocalizations.of(context)!.salesZone,
                        hintText: AppLocalizations.of(context)!.salesZone,
                        items: model.salesZone
                            .map((e) => DropdownMenuItem<SalesZoneModelData>(
                                  value: e,
                                  child: Text(e.zoneName!),
                                ))
                            .toList(),
                        dropdownValue: model.selectedSalesZoneString,
                        onChange: (SalesZoneModelData value) {
                          model.changeSalesZone(value);
                        },
                      ),
                      if (model.selectedSalesZoneStringValidation != "")
                        ValidationText(model.selectedSalesZoneStringValidation),
                      24.0.giveHeight,
                    ],
                  ),
                ),
                Utils.cardGaps(),
                Utils.commonText(
                  AppLocalizations.of(context)!.viewRetailerStores,
                  style: AppTextStyles.headerText,
                  needPadding: true,
                ),
                Utils.cardToTextGaps(),
                model.internalInformation!.retailerStoreDetails!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 100.0.wp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (RetailerStoreDetails doc in model
                                  .internalInformation!.retailerStoreDetails!)
                                GestureDetector(
                                  onTap: () {
                                    model.navigateTo(
                                        double.parse(doc.lattitude!),
                                        double.parse(doc.longitude!));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 10.0,
                                    ),
                                    margin: const EdgeInsets.only(
                                        bottom: 5.0, left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.borderColors,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    width: 100.0.wp,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc.storeName!,
                                          style:
                                              AppTextStyles.retailerStoreCard,
                                        ),
                                        Text(
                                          doc.location!,
                                          style: AppTextStyles.retailerStoreCard
                                              .copyWith(
                                                  fontWeight:
                                                      AppFontWeighs.regular),
                                        ),
                                        Text(
                                          doc.salesZone!,
                                          style: AppTextStyles.retailerStoreCard
                                              .copyWith(
                                                  fontWeight:
                                                      AppFontWeighs.regular),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : ShadowCard(
                        child: Utils.noDataWidget(context, height: 30)),
                Utils.cardGaps(),
                Utils.commonText(
                  AppLocalizations.of(context)!.creditLine,
                  style: AppTextStyles.headerText,
                  needPadding: true,
                ),
                Utils.cardToTextGaps(),
                ShadowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.customerSinceDate,
                        style: AppTextStyles.formTitleTextStyle,
                      ),
                      10.0.giveHeight,
                      SizedBox(
                        height: 45.0,
                        child: TextField(
                          enabled: false,
                          readOnly: true,
                          decoration: AppInputStyles.ashOutlineBorderDisable,
                          onTap: model.openCalender,
                          controller: model.selectDate,
                        ),
                      ),
                      if (model.selectDateValidation != "")
                        ValidationText(model.selectDateValidation),
                      24.0.giveHeight,
                      NameTextField(
                        enable: false,
                        controller: model.monthlySalesController,
                        fieldName: AppLocalizations.of(context)!.monthlySales,
                      ),
                      if (model.monthlySalesValidation != "")
                        ValidationText(model.monthlySalesValidation),
                      24.0.giveHeight,
                      NameTextField(
                        enable: false,
                        controller: model.averageSalesTicketController,
                        fieldName:
                            AppLocalizations.of(context)!.averageSalesTicket,
                      ),
                      if (model.averageSalesTicketValidation != "")
                        ValidationText(model.averageSalesTicketValidation),
                      24.0.giveHeight,
                      SelectedDropdown<VisitFrequentListModel>(
                        isDisable: true,
                        fieldName: AppLocalizations.of(context)!.visitFrequency,
                        hintText: AppLocalizations.of(context)!.visitFrequency,
                        items: model.visitFrequentlyList
                            .map(
                                (e) => DropdownMenuItem<VisitFrequentListModel>(
                                      value: e,
                                      child: Text(StatusFile.visitFrequent(
                                          model.language, e.id!)),
                                    ))
                            .toList(),
                        dropdownValue: model.selectedVisitFrequency,
                        onChange: (VisitFrequentListModel value) {
                          model.changeVisitFrequency(value);
                        },
                      ),
                      if (model.selectedVisitFrequencyValidation != "")
                        ValidationText(model.selectedVisitFrequencyValidation),
                      24.0.giveHeight,
                      NameTextField(
                        enable: false,
                        controller: model.suggestedCreditLineController,
                        fieldName: AppLocalizations.of(context)!
                            .suggestedCreditLineAmount,
                      ),
                      if (model.suggestedCreditLineValidation != "")
                        ValidationText(model.suggestedCreditLineValidation),
                      10.0.giveHeight,
                    ],
                  ),
                ),
                Utils.cardGaps(),
                if ("${model.companyInformation!.status}" ==
                    (StatusNames.completed.name).toUpperCamelCase())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CancelButton(
                        onPressed: model.cancelButton,
                        text: AppLocalizations.of(context)!.cancelButton,
                        width: 40.0.wp,
                      ),
                      SubmitButton(
                        onPressed:
                            model.updateWholesalerRetailerAssociationStatus,
                        text: AppLocalizations.of(context)!.setPricing,
                        width: 40.0.wp,
                      ),
                    ],
                  ),
                40.0.giveHeight,
              ],
            ),
          ),
        ),
        if (model.isBusy) const LoaderWidget()
      ],
    );
  }
}
