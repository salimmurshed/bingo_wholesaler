import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/utils_folder/validation_text.dart';
import '/const/all_const.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/utils.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import '/presentation/widgets/cards/single_lin_shimmer.dart';
import '/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../const/app_sizes/app_sizes.dart';
import '../../../data_models/construction_model/route_to_sale_model/route_to_sale_model.dart';
import '../../../data_models/construction_model/route_zone_argument_model/route_zone_argument_model.dart';
import '../../../data_models/construction_model/sale_types_model.dart';
import '../../../data_models/models/component_models/retailer_list_model.dart';
import '../../../services/auth_service/auth_service.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/text_fields/name_text_field.dart';
import '../create_order/create_order_view.dart';
import 'sales_add_view_model.dart';

class AddSalesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return locator<AuthService>().enrollment.value == UserTypeForWeb.retailer
        ? const CreateOrderView()
        : ViewModelBuilder<AddSalesViewModel>.reactive(
            onViewModelReady: (AddSalesViewModel model) {
              model.getStoreList();
              if (ModalRoute.of(context)!.settings.arguments != null) {
                print('cvcvcvcvcvc');
                print(ModalRoute.of(context)!.settings.arguments.runtimeType);
                if (ModalRoute.of(context)!.settings.arguments.runtimeType ==
                    RouteToSaleModel) {
                  model.getDataFromRoutes(ModalRoute.of(context)!
                      .settings
                      .arguments as RouteToSaleModel);
                } else if (ModalRoute.of(context)!
                        .settings
                        .arguments
                        .runtimeType ==
                    RoutesZonesArgumentData) {
                  model.getStoreListWithAutoSelect(ModalRoute.of(context)!
                      .settings
                      .arguments as RoutesZonesArgumentData);
                } else {}
              }
            },
            viewModelBuilder: () => AddSalesViewModel(),
            builder: (context, model, child) {
              return Scaffold(
                appBar: AppBar(
                  leading: model.isBusy
                      ? SizedBox()
                      : IconButton(
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                          ),
                          onPressed: () async {
                            print('isItFromRouteZone');
                            print(model.screenNumber);
                            if (model.screenNumber == 0) {
                              model.backScreen(context);
                            } else {
                              await model.clearForm();
                              model.goBack();

                              // model.backScreen(context);
                            }
                          }),
                  backgroundColor: model.enrollment == UserTypeForWeb.retailer
                      ? AppColors.appBarColorRetailer
                      : AppColors.appBarColorWholesaler,
                  title: AppBarText(
                    model.enrollment == UserTypeForWeb.retailer
                        ? AppLocalizations.of(context)!.addOrder.toUpperCase()
                        : AppLocalizations.of(context)!.addSales.toUpperCase(),
                  ),
                ),
                body: model.isBusy
                    ? Utils.loaderBusy()
                    : wholeSalerAddSales(model, context),
              );
            });
  }

  Widget wholeSalerAddSales(AddSalesViewModel model, BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (_) async {
        await model.clearForm();
        return;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.bodyVertical,
          child: ShadowCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ////Select Retailer
                    SelectedDropdown<RetailerListData>(
                        dropdownValue: model.selectRetailer,
                        fieldName:
                            AppLocalizations.of(context)!.retailer.isRequired,
                        hintText: AppLocalizations.of(context)!.selectRetailer,
                        items: [
                          for (RetailerListData v in model.retailerList)
                            DropdownMenuItem<RetailerListData>(
                              value: v,
                              child:
                                  Text("${v.retailerName!} | ${v.internalId!}"),
                            )
                        ],
                        onChange: (RetailerListData? newValue) {
                          if (newValue == null) {
                            model.changeRetailerToNull();
                          } else {
                            model.changeRetailer(newValue);
                          }
                        }),
                    if (model.retailerValidation.isNotEmpty)
                      ValidationText(model.retailerValidation),
                    20.0.giveHeight,
                    model.isStoreBusy
                        ? const SingleLineShimmerScreen()
                        : SelectedDropdown<StoreList>(
                            dropdownValue: model.selectStore,
                            fieldName:
                                AppLocalizations.of(context)!.store.isRequired,
                            hintText: AppLocalizations.of(context)!.selectStore,
                            items: model.sortedStoreList
                                .where((s) => model.retailerList.any((r) {
                                      print(s.associationId ==
                                          r.associationUniqueId);
                                      return s.associationId ==
                                          r.associationUniqueId;
                                    }))
                                .toList()
                                .map(
                                  (e) => DropdownMenuItem<StoreList>(
                                    value: e,
                                    child: Text(
                                        "${e.name!} | ${e.wholesalerStoreId!}"),
                                  ),
                                )
                                .toList(),
                            onChange: (StoreList? newValue) {
                              model.selectRetailer == null
                                  ? model.changeStoreThenRetailer(newValue!)
                                  : model.changeStore(newValue!);
                            }),
                    if (model.storeValidation.isNotEmpty)
                      ValidationText(model.storeValidation),
                    if (model.selectStore != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.0.giveHeight,
                          Container(
                            padding: const EdgeInsets.all(17.0),
                            width: 100.0.wp,
                            // height: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: model.selectStore!.availableAmount! < 0.1
                                  ? AppColors.addSaleAmountSectionColorRed
                                  : AppColors.addSaleAmountSectionColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppAsset.dollarSign,
                                  width: 28.0,
                                  height: 28.0,
                                ),
                                17.0.giveWidth,
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .availableAmount,
                                      style: AppTextStyles.addSaleGreenBoxText,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: model.selectStore!.name!,
                                          style: AppTextStyles
                                              .addSaleGreenBoxTextBold,
                                        ),
                                        TextSpan(
                                          text:
                                              ' ${model.selectStore!.approvedCreditLineCurrency!} ',
                                          style: AppTextStyles
                                              .addSaleGreenBoxTextBold,
                                        ),
                                        TextSpan(
                                          text: model.availableAmount() < 0.1
                                              ? "0.0"
                                              : model.amountController.text
                                                      .isEmpty
                                                  ? model
                                                      .availableAmount()
                                                      .toString()
                                                  : model.availableAmountText,
                                          style: AppTextStyles
                                              .addSaleGreenBoxTextBold,
                                        ),
                                        TextSpan(
                                          text: model.availableAmount() < 0.1
                                              ? "\n${AppLocalizations.of(context)!.unableToPlaceSaleMessage}"
                                              : "",
                                          style: AppTextStyles
                                              .addSaleGreenBoxTextBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (model.retailerList.isNotEmpty) 20.0.giveHeight,

                    if (model.selectStore != null)
                      if (model.selectStore!.availableAmount! > 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectedDropdown<SaleTypesModel>(
                                    // isDisable:
                                    //     model.selectStore!.saleType!.isNotEmpty,
                                    dropdownValue: model.selectSaleType,
                                    fieldName: AppLocalizations.of(context)!
                                        .salesType
                                        .isRequired,
                                    hintText: AppLocalizations.of(context)!
                                        .selectSaleType,
                                    items: model.saleTypes
                                        .map(
                                          (e) =>
                                              DropdownMenuItem<SaleTypesModel>(
                                            value: e,
                                            child: Text(
                                                model.getSalesTypeBaseOnLang(
                                                    e.initiate)),
                                          ),
                                        )
                                        .toList(),
                                    onChange: (SaleTypesModel? newValue) {
                                      model.changeSaleType(newValue!);
                                    }),
                                if (model.salesTypeValidation.isNotEmpty)
                                  ValidationText(model.salesTypeValidation),
                              ],
                            ),
                            if (model.selectSaleType != null)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.0.giveHeight,
                                  if (model.selectSaleType!.initiate ==
                                      model.saleTypes[0].initiate)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NameTextField(
                                          controller: model.invoiceController,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hintTextInvoiceController,
                                          fieldName:
                                              AppLocalizations.of(context)!
                                                  .invoiceNumber
                                                  .isRequired,
                                        ),
                                        if (model.invoiceValidation.isNotEmpty)
                                          ValidationText(
                                              model.invoiceValidation),
                                      ],
                                    ),
                                  if (model.selectSaleType!.initiate ==
                                      model.saleTypes[1].initiate)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NameTextField(
                                          controller: model.orderController,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hintTextOrderController,
                                          fieldName:
                                              AppLocalizations.of(context)!
                                                  .orderNumberSale
                                                  .isRequired,
                                        ),
                                        if (model.orderValidation.isNotEmpty)
                                          ValidationText(model.orderValidation),
                                      ],
                                    ),
                                ],
                              ),
                            20.0.giveHeight,
                            if (model.selectStore != null)
                              model.isStoreBusy
                                  ? const SingleLineShimmerScreen()
                                  : NameTextField(
                                      hintText: AppLocalizations.of(context)!
                                          .hintTextCurrencyController,
                                      readOnly: true,
                                      enable: false,
                                      controller: model.currencyController,
                                      fieldName: AppLocalizations.of(context)!
                                          .currency,
                                    ),
                            if (model.selectStore != null) 20.0.giveHeight,
                            if (model.selectStore != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  model.isStoreBusy
                                      ? const SingleLineShimmerScreen()
                                      : NameTextField(
                                          isNumber: true,
                                          onChanged: (String value) {
                                            model.checkBalance(value);
                                            model.setAvailableAmount();
                                          },
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .hintTextAmountController,
                                          controller: model.amountController,
                                          fieldName:
                                              AppLocalizations.of(context)!
                                                  .amount
                                                  .isRequired,
                                        ),
                                  if (model.amountValidation.isNotEmpty)
                                    ValidationText(model.amountValidation),
                                ],
                              ),
                            if (model.selectStore != null) 20.0.giveHeight,
                            NameTextField(
                              maxLine: 5,
                              hintText: AppLocalizations.of(context)!
                                  .hintTextDescriptionController,
                              controller: model.descriptionController,
                              fieldName:
                                  AppLocalizations.of(context)!.description,
                            ),
                            20.0.giveHeight,
                            model.isButtonBusy
                                ? SizedBox(
                                    width: 100.0.wp,
                                    height: 110.0,
                                    child: const Center(
                                      child: SizedBox(
                                        height: 10.0,
                                        width: 10.0,
                                        child: CircularProgressIndicator(
                                          color: AppColors.loader1,
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      SubmitButton(
                                        onPressed: () {
                                          model.addNew(context);
                                        },
                                        width: 100.0.wp,
                                        height: 45.0,
                                        text: AppLocalizations.of(context)!
                                            .addNewIcon,
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                    if (!model.isButtonBusy)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          20.0.giveHeight,
                          SubmitButton(
                            color: AppColors.redColor,
                            onPressed: () {
                              if (model.screenNumber == 0) {
                                model.backScreen(context);
                              } else {
                                model.goBack();
                              }
                            },
                            width: 100.0.wp,
                            height: 45.0,
                            text: AppLocalizations.of(context)!
                                .cancelButton
                                .toUpperCase(),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
