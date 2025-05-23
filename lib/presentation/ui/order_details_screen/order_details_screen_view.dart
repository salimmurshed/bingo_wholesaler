import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/utils_folder/order_summary_text.dart';
import '/const/all_const.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/utils.dart';
import '/presentation/ui/order_details_screen/order_details_screen_view_model.dart';
import '/presentation/widgets/cards/loader/loader.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/server_status_file/server_status_file.dart';

class OrderDetailsScreenView extends StatelessWidget {
  const OrderDetailsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailsScreenViewModel>.reactive(
        onViewModelReady: (OrderDetailsScreenViewModel model) =>
            model.callDetailsData(
                ModalRoute.of(context)!.settings.arguments as String, context),
        viewModelBuilder: () => OrderDetailsScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              // title: Text(model.enrollment.name),
              title: Text(model.orderDetail.isEmpty
                  ? ""
                  : model.isBusy
                      ? ""
                      : model.orderDetail[0].data!.orderDetails![0]
                          .wholesalerName!),
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
            ),
            body: Padding(
              padding: AppPaddings.borderCardPadding,
              child: SingleChildScrollView(
                child: model.isBusy
                    ? SizedBox(
                        height: 100.0.hp,
                        width: 100.0.wp,
                        child: const Center(
                          child: LoaderWidget(),
                        ),
                      )
                    : model.orderDetail.isEmpty
                        ? const Text("")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Utils.commonText(
                                  AppLocalizations.of(context)!.orderDetails,
                                  needPadding: false),
                              ShadowCard(
                                padding: 0.1,
                                // isChild: true,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 40.0.wp,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Utils.getNiceText(
                                              "${AppLocalizations.of(context)!.store}: \n${model.orderDetail[0].data!.orderDetails![0].storeName}"),
                                          10.0.giveHeight,
                                          Utils.getNiceText(
                                              "${AppLocalizations.of(context)!.dateOfTransaction}: \n${model.orderDetail[0].data!.orderDetails![0].dateOfTransaction}"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.0.wp,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Utils.getNiceText(
                                              "${AppLocalizations.of(context)!.wholesalerCamelkCase}: \n${model.orderDetail[0].data!.orderDetails![0].wholesalerName}"),
                                          10.0.giveHeight,
                                          Utils.getNiceText(
                                              "${AppLocalizations.of(context)!.descriptioN}\n${model.orderDetail[0].data!.orderDetails![0].orderDescription}"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              20.0.giveHeight,
                              Utils.commonText(
                                  AppLocalizations.of(context)!.products,
                                  needPadding: false),
                              if (model.orderDetail[0].data!.orderDetails![0]
                                  .orderLogs!.isEmpty)
                                ShadowCard(
                                  isChild: true,
                                  child: SizedBox(
                                    height: 100.0,
                                    child: Center(
                                      child: Text(AppLocalizations.of(context)!
                                          .noProductOrder),
                                    ),
                                  ),
                                ),
                              for (int i = 0;
                                  i <
                                      model.orderDetail[0].data!
                                          .orderDetails![0].orderLogs!.length;
                                  i++)
                                ShadowCard(
                                  isChild: true,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                "${model.orderDetail[0].data!.orderDetails![0].orderLogs![0].productDescription}"),
                                          ),
                                          10.0.giveWidth,
                                          Text(
                                            "${model.orderDetail[0].data!.orderDetails![0].orderLogs![0].sku}",
                                            style: AppTextStyles
                                                .statusCardSubTitle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 22.0.wp,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Utils.getNiceText(
                                                    "${AppLocalizations.of(context)!.quantity}: ${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].qty}"),
                                                10.0.giveHeight,
                                                Utils.getNiceText(
                                                    "${AppLocalizations.of(context)!.taxAmount}: \n${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].currency} ${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].tax}"),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Utils.getNiceText(
                                                    "${AppLocalizations.of(context)!.unitPrice}: ${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].currency} ${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].unitPrice}"),
                                                10.0.giveHeight,
                                                Utils.getNiceText(
                                                    "${AppLocalizations.of(context)!.amounT} \n${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].currency} ${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].amount}"),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0.wp,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Utils.getNiceText(
                                                    "${AppLocalizations.of(context)!.unit}: ${model.orderDetail[0].data!.orderDetails![0].orderLogs![i].unit}"),
                                                10.0.giveHeight,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              20.0.giveHeight,
                              if (model.orderDetail[0].data!.orderDetails!
                                  .isNotEmpty)
                                Utils.commonText(
                                    AppLocalizations.of(context)!.orderSummary,
                                    needPadding: false),
                              if (model.orderDetail[0].data!.orderDetails!
                                  .isNotEmpty)
                                ShadowCard(
                                  isChild: true,
                                  child: Column(
                                    children: [
                                      OrderSummaryText(
                                          AppLocalizations.of(context)!
                                              .iItemsQty,
                                          "",
                                          model.orderDetail[0].data!
                                              .orderDetails![0].itemsQty
                                              .toString()),
                                      OrderSummaryText(
                                          "${AppLocalizations.of(context)!.subTotal}:",
                                          "${model.orderDetail[0].data!.orderDetails![0].creditlineCurrency} ",
                                          model.orderDetail[0].data!
                                              .orderDetails![0].subTotal!
                                              .toStringAsFixed(2)),
                                      OrderSummaryText(
                                          "${AppLocalizations.of(context)!.tax}:",
                                          "${model.orderDetail[0].data!.orderDetails![0].creditlineCurrency} ",
                                          model.orderDetail[0].data!
                                              .orderDetails![0].totalTax!
                                              .toStringAsFixed(2)),
                                      OrderSummaryText(
                                          "${AppLocalizations.of(context)!.shippingCost}:",
                                          "${model.orderDetail[0].data!.orderDetails![0].creditlineCurrency} ",
                                          model.orderDetail[0].data!
                                              .orderDetails![0].shippingCost!
                                              .toStringAsFixed(2)),
                                      OrderSummaryText(
                                          "${AppLocalizations.of(context)!.total}:",
                                          "${model.orderDetail[0].data!.orderDetails![0].creditlineCurrency} ",
                                          (model.orderDetail[0].data!
                                                  .orderDetails![0].total)!
                                              .toStringAsFixed(2)),
                                      OrderSummaryText(
                                          "${AppLocalizations.of(context)!.grandTotal}:",
                                          "${model.orderDetail[0].data!.orderDetails![0].creditlineCurrency} ",
                                          model.orderDetail[0].data!
                                              .orderDetails![0].grandTotal!
                                              .toStringAsFixed(2)),
                                    ],
                                  ),
                                ),
                              20.0.giveHeight,
                              Utils.commonText(
                                  AppLocalizations.of(context)!
                                      .shippingInformation,
                                  needPadding: false),
                              ShadowCard(
                                isChild: true,
                                child: SizedBox(
                                  width: 100.0.wp,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.deliveryMethod}:\n${model.orderDetail[0].data!.orderDetails![0].deliveryMethodName} | ${model.orderDetail[0].data!.orderDetails![0].deliveryMethodDescription}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.deliveryDate}: ${model.orderDetail[0].data!.orderDetails![0].deliveryDate}"),
                                    ],
                                  ),
                                ),
                              ),
                              20.0.giveHeight,
                              Utils.commonText(
                                  AppLocalizations.of(context)!.payment,
                                  needPadding: false),
                              ShadowCard(
                                isChild: true,
                                child: SizedBox(
                                  width: 100.0.wp,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.paymentMethod}: ${model.orderDetail[0].data!.orderDetails![0].paymentMethodName}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.creditlineStatusAvailability}: \n${StatusFile.statusForCreditline(model.language, model.orderDetail[0].data!.orderDetails![0].creditlineStatus!, model.orderDetail[0].data!.orderDetails![0].creditlineStatusDescription!)} | ${model.orderDetail[0].data!.orderDetails![0].creditlineCurrency} ${model.orderDetail[0].data!.orderDetails![0].creditlineAvailableAmount!.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                              ),
                              20.0.giveHeight,
                            ],
                          ),
              ),
            ),
          );
        });
  }
}
