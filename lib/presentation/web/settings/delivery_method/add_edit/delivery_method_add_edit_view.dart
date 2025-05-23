import 'dart:convert';

import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/dropdowns/custom_searchable_dropdown.dart';
import '../../../../widgets/dropdowns/selected_dropdown.dart';
import '../../../../widgets/utils_folder/validation_text.dart';
import 'delivery_method_add_edit_view_model.dart';

class DeliveryMethodAddEditView extends StatelessWidget {
  const DeliveryMethodAddEditView({super.key, this.id});
  final String? id;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryMethodAddEditViewModel>.reactive(
        viewModelBuilder: () => DeliveryMethodAddEditViewModel(),
        onViewModelReady: (DeliveryMethodAddEditViewModel model) {
          model.setData(id);
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
                          ? 'Edit Order Delivery Method'
                          : 'Add Order Delivery Method',
                    ),
                  ),
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
                              h1: model.isEdit
                                  ? 'Edit Order Delivery Method'
                                  : 'Add Order Delivery Method',
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
                                        model.isEdit
                                            ? 'Edit Order Delivery Method'
                                            : 'Add Order Delivery Method',
                                        style: AppTextStyles.headerText,
                                      ),
                                      10.0.giveHeight,
                                      Flex(
                                        direction: device == ScreenSize.wide
                                            ? Axis.horizontal
                                            : Axis.vertical,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : 22.0.wp,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                NameTextField(
                                                  fieldName:
                                                      "Delivery Method ID",
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyleNormal,
                                                  controller: model
                                                      .deliveryMethodIdController,
                                                ),
                                                ValidationText(
                                                    model.errorMessageMethodId),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const CommonText("Sale Zone"),
                                              5.0.giveHeight,
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .cardShadow)),
                                                width:
                                                    device == ScreenSize.small
                                                        ? 80.0.wp
                                                        : 22.0.wp,
                                                child: CustomSearchableDropDown(
                                                  searchBarHeight: 45.0,
                                                  initialValue:
                                                      model.preSaleZone,
                                                  close: (i) {
                                                    model.removeStoreItem(i);
                                                  },
                                                  dropdownHintText:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .selectFie,
                                                  showLabelInMenu: false,
                                                  multiSelect: true,
                                                  multiSelectTag: true,
                                                  primaryColor:
                                                      AppColors.disableColor,
                                                  menuMode: true,
                                                  labelStyle: AppTextStyles
                                                      .formTitleTextStyleNormal,
                                                  items: jsonDecode(jsonEncode(
                                                      model
                                                          .saleZones)), //need edit
                                                  label: AppLocalizations.of(
                                                          context)!
                                                      .selectFie,
                                                  dropDownMenuItems: model
                                                      .saleZones
                                                      .map((item) {
                                                    return '${item.zoneName}';
                                                  }).toList(),
                                                  onChanged: (List value) {
                                                    model
                                                        .putSelectedSaleZoneList(
                                                            value);
                                                  },
                                                ),
                                              ),
                                              ValidationText(
                                                  model.saleZoneErrorMessage),
                                            ],
                                          ),
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : 22.0.wp,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SelectedDropdown<String>(
                                                  fieldName: "Currency",
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyleNormal,
                                                  dropdownValue:
                                                      model.selectedCurrency,
                                                  items: model.currencies
                                                      .map(
                                                        (e) => DropdownMenuItem<
                                                            String>(
                                                          value: e,
                                                          child: Text(e),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChange: (String v) {
                                                    model.changeCurrency(v);
                                                  },
                                                ),
                                                ValidationText(
                                                    model.currencyErrorMessage),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: device == ScreenSize.small
                                                ? 80.0.wp
                                                : 22.0.wp,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                NameTextField(
                                                  isFloat: true,
                                                  fieldName:
                                                      "Shipping & Handling Cost",
                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyleNormal,
                                                  controller:
                                                      model.amountController,
                                                ),
                                                ValidationText(
                                                    model.amountErrorMessage),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // 10.0.giveHeight,
                                      SizedBox(
                                        width: device == ScreenSize.small
                                            ? 80.0.wp
                                            : 100.0.wp,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NameTextField(
                                              maxLine: 5,
                                              fieldName: "Description",
                                              hintStyle: AppTextStyles
                                                  .formTitleTextStyleNormal,
                                              controller:
                                                  model.descriptionController,
                                            ),
                                            ValidationText(
                                                model.descriptionErrorMessage),
                                          ],
                                        ),
                                      ),
                                      10.0.giveHeight,
                                      model.busy(
                                              model.deliveryMethodIdController)
                                          ? SizedBox(
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 22.0.wp,
                                              child: Center(
                                                child: Utils.loaderBusy(),
                                              ),
                                            )
                                          : SubmitButton(
                                              onPressed:
                                                  model.editDeliveryMethod,
                                              isRadius: false,
                                              height: 45.0,
                                              width: device == ScreenSize.small
                                                  ? 80.0.wp
                                                  : 22.0.wp,
                                              text: model.isEdit
                                                  ? "Update Delivery Method"
                                                  : "Add Delivery Method",
                                              // controller:
                                              // model.paymentMethodController,
                                            ),
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
