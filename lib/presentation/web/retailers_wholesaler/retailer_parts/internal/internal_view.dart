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

import '../../../../../const/server_status_file/server_status_file.dart';
import '../../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/internal_configuration_list_model.dart';
import '../../../../widgets/utils_folder/validation_text.dart';
import '../../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../secondery_bar.dart';
import 'internal_view_model.dart';

class RetailerInternalView extends StatelessWidget {
  const RetailerInternalView({super.key, this.uid, this.ttx});

  final String? uid;
  final String? ttx;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetailerInternalViewModel>.reactive(
        viewModelBuilder: () => RetailerInternalViewModel(),
        onViewModelReady: (RetailerInternalViewModel model) {
          model.getInternalConfigurationList(uid!);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'View Retailer Profile',
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
                              h1: 'View Retailer Profile',
                            ),
                          WithTabWebsiteBaseBody(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Customer Classification',
                                            style: AppTextStyles.headerText,
                                          ),
                                          20.0.giveHeight,
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
                                                          : 30.0.wp,
                                                  child: NameTextField(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    enable: true,
                                                    controller: model
                                                        .internalIdController,
                                                    fieldName: "Internal ID",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: SelectedDropdown<
                                                      CustomerType>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName: "Customer Type",
                                                    dropdownValue: model
                                                        .selectedCustomerType,
                                                    items: model.customerTypes!
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                  CustomerType>(
                                                            value: e,
                                                            child: Text(e
                                                                .customerType!),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChange: (Object? v) {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: SelectedDropdown<
                                                      GracePeriod>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName:
                                                        "Grace Period Groups",
                                                    dropdownValue: model
                                                        .selectedGracePeriod,
                                                    items: model.gracePeriods!
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                  GracePeriod>(
                                                            value: e,
                                                            child: Text(e
                                                                .gracePeriodGroup!),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChange: (Object? v) {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: SelectedDropdown<
                                                      PricingGroups>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName: "Pricing Groups",
                                                    dropdownValue: model
                                                        .selectedPricingGroups,
                                                    items: model.pricingGroups!
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                  PricingGroups>(
                                                            value: e,
                                                            child: Text(e
                                                                .pricingGroups!),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChange: (Object? v) {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: SelectedDropdown<
                                                      SaleZones>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName: "Sales Zone",
                                                    dropdownValue:
                                                        model.selectedSaleZones,
                                                    items: model.saleZones!
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                  SaleZones>(
                                                            value: e,
                                                            child: Text(
                                                                e.zoneName!),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChange: (Object? v) {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child:
                                                      SelectedDropdown<String>(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName: "Allow Orders",
                                                    dropdownValue: model
                                                        .selectedAllowOrders,
                                                    items: model.allowOrders!
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                            value: e,
                                                            child: Text(e),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChange: (Object? v) {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          const Text(
                                            'Credit Line',
                                            style: AppTextStyles.headerText,
                                          ),
                                          20.0.giveHeight,
                                          SizedBox(
                                            width: 100.0.wp,
                                            child: Wrap(
                                              runSpacing: 20.0,
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              runAlignment:
                                                  WrapAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                      child: AbsorbPointer(
                                                        child: NameTextField(
                                                            enable: false,
                                                            hintStyle: AppTextStyles
                                                                .formTitleTextStyleNormal,
                                                            style: AppTextStyles
                                                                .formFieldTextStyle,
                                                            controller: model
                                                                .customerSinceController,
                                                            fieldName:
                                                                "Customer Since Date"
                                                                    .isRequired),
                                                      ),
                                                    ),
                                                    ValidationText(model
                                                        .customerSinceError),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                      child: NameTextField(
                                                        isFloat: true,
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                        controller: model
                                                            .monthlySalesController,
                                                        fieldName:
                                                            "Monthly Sales"
                                                                .isRequired,
                                                      ),
                                                    ),
                                                    ValidationText(model
                                                        .monthlySalesError),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                      child: NameTextField(
                                                        isFloat: true,
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                        controller: model
                                                            .averageSaleTicketController,
                                                        fieldName:
                                                            "Average Sales Ticket"
                                                                .isRequired,
                                                      ),
                                                    ),
                                                    ValidationText(model
                                                        .averageSaleTicketError),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                  child: SelectedDropdown(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                    fieldName: "Visit Frequency"
                                                        .isRequired,
                                                    dropdownValue:
                                                        model.selectedFrequency,
                                                    items: [
                                                      for (var i = 0;
                                                          i <
                                                              model
                                                                  .visitFrequency
                                                                  .length;
                                                          i++)
                                                        DropdownMenuItem<
                                                            VisitFrequentListModel>(
                                                          value: model
                                                              .visitFrequency[i],
                                                          child: Text(StatusFile
                                                              .visitFrequent(
                                                                  'en',
                                                                  model
                                                                      .visitFrequency[
                                                                          i]
                                                                      .id!)),
                                                        )
                                                    ],
                                                    onChange: (Object? v) {},
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: device ==
                                                              ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                      child: NameTextField(
                                                        isFloat: true,
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                        controller: model
                                                            .suggestedClController,
                                                        fieldName:
                                                            "Suggested Credit Line Amount"
                                                                .isRequired,
                                                      ),
                                                    ),
                                                    ValidationText(
                                                        model.suggestedClError),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      device == ScreenSize.small
                                                          ? 80.0.wp
                                                          : 30.0.wp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: AppColors.dividerColor,
                                          ),
                                          model.isButtonBusy
                                              ? SizedBox(
                                                  height: 50.0,
                                                  child: Utils.webLoader(),
                                                )
                                              : SubmitButton(
                                                  onPressed: () {
                                                    model.update(uid);
                                                  },
                                                  isRadius: false,
                                                  width: 100.0,
                                                  height: 45.0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .update,
                                                )
                                        ],
                                      ),
                              ],
                            ),
                            child: SecondaryBar(ttx, uid),
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
