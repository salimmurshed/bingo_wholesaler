import 'dart:convert';

import 'package:bingo/const/app_colors.dart';

import '../../../data_models/construction_model/sale_edit_data/sale_edit_data.dart';
import '../../../data_models/enums/user_roles_files.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_sizes/app_sizes.dart';
import '/const/utils.dart';
import '/presentation/ui/sales_details_screen/sales_details_screen_view_model.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/cards/sales_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/server_status_file/server_status_file.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/shadow_card.dart';

class SalesDetailsScreenView extends StatelessWidget {
  const SalesDetailsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesDetailsScreenViewModel>.reactive(
        onViewModelReady: (SalesDetailsScreenViewModel model) {
          model.checkInternet();

          if (ModalRoute.of(context)!.settings.arguments.runtimeType ==
              AllSalesData) {
            model.setData(
                ModalRoute.of(context)!.settings.arguments as AllSalesData);
          } else if (ModalRoute.of(context)!.settings.arguments.runtimeType ==
              SaleEditData) {
            model.setDataFromTodo(
                ModalRoute.of(context)!.settings.arguments as SaleEditData);
          } else {
            model.setDataFromSaleList(ModalRoute.of(context)!.settings.arguments
                as OfflineOnlineSalesModel);
          }
        },
        viewModelBuilder: () => SalesDetailsScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                onPressed: model.goBack,
              ),
              title: AppBarText(
                  AppLocalizations.of(context)!.salesDetails.toUpperCase()),
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: AppPaddings.bodyVertical,
                    child: ShadowCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  (model.allSalesData.invoiceNumber ?? "")
                                              .isEmpty ||
                                          model.allSalesData.invoiceNumber ==
                                              "-"
                                      ? model.allSalesData.orderNumber ?? "-"
                                      : model.allSalesData.invoiceNumber ?? "-",
                                  style: AppTextStyles.dashboardHeadTitle
                                      .copyWith(
                                          fontWeight: AppFontWeighs.semiBold),
                                ),
                              ),
                              10.0.giveWidth,
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(minWidth: 100.0),
                                child: Text(
                                  "${model.allSalesData.currency} ${model.allSalesData.amount}",
                                  textAlign: TextAlign.end,
                                  style: AppTextStyles.dashboardHeadTitle
                                      .copyWith(
                                          fontWeight: AppFontWeighs.semiBold),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: AppColors.dividerColor,
                          ),
                          Text(
                            AppLocalizations.of(context)!.status,
                            style: AppTextStyles.dashboardHeadTitle,
                          ),
                          model.allSalesData.status!.toSaleStatus(
                              text: StatusFile.statusForSale(
                                  model.language,
                                  model.allSalesData.status!,
                                  model.allSalesData.statusDescription!),
                              isCenter: true),
                          const Divider(color: AppColors.dividerColor),
                          model.enrollment == UserTypeForWeb.retailer
                              ? SalesDetails(
                                  data: [
                                    "${AppLocalizations.of(context)!.invoiceFrom}:"
                                        " ${model.allSalesData.wholesalerName!.emptyCheck()}",
                                    // "${AppLocalizations.of(context)!.wholesalerId}"
                                    //     " ${model.allSalesData.wholesalerStoreId!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.fiaName}:"
                                        " ${model.allSalesData.fieName!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.dateOfInvoice}"
                                        " ${model.allSalesData.saleDate!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.orderNumber}:"
                                        " ${model.allSalesData.orderNumber!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.dueDate}:"
                                        " ${model.allSalesData.dueDate!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.bingoStoreID}"
                                        " ${model.allSalesData.bingoOrderId!.emptyCheck()} ",
                                    // "${double.parse(model.allSalesData.amount! ?? "0").toStringAsFixed(2)}",
                                    "${AppLocalizations.of(context)!.salesStep}:"
                                        " ${model.getSalesType()}",
                                  ],
                                )
                              : SalesDetails(
                                  data: [
                                    "${AppLocalizations.of(context)!.invoiceTo}:"
                                        " ${model.allSalesData.retailerName}",
                                    "${AppLocalizations.of(context)!.wholesalerId}:"
                                        " ${model.allSalesData.wholesalerStoreId!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.sr}"
                                        "-",
                                    "${AppLocalizations.of(context)!.bingoOrderId}"
                                        " ${model.allSalesData.bingoOrderId!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.saleDate}:"
                                        " ${model.allSalesData.saleDate!}",
                                    "${AppLocalizations.of(context)!.dueDate}:"
                                        " ${model.allSalesData.dueDate!}",
                                    "${AppLocalizations.of(context)!.saleId}"
                                        " ${model.getSaleId(model.allSalesData.uniqueId!)}",
                                    "${AppLocalizations.of(context)!.orderID}"
                                        " ${model.allSalesData.orderNumber == null ? "-" : model.allSalesData.orderNumber!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.fiaName}:"
                                        " ${model.allSalesData.fieName!.emptyCheck()}",
                                    "${AppLocalizations.of(context)!.balance}: "
                                        "${model.allSalesData.currency!} ${model.allSalesData.balance!}",
                                  ],
                                ),
                          10.0.giveHeight,
                          if (model.enrollment == UserTypeForWeb.wholesaler &&
                              model.allSalesData.status != 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SubmitButton(
                                onPressed: model.openQRDialog,
                                active: true,
                                height: 45.0,
                                text:
                                    model.enrollment == UserTypeForWeb.retailer
                                        ? AppLocalizations.of(context)!
                                            .generateQRCode
                                            .toUpperCase()
                                        : AppLocalizations.of(context)!
                                            .generateQRCode
                                            .toUpperCase(),
                              ),
                            ),
                          if (model.isOfflineOrOnlineFromSaleList != null)
                            if (model.enrollment == UserTypeForWeb.retailer)
                              if ((model.allSalesData.status != 8 &&
                                      model.allSalesData.status == 1) ||
                                  model.allSalesData.status == 2 ||
                                  model.isOfflineOrOnlineFromSaleList!)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SubmitButton(
                                    onPressed: model.openQRDialog,
                                    active: true,
                                    height: 45.0,
                                    text: model.enrollment ==
                                            UserTypeForWeb.retailer
                                        ? AppLocalizations.of(context)!
                                            .generateQRCode
                                            .toUpperCase()
                                        : AppLocalizations.of(context)!
                                            .generateQRCode
                                            .toUpperCase(),
                                  ),
                                ),
                          if (!model.connectivity)
                            if (model.allSalesData.status == 6 &&
                                model.allSalesData.saleType!.toLowerCase() ==
                                    "1s")
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SubmitButton(
                                  onPressed: model.openQRDialog,
                                  active: true,
                                  height: 45.0,
                                  text: AppLocalizations.of(context)!
                                      .generateQRCode
                                      .toUpperCase(),
                                ),
                              ),
                          if (model.allSalesData.status != 6 &&
                              model.allSalesData.status != 2 &&
                              model.allSalesData.status != 8)
                            model.isButtonBusy
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Utils.loaderBusy(),
                                  )
                                : Column(
                                    children: [
                                      if (model.enrollment ==
                                              UserTypeForWeb.retailer &&
                                          (model.allSalesData.status == 6 ||
                                              model.allSalesData.status == 7))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SubmitButton(
                                            onPressed:
                                                model.confirmDeliveryRequest,
                                            active: true,
                                            height: 45.0,
                                            text: AppLocalizations.of(context)!
                                                .confirmDelivery
                                                .toUpperCase(),
                                          ),
                                        ),
                                      if ((model.allSalesData.status == 1 ||
                                              model.allSalesData.status == 7) &&
                                          model.enrollment ==
                                              UserTypeForWeb.retailer &&
                                          model.connectivity &&
                                          model.allSalesData.isStartPayment ==
                                              1)
                                        model.startPaymentButtonBusy
                                            ? SizedBox(
                                                height: 45.0,
                                                child: Utils.loaderBusy(),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SubmitButton(
                                                  onPressed: () {
                                                    model.startPayment(model
                                                        .allSalesData
                                                        .uniqueId!);
                                                  },
                                                  active: true,
                                                  height: 45.0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .startPayment
                                                      .toUpperCase(),
                                                ),
                                              ),
                                      if (model.allSalesData.status != 1 &&
                                          model.allSalesData.status != 6 &&
                                          model.allSalesData.status != 4)
                                        Column(
                                          children: [
                                            if (model.isUserHaveAccess(
                                                UserRolesFiles.approveSales))
                                              if (model.enrollment ==
                                                  UserTypeForWeb.retailer)
                                                if (model.allSalesData.status !=
                                                        7 &&
                                                    model.allSalesData.status !=
                                                        5)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SubmitButton(
                                                      onPressed:
                                                          model.approveRequest,
                                                      active: true,
                                                      height: 45.0,
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .approve
                                                          .toUpperCase(),
                                                    ),
                                                  ),
                                            if (model.enrollment ==
                                                UserTypeForWeb.retailer)
                                              if (model.allSalesData.status !=
                                                  5)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: SubmitButton(
                                                    onPressed:
                                                        model.rejectRequest,
                                                    color:
                                                        AppColors.statusReject,
                                                    active: true,
                                                    height: 45.0,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .reject
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      if (model.enrollment ==
                                          UserTypeForWeb.wholesaler)
                                        if (model.allSalesData.status != 1)
                                          model.isButtonBusy
                                              ? Utils.loaderBusy()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: CancelButton(
                                                    onPressed: model.gotoEdit,
                                                    active: true,
                                                    height: 45.0,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .edit
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                      if (model.enrollment ==
                                          UserTypeForWeb.wholesaler)
                                        if (model.allSalesData.status != 1)
                                          model.isButtonBusy
                                              ? Utils.loaderBusy()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: SubmitButton(
                                                    onPressed: model.cancelSale,
                                                    color: AppColors.redColor,
                                                    active: true,
                                                    height: 45.0,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .cancelButton
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                      if (model.isUserHaveAccess(
                                          UserRolesFiles.viewStatement))
                                        if (model
                                                .isOfflineOrOnlineFromSaleList !=
                                            null)
                                          if (model.enrollment ==
                                              UserTypeForWeb.retailer)
                                            if (model.allSalesData.status ==
                                                    1 &&
                                                !model
                                                    .isOfflineOrOnlineFromSaleList!)
                                              model.busy(model.allTransaction)
                                                  ? Center(
                                                      child: Utils.loaderBusy(),
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8.0),
                                                          child: SubmitButton(
                                                            onPressed: model
                                                                .getSaleTransactionDetails,
                                                            height: 45.0,
                                                            text: AppLocalizations
                                                                    .of(context)!
                                                                .loadStatement,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                      // StatementCard()
                                    ],
                                  ),
                          if ((model.enrollment == UserTypeForWeb.retailer &&
                                  (model.allSalesData.status != 1 &&
                                      model.allSalesData.status != 2)) ||
                              (model.enrollment == UserTypeForWeb.wholesaler &&
                                  (model.allSalesData.status != 2 &&
                                      model.allSalesData.status != 1 &&
                                      model.allSalesData.status != 8)))
                            if (!model.isButtonBusy)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SubmitButton(
                                      onPressed: () {
                                        model.readQrScanner(context);
                                      },
                                      height: 45.0,
                                      text: AppLocalizations.of(context)!
                                          .offlineUpdate,
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
