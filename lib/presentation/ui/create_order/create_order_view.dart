import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/text/common_text.dart';

import '../../../data_models/enums/user_roles_files.dart';
import '../../widgets/cards/loader/loader.dart';
import '../../widgets/checked_box.dart';
import '../../widgets/utils_folder/order_summary_text.dart';
import '../../widgets/utils_folder/validation_text.dart';
import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/order_selection_model/order_selection_model.dart';
import '../../../data_models/models/user_model/user_model.dart';
import '../../widgets/buttons/cancel_button.dart';
import '../../widgets/buttons/tab_bar_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/error_check_image.dart';
import '../../widgets/dropdowns/selected_dropdown.dart';
import '../../widgets/text_fields/name_text_field.dart';
import 'create_order_view_model.dart';

class CreateOrderView extends StatelessWidget {
  const CreateOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateOrderViewModel>.reactive(
        viewModelBuilder: () => CreateOrderViewModel(),
        onViewModelReady: (CreateOrderViewModel model) {
          if (ModalRoute.of(context)!.settings.arguments != null) {
            model.setDetails(ModalRoute.of(context)!.settings.arguments as Map);
          } else {
            model.clearOrderSelection();
          }
        },
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                  ),
                  onPressed: () {
                    model.backScreen(context);
                  }),
              backgroundColor: AppColors.appBarColorRetailer,
              title: AppBarText(
                model.isEdit
                    ? AppLocalizations.of(context)!.editOrder.toUpperCase()
                    : AppLocalizations.of(context)!.addOrder.toUpperCase(),
              ),
            ),
            body: model.busy(model.wholesaler)
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(child: LoaderWidget()),
                  )
                : model.orderScreenNumber == 0
                    ? orderFirst(model, context)
                    : model.orderScreenNumber == 1
                        ? orderSecond(model, context)
                        : orderThird(model, context),
          );
        });
  }

  orderFirst(CreateOrderViewModel model, BuildContext context) {
    return model.isBusy
        ? SizedBox(height: 100.0.hp, child: const Center(child: LoaderWidget()))
        : Padding(
            padding: AppPaddings.borderCardPadding,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 188.0,
                    width: 100.0.wp,
                    decoration: BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: model.orderSelectionData.data == null
                        ? Container(
                            color: AppColors.whiteColor,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 0.1,
                                enlargeCenterPage: true,
                              ),
                              items: model.promotionalImages
                                  .map((e) => SizedBox(
                                        height: 188.0,
                                        width: 100.0.wp,
                                        child: ErrorCheckImage(
                                          height: 188.0,
                                          width: 100.0.wp,
                                          e.banner!,
                                          fit: BoxFit.cover,
                                          longLoader: true,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          )
                        : model.orderSelectionData.data!.promotions == null
                            ? const SizedBox()
                            : Container(
                                color: AppColors.whiteColor,
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    aspectRatio: 0.1,
                                    enlargeCenterPage: true,
                                  ),
                                  items:
                                      model.orderSelectionData.data!.promotions!
                                          .map((e) => SizedBox(
                                                height: 188.0,
                                                width: 100.0.wp,
                                                child: Image.network(
                                                  e.banner!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ))
                                          .toList(),
                                ),
                              ),
                  ),
                  28.0.giveHeight,
                  SelectedDropdown(
                    items: model.storeList
                        .map(
                          (e) => DropdownMenuItem<Stores>(
                            value: e,
                            child: Text(e.name!),
                          ),
                        )
                        .toList(),
                    onChange: (Stores value) async {
                      await model.changeStore(value);
                    },
                    dropdownValue: model.selectedStore,
                    hintText: AppLocalizations.of(context)!.selectStore,
                    fieldName:
                        AppLocalizations.of(context)!.selectStore.isRequired,
                  ),
                  28.0.giveHeight,
                  CommonText(AppLocalizations.of(context)!
                      .selectWholeSaler
                      .isRequired),
                  10.0.giveHeight,
                  model.busy(model.wholesaler)
                      ? SizedBox(
                          width: 100.0.wp,
                          height: 100,
                          child: Center(
                            child: Utils.loaderBusy(),
                          ),
                        )
                      : SizedBox(
                          width: 100.0.wp,
                          child: Wrap(
                            spacing: 5.0,
                            runSpacing: 10.0,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < model.wholesaler.length; i++)
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Card(
                                        elevation: 1.5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        child: Container(
                                          padding: AppPaddings.cardPadding,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: model.selectedWholesaler ==
                                                        null
                                                    ? 0
                                                    : model.selectedWholesaler!
                                                                .uniqueId ==
                                                            model.wholesaler[i]
                                                                .uniqueId
                                                        ? 2
                                                        : 0,
                                                color: model.selectedWholesaler ==
                                                        null
                                                    ? AppColors.transparent
                                                    : model.selectedWholesaler!
                                                                .uniqueId ==
                                                            model.wholesaler[i]
                                                                .uniqueId
                                                        ? AppColors.greenColor
                                                        : AppColors
                                                            .transparent),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            color: AppColors.cardColor,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              await model.changeWholesaler(
                                                  model.wholesaler[i]);
                                            },
                                            child: Container(
                                              height: 22.0.wp,
                                              width: ((100.0.wp / 3) -
                                                  40.0 -
                                                  4.0 -
                                                  10.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                              child: Center(
                                                child: ErrorCheckImage(
                                                  model.wholesaler[i].logo!,
                                                  height: 22.0.wp,
                                                  width: 22.0.wp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(model.wholesaler[i].name!)
                                  ],
                                ),
                            ],
                          ),
                        ),
                  28.0.giveHeight,
                  Center(
                    child: SubmitButton(
                      color: model.selectedWholesaler != null &&
                              model.selectedStore != null
                          ? AppColors.activeButtonColor
                          : AppColors.disableColor,
                      active: model.selectedWholesaler != null &&
                          model.selectedStore != null,
                      onPressed: model.selectedWholesaler != null &&
                              model.selectedStore != null
                          ? () {
                              model.goNextScreen(1);
                            }
                          : null,
                      text: AppLocalizations.of(context)!.nextButton,
                      width: 30.0.wp,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  orderSecond(CreateOrderViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: AppPaddings.borderCardPadding,
          child: SizedBox(
            height: model.orderDesError.isEmpty ? 235.0 : 251.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectedDropdown(
                    fieldName: AppLocalizations.of(context)!.loadTemplate,
                    hintText: AppLocalizations.of(context)!.loadTemplate,
                    items: model.orderSelectionData.data!.templates!
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                              i,
                              DropdownMenuItem<Templates>(
                                onTap: () {
                                  model.templatePreloading(i);
                                },
                                value: e,
                                child: Text(
                                    "${e.orderDescription!} | ${e.itemsQty!} ${AppLocalizations.of(context)!.items} | ${e.grandTotal!} ${e.orderLogs![0].currency}"),
                              )),
                        )
                        .values
                        .toList(),
                    dropdownValue: model.selectedTemplates,
                    onChange: (Templates v) {
                      model.changeTemplates(v);
                    }),
                10.0.giveHeight,
                NameTextField(
                  controller: model.orderDesController,
                  fieldName:
                      AppLocalizations.of(context)!.orderDescription.isRequired,
                  hintText: AppLocalizations.of(context)!.orderDescription,
                  onChanged: (_) {
                    model.refreshScreen();
                  },
                ),
                if (model.orderDesError.isNotEmpty)
                  Text(
                    model.orderDesError,
                    style: AppTextStyles.errorTextStyle,
                  ),
                10.0.giveHeight,
                // if (model.searchedOrderList.isNotEmpty)
                RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.selectProductFrom,
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: (" ${model.selectedWholesaler!.name!}"),
                        //todo: now
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                10.0.giveHeight,
                // if (model.searchedOrderList.isNotEmpty)
                NameTextField(
                  controller: model.searchController,
                  hintText: AppLocalizations.of(context)!.searchProduct,
                  onChanged: (String v) {
                    print(v);
                    model.searchProduct(v);
                  },
                ),
                // InkWell(
                //   onTap: model.openProductSheet,
                //   child: IgnorePointer(
                //     child: NameTextField(
                //       readOnly: true,
                //       enable: true,
                //       hintText: AppLocalizations.of(context)!.selectProduct,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: model.orderList.isEmpty
                ? Center(
                    child: Text(
                        AppLocalizations.of(context)!.wholesalerHasNoProduct),
                  )
                : model.searchedOrderList.isEmpty
                    ? Center(
                        child: Text(
                            AppLocalizations.of(context)!.noDataBaseOnSearch),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < model.searchedOrderList.length;
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: SizedBox(
                                  width: 100.0.wp,
                                  child: ShadowCard(
                                    isChild: true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 105,
                                            width: 105,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: ErrorCheckImage(
                                                  model.searchedOrderList[i]
                                                      .productImage!,
                                                  height: 105,
                                                  width: 105,
                                                ),
                                              ),
                                            ),
                                          ),
                                          5.0.giveWidth,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 60.0.wp,
                                                  child: Text(
                                                    model.searchedOrderList[i]
                                                        .productDescription!,
                                                    style: AppTextStyles
                                                        .normalCopyText
                                                        .copyWith(
                                                            fontWeight:
                                                                AppFontWeighs
                                                                    .semiBold),
                                                  ),
                                                ),
                                                10.0.giveHeight,
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          model
                                                              .searchedOrderList[
                                                                  i]
                                                              .sku!,
                                                          style: AppTextStyles
                                                              .normalCopyText
                                                              .copyWith(
                                                                  fontSize: 10),
                                                        ),
                                                        10.0.giveHeight,
                                                        Text(
                                                          '${model.searchedOrderList[i].currency!} ${Utils.formatter.format(model.searchedOrderList[i].unitPrice!)}',
                                                          style: AppTextStyles
                                                              .normalCopyText
                                                              .copyWith(
                                                                  fontWeight:
                                                                      AppFontWeighs
                                                                          .light),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        button(
                                                          icon: Icons.remove,
                                                          onPressed: () {
                                                            model.deductProductFromCart(
                                                                model.searchedOrderList[
                                                                    i]);
                                                          },
                                                        ),
                                                        10.0.giveWidth,
                                                        Container(
                                                          width: 30.0,
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: AppColors
                                                                      .lightAshColor),
                                                              borderRadius:
                                                                  AppRadius
                                                                      .borderDecorationRadius,
                                                              color: AppColors
                                                                  .whiteColor),
                                                          child: Center(
                                                            child: Text(model
                                                                .searchedOrderList[
                                                                    i]
                                                                .qty!
                                                                .toString()),
                                                          ),
                                                        ),
                                                        10.0.giveWidth,
                                                        button(
                                                          icon: Icons.add,
                                                          onPressed: () {
                                                            model.addingProductToCart(
                                                                model.searchedOrderList[
                                                                    i]);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (model.productEmptyError.isNotEmpty) 10.0.giveHeight,
            if (model.productEmptyError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.productEmptyError,
                    style: AppTextStyles.errorTextStyle,
                  ),
                ),
              ),
            10.0.giveHeight,
            SubmitButton(
              color: model.orderList.isNotEmpty
                  ? AppColors.activeButtonColor
                  : AppColors.disableColor,
              onPressed: () {
                model.goNextScreen(2);
              },
              width: 80.0.wp,
              active: model.getTotalItemNumber() > 0 &&
                  model.orderDesController.text.isNotEmpty,
              height: 44.0,
              text:
                  "${model.getTotalItemNumber()} ${AppLocalizations.of(context)!.itemSelected}",
            ),
            20.0.giveHeight,
          ],
        ),
      ],
    );
  }

  orderThird(CreateOrderViewModel model, BuildContext context) {
    return Padding(
      padding: AppPaddings.borderCardPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.promoCode,
              style: AppTextStyles.normalCopyText,
            ),
            10.0.giveHeight,
            ShadowCard(
              padding: 0.1,
              isChild: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: model.isPromoLoading
                    ? SizedBox(
                        height: 150,
                        child: Center(
                          child: Utils.loaderBusy(),
                        ),
                      )
                    : Column(
                        children: [
                          NameTextField(
                            focus: model.promoFocus,
                            controller: model.promoCodeController,
                          ),
                          0.0.giveHeight,
                          if (model.promoErrorMessage.isNotEmpty)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: ValidationText(model.promoErrorMessage)),
                          if (model.applyPromoCodeReplyMessage.message != null)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: ValidationText(
                                  model.applyPromoCodeReplyMessage.message!,
                                  color:
                                      model.applyPromoCodeReplyMessage.success!
                                          ? AppColors.greenColor
                                          : AppColors.redColor,
                                )),
                          2.0.giveHeight,
                          SubmitButton(
                            onPressed: model.applyPromoCode,
                            width: 100.0,
                            text: AppLocalizations.of(context)!.applyText,
                          )
                        ],
                      ),
              ),
            ),
            10.0.giveHeight,
            Text(
              AppLocalizations.of(context)!.orderSummary,
              style: AppTextStyles.normalCopyText,
            ),
            10.0.giveHeight,
            model.orderList.isEmpty
                ? const SizedBox()
                : ShadowCard(
                    padding: 0.1,
                    isChild: true,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          OrderSummaryText(
                              "${AppLocalizations.of(context)!.iItemsQty} :",
                              "",
                              model.getTotalItemNumber().toString()),
                          OrderSummaryText(
                              "${AppLocalizations.of(context)!.subTotal} :",
                              "${model.orderSelectionData.data!.creditline!.currency}",
                              " ${Utils.formatter.format(model.getSubTotal())}"),
                          OrderSummaryText(
                              "${AppLocalizations.of(context)!.tax} :",
                              "${model.orderSelectionData.data!.creditline!.currency}",
                              " ${Utils.formatter.format(model.getTotalTax())}"),
                          OrderSummaryText(
                              "${AppLocalizations.of(context)!.total} :",
                              "${model.orderSelectionData.data!.creditline!.currency}",
                              " ${Utils.formatter.format(model.getTotal())}"),
                          OrderSummaryText(
                              "${AppLocalizations.of(context)!.shippingCost} :",
                              "${model.orderSelectionData.data!.creditline!.currency}",
                              " ${model.selectedDeliveryMethod == null ? "0.00" : Utils.formatter.format(model.selectedDeliveryMethod!.shippingAndHandlingCost ?? 0.0)}"),
                          OrderSummaryText(
                              "${AppLocalizations.of(context)!.grandTotal} :",
                              "${model.orderSelectionData.data!.creditline!.currency}",
                              " ${Utils.formatter.format(model.getGrandTotal())}"),
                        ],
                      ),
                    ),
                  ),
            10.0.giveHeight,
            Text(
              AppLocalizations.of(context)!.shippingInformation,
              style: AppTextStyles.normalCopyText,
            ),
            10.0.giveHeight,
            ShadowCard(
              padding: 0.1,
              isChild: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectedDropdown(
                        fieldName: AppLocalizations.of(context)!
                            .selectDeliveryMethod
                            .isRequired,
                        items: model.orderSelectionData.data!.deliveryMethod!
                            .map(
                              (e) => DropdownMenuItem<DeliveryMethod>(
                                value: e,
                                child: Text(e.deliveryMethod!),
                              ),
                            )
                            .toList(),
                        dropdownValue: model.selectedDeliveryMethod,
                        onChange: (DeliveryMethod v) {
                          model.changeDeliveryMethod(v);
                        }),
                    if (model.errorDeliveryMethod.isNotEmpty)
                      Text(
                        model.errorDeliveryMethod,
                        style: AppTextStyles.errorTextStyle,
                      ),
                    15.0.giveHeight,
                    //orderSelectionData

                    NameTextField(
                      enable: false,
                      fieldName: AppLocalizations.of(context)!.deliveryDate,
                    ),
                    15.0.giveHeight,
                  ],
                ),
              ),
            ),
            10.0.giveHeight,
            Text(
              AppLocalizations.of(context)!.payment,
              style: AppTextStyles.normalCopyText,
            ),
            10.0.giveHeight,
            ShadowCard(
              padding: 0.1,
              isChild: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectedDropdown(
                        fieldName: AppLocalizations.of(context)!
                            .selectPaymentMethod
                            .isRequired,
                        items: model.orderSelectionData.data!.paymentMethod!
                            .map(
                              (e) => DropdownMenuItem<PaymentMethod>(
                                value: e,
                                child: Text(e.paymentMethod!),
                              ),
                            )
                            .toList(),
                        dropdownValue: model.selectedPaymentMethod,
                        onChange: (PaymentMethod v) {
                          model.changePaymentMethod(v);
                        }),
                    if (model.errorPaymentMethod.isNotEmpty)
                      Text(
                        model.errorPaymentMethod,
                        style: AppTextStyles.errorTextStyle,
                      ),
                    15.0.giveHeight,
                    if (model.selectedPaymentMethod != null)
                      if (model.selectedPaymentMethod!.uniqueId == 0)
                        NameTextField(
                          fieldName:
                              "${AppLocalizations.of(context)!.creditlineStatusAvailability}:",
                          enable: false,
                          controller: model.creditLineController,
                        ),
                    15.0.giveHeight,
                  ],
                ),
              ),
            ),
            10.0.giveHeight,
            Text(
              AppLocalizations.of(context)!.termConditions,
              style: AppTextStyles.normalCopyText,
            ),
            10.0.giveHeight,
            ShadowCard(
              isChild: true,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        model.openTerm(
                            3, AppLocalizations.of(context)!.billingTerms);
                      },
                      child: TabBarButton(
                        height: 30.0,
                        active: false,
                        text: AppLocalizations.of(context)!.billingTerms,
                      ),
                    ),
                    19.0.giveHeight,
                    GestureDetector(
                      onTap: () {
                        model.openTerm(
                            4, AppLocalizations.of(context)!.shippingCost);
                      },
                      child: TabBarButton(
                        height: 30.0,
                        active: false,
                        text: AppLocalizations.of(context)!.shippingCost,
                      ),
                    ),
                    19.0.giveHeight,
                    GestureDetector(
                      onTap: () {
                        model.openTerm(
                            5, AppLocalizations.of(context)!.otherConditions);
                      },
                      child: TabBarButton(
                        height: 30.0,
                        active: false,
                        text: AppLocalizations.of(context)!.otherConditions,
                      ),
                    ),
                    19.0.giveHeight,
                    InkWell(
                      onTap: model.changeTermRadioButton,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckedBox(
                            check: model.isTermAccepted,
                          ),
                          10.0.giveWidth,
                          Expanded(
                            child: CommonText(AppLocalizations.of(context)!
                                .termCheckBoxMessage
                                .isRequired),
                          )
                        ],
                      ),
                    ),
                    if (model.errorTermSelection.isNotEmpty)
                      Text(
                        model.errorTermSelection,
                        style: AppTextStyles.errorTextStyle,
                      ),
                  ],
                ),
              ),
            ),
            model.isBusy
                ? SizedBox(
                    height: 90.0,
                    child: Center(
                      child: Utils.loaderBusy(),
                    ),
                  )
                : Column(
                    children: [
                      CancelButton(
                        onPressed: () {
                          model.sendCreateOrderRequest(0, context);
                        },
                        width: 100.0.wp,
                        text: AppLocalizations.of(context)!.saveLaterButtonText,
                      ),
                      if (model.isUserHaveAccess(
                          UserRolesFiles.createTemplateAddOrder))
                        CancelButton(
                          onPressed: () {
                            model.sendCreateOrderRequest(1, context);
                          },
                          width: 100.0.wp,
                          text: AppLocalizations.of(context)!
                              .saveTemplateButtonText,
                        ),
                      SubmitButton(
                        onPressed: () {
                          model.sendCreateOrderRequest(2, context);
                        },
                        width: 100.0.wp,
                        text: AppLocalizations.of(context)!.sendButtonText,
                      ),
                    ],
                  ),
            20.0.giveHeight,
          ],
        ),
      ),
    );
  }

  button({required VoidCallback? onPressed, IconData icon = Icons.add}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
            borderRadius: AppRadius.buttonWidgetRadius,
            color: AppColors.lightAshColor),
        child: Center(
          child: Icon(
            icon,
            size: 14,
          ),
          // child: Text(
          //   text.toUpperCase(),
          //   // style: AppTextStyles.normalCopyText,
          // ),
        ),
      ),
    );
  }
}
