part of '../../ui/static_screen/static_screen_view.dart';

class SalesTab extends StatelessWidget {
  SalesTab(this.model, {Key? key}) : super(key: key);
  StaticViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.isBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.loader1,
            displacement: 40.0.hp,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            // color: AppColors.appBarColorRetailer,
            onRefresh: model.refreshWholesalersSalesData,
            child: SizedBox(
              height: 100.0.hp,
              width: 100.0.wp,
              child: Column(
                children: [
                  if (model.isSaleMessageShow)
                    GestureDetector(
                      onTap: () {
                        model.gotoSalesDetails(model.lastSellItem,
                            isOffline: true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(26.0),
                        margin:
                            const EdgeInsets.fromLTRB(26.0, 26.0, 26.0, 0.0),
                        width: 100.0.wp,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors.pasteColor,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: model.saleMessageShow,
                              style: AppTextStyles.salesAddedMessageTestStyle,
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .viewSalesDetail,
                                  style: AppTextStyles
                                      .salesAddedMessageTestStyle
                                      .copyWith(
                                    fontWeight: AppFontWeighs.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            model.readQrScanner(context);
                          },
                          child: Text(
                            model.enrollment == UserTypeForWeb.retailer
                                ? AppLocalizations.of(context)!
                                    .headerScannerDialog
                                : AppLocalizations.of(context)!
                                    .preSaleDialogHead,
                            style: AppTextStyles.underlineText,
                          ),
                        ),
                        SortCardDesing(
                            height: 60.0,
                            items: [
                              AppLocalizations.of(context)!.status,
                              AppLocalizations.of(context)!.date
                            ]
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    onTap: () {
                                      model.sortList(e);
                                    },
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            sortedItem: model.sortedItem),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: Utils.pullScrollPhysic,
                      child: Column(
                        children: [
                          if (model.allOfflineSalesData.length +
                                  model.allSortedSalesData.length <
                              1)
                            Utils.noDataWidget(context),
                          // Text(AppLocalizations.of(context)!.noSaleMessage),
                          for (int i = 0;
                              i < model.allOfflineSalesData.length;
                              i++)
                            GestureDetector(
                              onTap: () {
                                model.gotoSalesDetails(
                                    model.allOfflineSalesData[i],
                                    isOffline: true);
                              },
                              child: StatusCardFourPart(
                                // status: 0,

                                title: model.allOfflineSalesData[i]
                                            .invoiceNumber!.isEmpty ||
                                        model.allOfflineSalesData[i]
                                                .invoiceNumber ==
                                            "-"
                                    ? model.allOfflineSalesData[i].orderNumber!
                                    : model
                                        .allOfflineSalesData[i].invoiceNumber!,
                                price:
                                    "${model.allOfflineSalesData[i].currency!} "
                                    "${model.allOfflineSalesData[i].amount!}",
                                subTitle:
                                    model.enrollment == UserTypeForWeb.retailer
                                        ? model.allOfflineSalesData[i].saleDate!
                                        : model.allOfflineSalesData[i]
                                            .retailerName!,
                                bodyFirstKey: model.enrollment ==
                                        UserTypeForWeb.retailer
                                    ? '${AppLocalizations.of(context)!.orderID} ${model.allOfflineSalesData[i].orderNumber!}'
                                    : '${AppLocalizations.of(context)!.saleDate}: ${model.allOfflineSalesData[i].saleDate!}',
                                bodyFirstValue: model.enrollment ==
                                        UserTypeForWeb.retailer
                                    ? '${AppLocalizations.of(context)!.invoiceTo}: ${model.allOfflineSalesData[i].wholesalerName}'
                                    : '${AppLocalizations.of(context)!.dueDate}: ${model.allOfflineSalesData[i].dueDate}',
                                // bodyFirstValue: "",
                                bodySecondKey:
                                    '${AppLocalizations.of(context)!.fiaName}: '
                                    '${model.allOfflineSalesData[i].fieName!}',
                                statusChild: model
                                    .allOfflineSalesData[i].status!
                                    .toSaleStatus(
                                        text: StatusFile.statusForSale(
                                            model.language,
                                            model
                                                .allOfflineSalesData[i].status!,
                                            model.allOfflineSalesData[i]
                                                .statusDescription!)),
                              ),
                            ),
                          if (model.allSortedSalesData.isNotEmpty)
                            for (int i = 0;
                                i < model.allSortedSalesData.length;
                                i++)
                              GestureDetector(
                                onTap: () {
                                  model.gotoSalesDetails(
                                      model.allSortedSalesData[i],
                                      isOffline: false);
                                },
                                child: StatusCardFourPart(
                                  firstBoxWidth: 150,
                                  // status: 0,
                                  title: model.allSortedSalesData[i]
                                              .invoiceNumber!.isEmpty ||
                                          model.allSortedSalesData[i]
                                                  .invoiceNumber ==
                                              "-"
                                      ? model.allSortedSalesData[i].orderNumber!
                                      : model
                                          .allSortedSalesData[i].invoiceNumber!,
                                  price:
                                      "${model.allSortedSalesData[i].currency!} ${model.allSortedSalesData[i].amount!}",
                                  subTitle: model.enrollment ==
                                          UserTypeForWeb.retailer
                                      ? model.allSortedSalesData[i].saleDate!
                                      : model
                                          .allSortedSalesData[i].retailerName!,
                                  bodyFirstKey: model.enrollment ==
                                          UserTypeForWeb.retailer
                                      ? '${AppLocalizations.of(context)!.orderID} ${model.allSortedSalesData[i].orderNumber!}'
                                      : '${AppLocalizations.of(context)!.saleDate}: ${model.allSortedSalesData[i].saleDate!}',
                                  bodyFirstValue: model.enrollment ==
                                          UserTypeForWeb.retailer
                                      ? '${AppLocalizations.of(context)!.invoiceTo}: ${model.allSortedSalesData[i].wholesalerName!}'
                                      : '${AppLocalizations.of(context)!.dueDate}: ${model.allSortedSalesData[i].dueDate!}',
                                  bodySecondKey:
                                      '${AppLocalizations.of(context)!.fiaName}: '
                                      '${model.allSortedSalesData[i].fieName!}',
                                  bodySecondValue: model.enrollment ==
                                          UserTypeForWeb.retailer
                                      ? "${AppLocalizations.of(context)!.sNo}: ${i + 1}"
                                      : "",
                                  statusChild: model
                                      .allSortedSalesData[i].status!
                                      .toSaleStatus(
                                          text: StatusFile.statusForSale(
                                              model.language,
                                              model.allSortedSalesData[i]
                                                  .status!,
                                              model.allSortedSalesData[i]
                                                  .statusDescription!)),
                                ),
                              ),

                          // if (model.allOrder.isNotEmpty)
                          model.isButtonBusy
                              ? SizedBox(
                                  height: 50.0,
                                  child: Utils.loaderBusy(),
                                )
                              : model.isLoadMoreAvailable
                                  ? Utils.loadMore(model.salesLoadMore)
                                  : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
