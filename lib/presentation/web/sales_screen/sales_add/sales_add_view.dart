import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/web/sales_screen/sales_add/sales_add_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/construction_model/sale_types_model.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../data_models/models/component_models/retailer_list_model.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/dropdowns/selected_dropdown.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import '../../../widgets/utils_folder/validation_text.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/text_fields/sale_text_fields.dart';

class SalesAddView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesAddViewModel>.reactive(
        viewModelBuilder: () => SalesAddViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        Expanded(
                          child: SecondaryNameAppBar(
                            h1: AppLocalizations.of(context)!.addSale_header,
                          ),
                        ),
                        SizedBox()
                      ],
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
                              h1: AppLocalizations.of(context)!.addSale_header,
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
                                            AppLocalizations.of(context)!
                                                .addSale_body,
                                            style: AppTextStyles.headerText,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: SubmitButton(
                                              color: AppColors.webButtonColor,
                                              // color: AppColors.bingoGreen,
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
                                      if (model.selectStore != null)
                                        const Divider(
                                          color: AppColors.dividerColor,
                                        ),
                                      if (model.selectStore != null)
                                        Text(
                                          model.availableAmount !=
                                                  (double.parse("0")).toString()
                                              ? "${AppLocalizations.of(context)!.addSale_balanceAvailabilityText} ${model.currencyController.text} ${model.availableAmount}"
                                              : "${AppLocalizations.of(context)!.addSale_balanceAvailabilityText} ${model.currencyController.text} 0.00",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: model.selectStore!
                                                        .availableAmount! <
                                                    0.1
                                                ? AppColors
                                                    .addSaleAmountSectionColorRed
                                                : AppColors
                                                    .addSaleAmountSectionColor,
                                          ),
                                        ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 12.0, top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(),
                                          ],
                                        ),
                                      ),
                                      if (model.isBusy) Utils.bigLoader(),
                                      if (!model.isBusy)
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
                                                width: device != ScreenSize.wide
                                                    ? 90.0.wp
                                                    : 29.0.wp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SelectedDropdown<
                                                            RetailerListData>(
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                        dropdownValue: model
                                                            .selectRetailer,
                                                        fieldName:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .retailer
                                                                .isRequired,
                                                        hintText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .selectRetailer,
                                                        items: [
                                                          for (RetailerListData v
                                                              in model
                                                                  .retailerList)
                                                            DropdownMenuItem<
                                                                RetailerListData>(
                                                              value: v,
                                                              child: Text(
                                                                  "${v.retailerName!} | ${v.internalId!}"),
                                                            )
                                                        ],
                                                        onChange:
                                                            (RetailerListData?
                                                                newValue) {
                                                          if (newValue ==
                                                              null) {
                                                            model
                                                                .changeRetailerToNull();
                                                          } else {
                                                            model
                                                                .changeRetailer(
                                                                    newValue);
                                                          }
                                                        }),
                                                    if (model.retailerValidation
                                                        .isNotEmpty)
                                                      ValidationText(model
                                                          .retailerValidation)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: device != ScreenSize.wide
                                                    ? 90.0.wp
                                                    : 29.0.wp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SelectedDropdown<StoreList>(
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                        dropdownValue:
                                                            model.selectStore,
                                                        fieldName:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .store
                                                                .isRequired,
                                                        hintText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .selectStore,
                                                        items: model
                                                            .sortedStoreList
                                                            .map(
                                                              (e) =>
                                                                  DropdownMenuItem<
                                                                      StoreList>(
                                                                value: e,
                                                                child: Text(
                                                                    "${e.name!} | ${e.wholesalerStoreId!}"),
                                                              ),
                                                            )
                                                            .toList(),
                                                        onChange: (StoreList?
                                                            newValue) {
                                                          model.selectRetailer ==
                                                                  null
                                                              ? model
                                                                  .changeStoreThenRetailer(
                                                                      newValue!)
                                                              : model
                                                                  .changeStore(
                                                                      newValue!);
                                                        }),
                                                    if (model.storeValidation
                                                        .isNotEmpty)
                                                      ValidationText(
                                                          model.storeValidation)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: device != ScreenSize.wide
                                                    ? 90.0.wp
                                                    : 29.0.wp,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SelectedDropdown<
                                                            SaleTypesModel>(
                                                        hintStyle: AppTextStyles
                                                            .formTitleTextStyleNormal,
                                                        // isDisable:
                                                        //     model.selectStore!.saleType!.isNotEmpty,
                                                        dropdownValue: model
                                                            .selectSaleType,
                                                        fieldName:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .salesType
                                                                .isRequired,
                                                        hintText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .selectSaleType,
                                                        items: model.saleTypes
                                                            .map(
                                                              (e) => DropdownMenuItem<
                                                                  SaleTypesModel>(
                                                                value: e,
                                                                child: Text(
                                                                    e.title!),
                                                              ),
                                                            )
                                                            .toList(),
                                                        onChange:
                                                            (SaleTypesModel?
                                                                newValue) {
                                                          model.changeSaleType(
                                                              newValue!);
                                                        }),
                                                    if (model
                                                        .salesTypeValidation
                                                        .isNotEmpty)
                                                      ValidationText(model
                                                          .salesTypeValidation)
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SaleTextField(
                                                    onChanged: (v) {
                                                      model.changeError(
                                                          model
                                                              .invoiceNumberController,
                                                          1);
                                                    },
                                                    enable: model
                                                                .selectSaleType ==
                                                            null
                                                        ? false
                                                        : model.selectSaleType!
                                                                    .initiate!
                                                                    .toLowerCase() ==
                                                                '1s'
                                                            ? true
                                                            : false,
                                                    AppLocalizations.of(
                                                            context)!
                                                        .invoiceNumber
                                                        .isRequired,
                                                    model
                                                        .invoiceNumberController,
                                                  ),
                                                  if (model.invoiceValidation
                                                      .isNotEmpty)
                                                    ValidationText(
                                                        model.invoiceValidation)
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SaleTextField(
                                                    onChanged: (v) {
                                                      model.changeError(
                                                          model
                                                              .orderNumberController,
                                                          2);
                                                    },
                                                    enable: model
                                                                .selectSaleType ==
                                                            null
                                                        ? false
                                                        : model.selectSaleType!
                                                                    .initiate!
                                                                    .toLowerCase() ==
                                                                '2s'
                                                            ? true
                                                            : false,
                                                    AppLocalizations.of(
                                                            context)!
                                                        .orderNumber
                                                        .isRequired,
                                                    model.orderNumberController,
                                                  ),
                                                  if (model.orderValidation
                                                      .isNotEmpty)
                                                    ValidationText(
                                                        model.orderValidation)
                                                ],
                                              ),
                                              if (model.selectStore != null)
                                                SaleTextField(
                                                  enable: true,
                                                  readOnly: true,
                                                  AppLocalizations.of(context)!
                                                      .currency
                                                      .toUpperCamelCase()
                                                      .isRequired,
                                                  model.currencyController,
                                                ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SaleTextField(
                                                    onChanged: (v) {
                                                      model.changeError(
                                                          model
                                                              .amountController,
                                                          3);
                                                    },
                                                    enable: true,
                                                    isFloat: true,
                                                    AppLocalizations.of(
                                                            context)!
                                                        .amount
                                                        .toUpperCamelCase()
                                                        .isRequired,
                                                    model.amountController,
                                                  ),
                                                  if (model.amountValidation
                                                      .isNotEmpty)
                                                    ValidationText(
                                                        model.amountValidation)
                                                ],
                                              ),
                                              SizedBox(
                                                width: 100.0.wp,
                                                child: NameTextField(
                                                  // height: 80.0,
                                                  controller: model
                                                      .descriptionController,
                                                  maxLine: 5,
                                                  enable: true,

                                                  hintStyle: AppTextStyles
                                                      .formTitleTextStyleNormal,
                                                  fieldName:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .description
                                                          .toUpperCamelCase(),
                                                ),
                                              ),
                                              model.isButtonBusy
                                                  ? Utils.loaderBusy()
                                                  : SubmitButton(
                                                      color:
                                                          AppColors.bingoGreen,
                                                      onPressed: () {
                                                        model.addNew(context);
                                                      },
                                                      isRadius: false,
                                                      height: 55,
                                                      width: 140,
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .addSales,
                                                    )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
