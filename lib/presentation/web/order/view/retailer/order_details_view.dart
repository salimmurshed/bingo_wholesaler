import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:bingo/presentation/widgets/cards/shadow_card.dart';
import 'package:bingo/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../../data_models/models/order_selection_model/order_selection_model.dart';
import '../../../../../data_models/models/user_model/user_model.dart';
import '../../../../../data_models/models/wholesaler_for_order_model/wholesaler_for_order_model.dart';
import '../../../../widgets/cards/error_check_image.dart';
import '../../../../widgets/checked_box.dart';
import '../../../../widgets/text/common_text.dart';
import '../../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../order_widget.dart';
import 'order_details_view_model.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView(
      {super.key, this.type, this.w, this.s, this.u, this.ot, this.id});
  final String? type;
  final String? w;
  final String? s;
  final String? u;
  final String? ot;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailsViewModel>.reactive(
        viewModelBuilder: () => OrderDetailsViewModel(),
        onViewModelReady: (OrderDetailsViewModel model) {
          model.prefill(type, w, s, ot, u, id);
        },
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
                            h1: 'Order Details',
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
            body: type == null && model.enrollment != UserTypeForWeb.retailer
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: Center(
                      child: Image.asset(
                        AppAsset.error404,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(
                          device != ScreenSize.wide ? 0.0 : 12.0),
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
                                    h1: 'Order Details',
                                  ),
                                if (model.enrollment == UserTypeForWeb.retailer)
                                  if (!model.isBusy)
                                    if (model.orderSelectionData != null)
                                      SizedBox(
                                        height: 60.0.hp,
                                        width: 100.0.wp,
                                        child: Container(
                                          color: AppColors.whiteColor,
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              aspectRatio: 0.1,
                                              enlargeCenterPage: true,
                                            ),
                                            items: model.orderSelectionData!
                                                .data!.promotions!
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
                                        ),
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
                                              'Order Details',
                                              style: AppTextStyles.headerText
                                                  .copyWith(
                                                      color: AppColors.loader4),
                                            ),
                                            const Divider(
                                              color: AppColors.dividerColor,
                                            ),
                                            model.enrollment ==
                                                    UserTypeForWeb.retailer
                                                ? retailerOrderPart(
                                                    model, context)
                                                : wholesalerOrderPart(
                                                    model, context),
                                            20.0.giveHeight,
                                            if ((model.selectedStore != null &&
                                                    model.selectedWholesaler !=
                                                        null &&
                                                    model.enrollment ==
                                                        UserTypeForWeb
                                                            .retailer) ||
                                                model.enrollment ==
                                                    UserTypeForWeb.wholesaler)
                                              SizedBox(
                                                width: 100.0.wp,
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: device ==
                                                                  ScreenSize
                                                                      .small
                                                              ? 80.0.wp
                                                              : 100.0.wp,
                                                          child: NameTextField(
                                                            hintStyle: AppTextStyles
                                                                .formTitleTextStyleNormal,
                                                            enable: model
                                                                    .viewType !=
                                                                2,
                                                            controller: model
                                                                .orderDesController,

                                                            fieldName:
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .description
                                                                    .isRequired,
                                                            // controller: ,
                                                          ),
                                                        ),
                                                        if (model.orderDesError
                                                            .isNotEmpty)
                                                          Text(
                                                            model.orderDesError,
                                                            style: AppTextStyles
                                                                .errorTextStyle,
                                                          ),
                                                        //orderDesError
                                                        20.0.giveHeight,
                                                      ],
                                                    ),
                                                    if (model.viewType != 2)
                                                      SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 100.0.wp,
                                                        child: SelectedDropdown(
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          fieldName:
                                                              "Search Product",
                                                          dropdownValue: model
                                                              .selectedSkuData,
                                                          items: model.skuData
                                                              .map((e) =>
                                                                  DropdownMenuItem<
                                                                      SkuData>(
                                                                    value: e,
                                                                    child: Text(
                                                                        e.productDescription!),
                                                                  ))
                                                              .toList(),
                                                          onChange:
                                                              (SkuData? v) {
                                                            model.selectProduct(
                                                                v!, v.sku!);
                                                          },
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            20.0.giveHeight,
                                            if (model
                                                .selectedProductList.isNotEmpty)
                                              Scrollbar(
                                                controller:
                                                    model.scrollController,
                                                thickness: 10,
                                                child: SingleChildScrollView(
                                                  controller:
                                                      model.scrollController,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: SizedBox(
                                                    width: device !=
                                                            ScreenSize.wide
                                                        ? null
                                                        : 100.0.wp - 64 - 64,
                                                    child: Table(
                                                      defaultVerticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      border: TableBorder.all(
                                                          color: AppColors
                                                              .whiteColor),
                                                      columnWidths: {
                                                        0: const FixedColumnWidth(
                                                            100.0),
                                                        1: device !=
                                                                ScreenSize.wide
                                                            ? const FixedColumnWidth(
                                                                200.0)
                                                            : const FlexColumnWidth(),
                                                        2: const FixedColumnWidth(
                                                            150.0),
                                                        3: const FixedColumnWidth(
                                                            150.0),
                                                        4: const FixedColumnWidth(
                                                            150.0),
                                                        5: const FixedColumnWidth(
                                                            150.0),
                                                        6: const FixedColumnWidth(
                                                            150.0),
                                                        7: const FixedColumnWidth(
                                                            150.0),
                                                        if (model.viewType != 2)
                                                          8: const FixedColumnWidth(
                                                              150.0),
                                                      },
                                                      children: [
                                                        TableRow(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppColors
                                                                  .tableHeaderColor,
                                                            ),
                                                            children: [
                                                              dataCellHd("SKU"),
                                                              dataCellHd(
                                                                  "Description"),
                                                              dataCellHd(
                                                                  "Unit Price"),
                                                              dataCellHd(
                                                                  "Currency"),
                                                              dataCellHd(
                                                                  "Quantity"),
                                                              dataCellHd(
                                                                  "Unit"),
                                                              dataCellHd(
                                                                  "Tax Amount"),
                                                              dataCellHd(
                                                                  "Net Amount"),
                                                              if (model
                                                                      .viewType !=
                                                                  2)
                                                                dataCellHd(
                                                                    "Action"),
                                                            ]),
                                                        for (int i = 0;
                                                            i <
                                                                model
                                                                    .selectedProductList
                                                                    .length;
                                                            i++)
                                                          TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Utils
                                                                  .tableBorder,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            children: [
                                                              textField(
                                                                  controller:
                                                                      model.selectedProductList[
                                                                              i]
                                                                          [
                                                                          'sku'],
                                                                  readOnly:
                                                                      true),
                                                              textField(
                                                                  align:
                                                                      TextAlign
                                                                          .left,
                                                                  controller: model
                                                                          .selectedProductList[
                                                                      i]['des'],
                                                                  readOnly:
                                                                      true),
                                                              textField(
                                                                  controller:
                                                                      model.selectedProductList[
                                                                              i]
                                                                          [
                                                                          'price'],
                                                                  readOnly:
                                                                      true,
                                                                  align: TextAlign
                                                                      .right),
                                                              textField(
                                                                  controller: model
                                                                          .selectedProductList[i]
                                                                      [
                                                                      'currency'],
                                                                  readOnly:
                                                                      true),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            12.0),
                                                                child:
                                                                    textFieldAmount(
                                                                        isView:
                                                                            model.viewType !=
                                                                                2,
                                                                        controller: model.selectedProductList[i]
                                                                            [
                                                                            'amount'],
                                                                        func: (String
                                                                            v) {
                                                                          model.changeTotal(
                                                                              v,
                                                                              i);
                                                                        },
                                                                        isCenter:
                                                                            false),
                                                              ),
                                                              textField(
                                                                  controller:
                                                                      model.selectedProductList[
                                                                              i]
                                                                          [
                                                                          'unit'],
                                                                  readOnly:
                                                                      true),
                                                              textField(
                                                                  controller: model
                                                                          .selectedProductList[i]
                                                                      [
                                                                      'accTax'],
                                                                  readOnly:
                                                                      true,
                                                                  align: TextAlign
                                                                      .right),
                                                              textField(
                                                                  controller:
                                                                      model.selectedProductList[
                                                                              i]
                                                                          [
                                                                          'total'],
                                                                  readOnly:
                                                                      true,
                                                                  align: TextAlign
                                                                      .right),
                                                              if (model
                                                                      .viewType !=
                                                                  2)
                                                                IconButton(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            12.0),
                                                                    onPressed:
                                                                        () {
                                                                      model.deleteItem(
                                                                          i);
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: AppColors
                                                                          .redColor,
                                                                    )),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            20.0.giveHeight,
                                            if (model.enrollment ==
                                                UserTypeForWeb.retailer)
                                              if (model.viewType != 2)
                                                if (model.selectedProductList
                                                    .isNotEmpty)
                                                  if (model
                                                          .selectedWholesaler !=
                                                      null)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(),
                                                        Flex(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment: device ==
                                                                  ScreenSize
                                                                      .wide
                                                              ? MainAxisAlignment
                                                                  .spaceBetween
                                                              : MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment: device ==
                                                                  ScreenSize
                                                                      .wide
                                                              ? CrossAxisAlignment
                                                                  .center
                                                              : CrossAxisAlignment
                                                                  .start,
                                                          direction: device ==
                                                                  ScreenSize
                                                                      .wide
                                                              ? Axis.horizontal
                                                              : Axis.vertical,
                                                          children: [
                                                            SizedBox(
                                                              width: device ==
                                                                      ScreenSize
                                                                          .small
                                                                  ? 80.0.wp
                                                                  : 30.0.wp,
                                                              height: 70.0,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  NameTextField(
                                                                    hintStyle:
                                                                        AppTextStyles
                                                                            .formTitleTextStyleNormal,
                                                                    controller:
                                                                        model
                                                                            .promoCodeController,
                                                                    fieldName:
                                                                        "Promocode",
                                                                  ),
                                                                  if (model
                                                                      .promoErrorMessage
                                                                      .isNotEmpty)
                                                                    Text(
                                                                      model
                                                                          .promoErrorMessage,
                                                                      style: AppTextStyles
                                                                          .errorTextStyle,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            model.isPromoLoading
                                                                ? SizedBox(
                                                                    width: device ==
                                                                            ScreenSize
                                                                                .small
                                                                        ? 80.0
                                                                            .wp
                                                                        : 100.0,
                                                                    child:
                                                                        Center(
                                                                      child: Utils
                                                                          .loaderBusy(),
                                                                    ),
                                                                  )
                                                                : SubmitButton(
                                                                    onPressed:
                                                                        () {
                                                                      model
                                                                          .applyPromoCode();
                                                                    },
                                                                    height: 45,
                                                                    width: device ==
                                                                            ScreenSize
                                                                                .small
                                                                        ? 80.0
                                                                            .wp
                                                                        : 100.0,
                                                                    isRadius:
                                                                        false,
                                                                    text:
                                                                        "Apply",
                                                                  )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                            if (model
                                                .selectedProductList.isNotEmpty)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Order Summary',
                                                    style: AppTextStyles
                                                        .headerText
                                                        .copyWith(
                                                            color: AppColors
                                                                .loader4),
                                                  ),
                                                  const Divider(
                                                    color:
                                                        AppColors.dividerColor,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      if (device !=
                                                          ScreenSize.small)
                                                        const SizedBox(),
                                                      SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 40.0.wp,
                                                        child: Column(
                                                          children: [
                                                            summaryItem(
                                                                "Items Qty:",
                                                                model
                                                                    .totalItemCount
                                                                    .toString()),
                                                            summaryItem(
                                                                "Subtotal:",
                                                                Utils.stringTo2Decimal(
                                                                    model
                                                                        .getSubTotal())),
                                                            summaryItem(
                                                                "Tax:",
                                                                Utils.stringTo2Decimal(
                                                                    model
                                                                        .getTotalTax())),
                                                            summaryItem(
                                                                "Total:",
                                                                Utils.stringTo2Decimal(
                                                                    model
                                                                        .getTotal())),
                                                            summaryItem(
                                                                "Shipping Cost:",
                                                                model.selectedDeliveryMethod ==
                                                                        null
                                                                    ? "0.00"
                                                                    : Utils
                                                                        .formatter
                                                                        .format(model.selectedDeliveryMethod!.shippingAndHandlingCost ??
                                                                            0.0)),
                                                            summaryItem(
                                                                "Grand Total:",
                                                                Utils.stringTo2Decimal(
                                                                    model
                                                                        .getGrandTotal())),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  20.0.giveHeight,
                                                ],
                                              ),
                                            if (model
                                                .selectedProductList.isNotEmpty)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Shipping Information',
                                                    style: AppTextStyles
                                                        .headerText
                                                        .copyWith(
                                                            color: AppColors
                                                                .loader4),
                                                  ),
                                                  const Divider(
                                                    color:
                                                        AppColors.dividerColor,
                                                  ),
                                                  Flex(
                                                    direction: device ==
                                                            ScreenSize.wide
                                                        ? Axis.horizontal
                                                        : Axis.vertical,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: device ==
                                                                  ScreenSize
                                                                      .small
                                                              ? 80.0.wp
                                                              : 240.0,
                                                          child: CommonText(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .selectDeliveryMethod
                                                                  .isRequired)),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: device ==
                                                                    ScreenSize
                                                                        .small
                                                                ? 80.0.wp
                                                                : 240.0,
                                                            child: SelectedDropdown<
                                                                    DeliveryMethod>(
                                                                hintStyle:
                                                                    AppTextStyles
                                                                        .formTitleTextStyleNormal,
                                                                isDisable: !(model
                                                                            .enrollment ==
                                                                        UserTypeForWeb
                                                                            .wholesaler &&
                                                                    model.viewType ==
                                                                        1),
                                                                items: model.enrollment ==
                                                                        UserTypeForWeb
                                                                            .retailer
                                                                    ? model.orderSelectionData ==
                                                                            null
                                                                        ? []
                                                                        : model
                                                                            .deliveryMethods
                                                                            .map(
                                                                              (e) => DropdownMenuItem<DeliveryMethod>(
                                                                                value: e,
                                                                                child: Text(e.deliveryMethod ?? ""),
                                                                              ),
                                                                            )
                                                                            .toList()
                                                                    : model
                                                                        .deliveryMethods
                                                                        .map(
                                                                          (e) =>
                                                                              DropdownMenuItem<DeliveryMethod>(
                                                                            value:
                                                                                e,
                                                                            child:
                                                                                Text(e.deliveryMethod ?? ""),
                                                                          ),
                                                                        )
                                                                        .toList(),
                                                                dropdownValue: model
                                                                    .selectedDeliveryMethod,
                                                                hintText:
                                                                    "Select Delivery Method",
                                                                onChange:
                                                                    (DeliveryMethod
                                                                        v) {
                                                                  model
                                                                      .changeDeliveryMethod(
                                                                          v);
                                                                }),
                                                          ),
                                                          if (model
                                                              .errorDeliveryMethod
                                                              .isNotEmpty)
                                                            Text(
                                                              model
                                                                  .errorDeliveryMethod,
                                                              style: AppTextStyles
                                                                  .errorTextStyle,
                                                            ),
                                                          15.0.giveHeight,
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  20.0.giveHeight,
                                                  Flex(
                                                    direction: device ==
                                                            ScreenSize.wide
                                                        ? Axis.horizontal
                                                        : Axis.vertical,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: device ==
                                                                  ScreenSize
                                                                      .small
                                                              ? 80.0.wp
                                                              : 240.0,
                                                          child: const CommonText(
                                                              "Delivery Date")),
                                                      SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 240.0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (model.enrollment ==
                                                                        UserTypeForWeb
                                                                            .wholesaler &&
                                                                    model.viewType ==
                                                                        1) {
                                                                  model
                                                                      .openCalender();
                                                                }
                                                              },
                                                              child:
                                                                  AbsorbPointer(
                                                                child:
                                                                    NameTextField(
                                                                  hintStyle:
                                                                      AppTextStyles
                                                                          .formTitleTextStyleNormal,
                                                                  controller: model
                                                                      .deliveryDateController,
                                                                  hintText:
                                                                      "Delivery Date",
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                              ),
                                                            ),
                                                            if (model
                                                                .deliveryDateErrorMessage
                                                                .isNotEmpty)
                                                              Text(
                                                                model
                                                                    .deliveryDateErrorMessage,
                                                                style: AppTextStyles
                                                                    .errorTextStyle,
                                                              ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            20.0.giveHeight,
                                            if (model
                                                .selectedProductList.isNotEmpty)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Payment',
                                                    style: AppTextStyles
                                                        .headerText
                                                        .copyWith(
                                                            color: AppColors
                                                                .loader4),
                                                  ),
                                                  const Divider(
                                                    color:
                                                        AppColors.dividerColor,
                                                  ),
                                                  Flex(
                                                    direction: device ==
                                                            ScreenSize.wide
                                                        ? Axis.horizontal
                                                        : Axis.vertical,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 240.0,
                                                        child: CommonText(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .selectPaymentMethod
                                                                .isRequired),
                                                      ),
                                                      SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 240.0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            if (model
                                                                    .enrollment ==
                                                                UserTypeForWeb
                                                                    .retailer)
                                                              SelectedDropdown<
                                                                      PaymentMethod>(
                                                                  hintStyle:
                                                                      AppTextStyles
                                                                          .formTitleTextStyleNormal,
                                                                  hintText:
                                                                      "Select Payment Method",
                                                                  isDisable:
                                                                      model.viewType ==
                                                                          2,
                                                                  items: model.orderSelectionData ==
                                                                          null
                                                                      ? []
                                                                          .map(
                                                                            (e) =>
                                                                                DropdownMenuItem<PaymentMethod>(
                                                                              value: e,
                                                                              child: Text(e.paymentMethod!),
                                                                            ),
                                                                          )
                                                                          .toList()
                                                                      : model
                                                                          .orderSelectionData!
                                                                          .data!
                                                                          .paymentMethod!
                                                                          .map(
                                                                            (e) =>
                                                                                DropdownMenuItem<PaymentMethod>(
                                                                              value: e,
                                                                              child: Text(e.paymentMethod!),
                                                                            ),
                                                                          )
                                                                          .toList(),
                                                                  dropdownValue:
                                                                      model
                                                                          .selectedPaymentMethod,
                                                                  onChange:
                                                                      (PaymentMethod
                                                                          v) {
                                                                    model
                                                                        .changePaymentMethod(
                                                                            v);
                                                                  }),
                                                            if (model
                                                                    .enrollment ==
                                                                UserTypeForWeb
                                                                    .wholesaler)
                                                              SizedBox(
                                                                width: device ==
                                                                        ScreenSize
                                                                            .small
                                                                    ? 80.0.wp
                                                                    : 240.0,
                                                                child:
                                                                    NameTextField(
                                                                  hintStyle:
                                                                      AppTextStyles
                                                                          .formTitleTextStyleNormal,
                                                                  controller: model
                                                                      .paymentMethodeController,
                                                                  hintText:
                                                                      "Status | Available Amount",
                                                                  enable: false,
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                              ),
                                                            if (model
                                                                .errorPaymentMethod
                                                                .isNotEmpty)
                                                              Text(
                                                                model
                                                                    .errorPaymentMethod,
                                                                style: AppTextStyles
                                                                    .errorTextStyle,
                                                              ),
                                                            15.0.giveHeight,
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  20.0.giveHeight,
                                                  Flex(
                                                    direction: device ==
                                                            ScreenSize.wide
                                                        ? Axis.horizontal
                                                        : Axis.vertical,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: device ==
                                                                  ScreenSize
                                                                      .small
                                                              ? 80.0.wp
                                                              : 240.0,
                                                          child: const CommonText(
                                                              "Creditline Status & Availability")),
                                                      SizedBox(
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 240.0,
                                                        child: NameTextField(
                                                          hintStyle: AppTextStyles
                                                              .formTitleTextStyleNormal,
                                                          controller: model
                                                              .creditLineController,
                                                          hintText:
                                                              "Status | Available Amount",
                                                          enable: true,
                                                          readOnly: true,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            20.0.giveHeight,
                                            if (model.selectedProductList
                                                    .isNotEmpty &&
                                                model.viewType != 2 &&
                                                (model.enrollment ==
                                                    UserTypeForWeb.retailer))
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Terms & Condition',
                                                    style: AppTextStyles
                                                        .headerText
                                                        .copyWith(
                                                            color: AppColors
                                                                .loader4),
                                                  ),
                                                  const Divider(
                                                    color:
                                                        AppColors.dividerColor,
                                                  ),
                                                  ShadowCard(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            NavButton(
                                                              onTap: () {
                                                                model
                                                                    .changeSelectedTerms(
                                                                        0);
                                                              },
                                                              isBottom: model
                                                                      .selectedTerms ==
                                                                  0,
                                                              text:
                                                                  "Bill Terms",
                                                            ),
                                                            NavButton(
                                                              onTap: () {
                                                                model
                                                                    .changeSelectedTerms(
                                                                        1);
                                                              },
                                                              isBottom: model
                                                                      .selectedTerms ==
                                                                  1,
                                                              text:
                                                                  "Shipping Terms",
                                                            ),
                                                            NavButton(
                                                              onTap: () {
                                                                model
                                                                    .changeSelectedTerms(
                                                                        2);
                                                              },
                                                              isBottom: model
                                                                      .selectedTerms ==
                                                                  2,
                                                              text: "Other",
                                                            ),
                                                          ],
                                                        ),
                                                        20.0.giveHeight,
                                                        CommonText(
                                                          model.selectedTerms ==
                                                                  0
                                                              ? "Billing Terms and Conditions"
                                                              : model.selectedTerms ==
                                                                      1
                                                                  ? "Shipping Terms and Conditions"
                                                                  : "Other Terms and Conditions",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                        ),
                                                        20.0.giveHeight,
                                                        CommonText(model
                                                                    .selectedTerms ==
                                                                0
                                                            ? "These Terms and Conditions (\"Agreement\") governs the use of the services (\"Service\") that are made available by Website.com Solutions Inc. (\"Website.com\", \"we\" or \"us\"). These Terms and Conditions represent the whole agreement and understanding between Website.com and the individual or entity who subscribes to our service (\"Subscriber\" or \"you\"). PLEASE READ THIS AGREEMENT CAREFULLY. By submitting your application and by your use of the Service, you agree to comply with all of the terms and conditions set out in this Agreement. Website.com may terminate your account at any time, with or without notice, for conduct that is in breach of this Agreement, for conduct that Website.com believes is harmful to its business, or for conduct where the use of the Service is harmful to any other party.Website.com may, in its sole discretion, change or modify this Agreement at any time, with or without notice. Such changes or modifications shall be made effective for all Subscribers upon posting of the modified Agreement to this web address You are responsible to read this document from time to time to ensure that your use of the Service remains in compliance with this Agreement."
                                                            : model.selectedTerms ==
                                                                    1
                                                                ? "These Terms and Conditions (\"Agreement\") governs the use of the services (\"Service\") that are made available by Website.com Solutions Inc. (\"Website.com\", \"we\" or \"us\"). These Terms and Conditions represent the whole agreement and understanding between Website.com and the individual or entity who subscribes to our service (\"Subscriber\" or \"you\"). PLEASE READ THIS AGREEMENT CAREFULLY. By submitting your application and by your use of the Service, you agree to comply with all of the terms and conditions set out in this Agreement. Website.com may terminate your account at any time, with or without notice, for conduct that is in breach of this Agreement, for conduct that Website.com believes is harmful to its business, or for conduct where the use of the Service is harmful to any other party.Website.com may, in its sole discretion, change or modify this Agreement at any time, with or without notice. Such changes or modifications shall be made effective for all Subscribers upon posting of the modified Agreement to this web address (URL): http://www.website.com/terms-and-conditions/. You are responsible to read this document from time to time to ensure that your use of the Service remains in compliance with this Agreement."
                                                                : "These Terms and Conditions (\"Agreement\") governs the use of the services (\"Service\") that are made available by Website.com Solutions Inc. (\"Website.com\", \"we\" or \"us\"). These Terms and Conditions represent the whole agreement and understanding between Website.com and the individual or entity who subscribes to our service (\"Subscriber\" or \"you\"). PLEASE READ THIS AGREEMENT CAREFULLY. By submitting your application and by your use of the Service, you agree to comply with all of the terms and conditions set out in this Agreement. Website.com may terminate your account at any time, with or without notice, for conduct that is in breach of this Agreement, for conduct that Website.com believes is harmful to its business, or for conduct where the use of the Service is harmful to any other party.Website.com may, in its sole discretion, change or modify this Agreement at any time, with or without notice. Such changes or modifications shall be made effective for all Subscribers upon posting of the modified Agreement to this web address (URL): http://www.website.com/terms-and-conditions/. You are responsible to read this document from time to time to ensure that your use of the Service remains in compliance with this Agreement.")
                                                      ],
                                                    ),
                                                  ),
                                                  20.0.giveHeight,
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      InkWell(
                                                        onTap:
                                                            model.selectTerms,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CheckedBox(
                                                              check: model
                                                                  .isTermAccepted,
                                                            ),
                                                            10.0.giveWidth,
                                                            Expanded(
                                                              child: RichText(
                                                                text:
                                                                    const TextSpan(
                                                                  text:
                                                                      'I agree to all the  ',
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Terms & Conditions.',
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.blueColor)),
                                                                    TextSpan(
                                                                        text:
                                                                            ' and I Have Read All Terms and Conditions Carefully.'),
                                                                    TextSpan(
                                                                        text:
                                                                            '*',
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.redColor)),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      if (model
                                                          .termAcceptedError
                                                          .isNotEmpty)
                                                        Text(
                                                          model
                                                              .termAcceptedError,
                                                          style: AppTextStyles
                                                              .errorTextStyle,
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            10.0.giveHeight,
                                            if (!model.isBusy &&
                                                !model.busy(model.submitBusy))
                                              if ((model.selectedStore !=
                                                          null &&
                                                      model.selectedWholesaler !=
                                                          null &&
                                                      model.selectedProductList
                                                          .isNotEmpty) &&
                                                  model.viewType != 2)
                                                if (model.enrollment ==
                                                    UserTypeForWeb.retailer)
                                                  Flex(
                                                    direction: device ==
                                                            ScreenSize.wide
                                                        ? Axis.horizontal
                                                        : Axis.vertical,
                                                    children: [
                                                      SubmitButton(
                                                        onPressed: () {
                                                          model
                                                              .sendCreateOrderRequest(
                                                                  0, context);
                                                        },
                                                        isRadius: false,
                                                        color:
                                                            AppColors.blueColor,
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 200.0,
                                                        height: 45.0,
                                                        text: "Save for later",
                                                      ),
                                                      SubmitButton(
                                                        onPressed: () {
                                                          model
                                                              .sendCreateOrderRequest(
                                                                  1, context);
                                                        },
                                                        isRadius: false,
                                                        color: AppColors
                                                            .blackColor,
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 200.0,
                                                        height: 45.0,
                                                        text:
                                                            "Save as template",
                                                      ),
                                                      SubmitButton(
                                                        onPressed: () {
                                                          model
                                                              .sendCreateOrderRequest(
                                                                  2, context);
                                                        },
                                                        isRadius: false,
                                                        color: AppColors
                                                            .bingoGreen,
                                                        width: device ==
                                                                ScreenSize.small
                                                            ? 80.0.wp
                                                            : 200.0,
                                                        height: 45.0,
                                                        text: "Submit",
                                                      ),
                                                    ],
                                                  ),
                                            if (!model.isBusy &&
                                                !model.busy(model.submitBusy))
                                              if (model.enrollment ==
                                                  UserTypeForWeb.wholesaler)
                                                if (model.viewType != 2)
                                                  SubmitButton(
                                                    onPressed: () {
                                                      model.update(context);
                                                    },
                                                    isRadius: false,
                                                    color: AppColors.bingoGreen,
                                                    width: device ==
                                                            ScreenSize.small
                                                        ? 80.0.wp
                                                        : 200.0,
                                                    height: 45.0,
                                                    text: "Update",
                                                  ),
                                            if (model.busy(model.submitBusy))
                                              Utils.loaderBusy()
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

  Widget retailerOrderPart(OrderDetailsViewModel model, BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Wrap(
        runSpacing: 20.0,
        // spacing: 50.0,
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(
            width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
            child: SelectedDropdown(
              hintStyle: AppTextStyles.formTitleTextStyleNormal,
              isDisable: model.viewType == 2,
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
              fieldName: AppLocalizations.of(context)!.selectStore.isRequired,
            ),
          ),
          SizedBox(
              width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
              child: SelectedDropdown(
                  hintStyle: AppTextStyles.formTitleTextStyleNormal,
                  isDisable: model.viewType == 2,
                  dropdownValue: model.selectedWholesaler,
                  fieldName:
                      AppLocalizations.of(context)!.selectWholeSaler.isRequired,
                  hintText: AppLocalizations.of(context)!.selectWholeSaler,
                  items: model.wholesaler
                      .map(
                        (e) => DropdownMenuItem<WholesalerForOrderData>(
                          value: e,
                          child: Text(e.name!),
                        ),
                      )
                      .toList(),
                  onChange: (v) {
                    model.changeWholesaler(v);
                  })),
          SizedBox(
            width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
            child: NameTextField(
              hintStyle: AppTextStyles.formTitleTextStyleNormal,
              enable: false,
              readOnly: true,
              controller: model.dateOfTransactionController,

              fieldName: "Date Of Transaction",
              // controller: ,
            ),
          ),
        ],
      ),
    );
  }

  Widget wholesalerOrderPart(
      OrderDetailsViewModel model, BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      alignment: WrapAlignment.spaceBetween,
      runAlignment: WrapAlignment.spaceBetween,
      children: [
        field(title: "Retailer Name", controller: model.retailerNameController),
        field(title: "Wholesaler", controller: model.wholesalerNameController),
        field(title: "Store Name", controller: model.storeNameController),
        field(
            title: "Date Of Transaction",
            controller: model.dateOfTransactionController),
        field(title: "Bingo Order ID", controller: model.bingoIdController),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            field(
                title: "Order Number",
                enable: true,
                controller: model.orderNumberController),
            if (model.orderNumberErrorMessage.isNotEmpty)
              Text(
                model.orderNumberErrorMessage,
                style: AppTextStyles.errorTextStyle,
              ),
          ],
        ),
        field(
            title: "Invoice Number",
            enable: true,
            controller: model.invoiceNumberController),
        field(
            title: "Tax Receipt Number",
            enable: true,
            controller: model.taxReceiptController),
        SizedBox(
          width: device == ScreenSize.small ? 90.0.wp : 30.0.wp,
        ),
      ],
    );
  }

  Widget field(
      {required String title,
      TextEditingController? controller,
      bool enable = false}) {
    return SizedBox(
      width: device == ScreenSize.small ? 90.0.wp : 30.0.wp,
      child: NameTextField(
        hintStyle: AppTextStyles.formTitleTextStyleNormal,
        enable: enable,
        readOnly: !enable,
        controller: controller,

        fieldName: title,
        // controller: ,
      ),
    );
  }
}
