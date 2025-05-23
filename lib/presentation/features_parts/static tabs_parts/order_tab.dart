part of '../../ui/static_screen/static_screen_view.dart';

class OrderTab extends StatelessWidget {
  OrderTab(this.model, {Key? key}) : super(key: key);
  StaticViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.isBusy
        ? Utils.loaderBusy()
        : model.isCustomerTabBusy
            ? const LoaderWidget()
            : RefreshIndicator(
                backgroundColor: AppColors.whiteColor,
                color: AppColors.loader1,
                displacement: 40.0.hp,
                onRefresh: model.refreshOrder,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 100.0.hp,
                      width: 100.0.wp,
                      child: SingleChildScrollView(
                        physics: Utils.pullScrollPhysic,
                        child: Column(
                          children: [
                            SortCardDesing(
                                items: [
                                  AppLocalizations.of(context)!.status,
                                  AppLocalizations.of(context)!.date
                                ]
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        onTap: () {
                                          model.orderSortList(e);
                                        },
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                sortedItem: model.orderSortedItem),
                            for (int i = 0; i < model.allOrder.length; i++)
                              GestureDetector(
                                onTap: () {
                                  model.gotoOrderDetailsScreen(
                                      model.allOrder[i].uniqueId!,
                                      model.allOrder[i].orderType!,
                                      model.allOrder[i].wholesalerUniqueId!,
                                      model.allOrder[i].storeUniqueId!,
                                      context);
                                },
                                child: ShadowCard(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: AutoSizeText(
                                              model.allOrder[i].storeName!,
                                              maxLines: 2,
                                              style:
                                                  AppTextStyles.statusCardTitle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.0.wp - 264,
                                            child: AutoSizeText(
                                              "${model.allOrder[i].currency} ${model.allOrder[i].grandTotal!}",
                                              group: model.priceGroup,
                                              maxLines: 2,
                                              textAlign: TextAlign.right,
                                              style:
                                                  AppTextStyles.priceTextStyle,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            model
                                                .allOrder[i].dateOfTransaction!,
                                            maxLines: 2,
                                            style: AppTextStyles
                                                .statusCardSubTitle,
                                          ),
                                          model.allOrder[i].status!
                                              .toOrderStatus(
                                            text: StatusFile.statusForOrder(
                                                model.language,
                                                model.allOrder[i].status!,
                                                model.allOrder[i]
                                                    .statusDescription!),
                                          ),
                                        ],
                                      ),
                                      4.0.giveHeight,
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.wholesalerCamelkCase}: ${model.allOrder[i].wholesalerName!}"),
                                      Utils.getNiceText(
                                          "${AppLocalizations.of(context)!.orderType}: ${model.getOrderType(model.allOrder[i].orderType!)}")
                                    ],
                                  ),
                                ),
                              ),
                            if (model.allOrder.isEmpty &&
                                model.enrollment == UserTypeForWeb.retailer)
                              Utils.noDataWidget(context),
                            if (model.enrollment == UserTypeForWeb.wholesaler)
                              SizedBox(
                                height: 60.0.hp,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.moduleNotDone,
                                    style: AppTextStyles.dashboardHeadTitleAsh,
                                  ),
                                ),
                              ),
                            if (model.allOrder.isNotEmpty)
                              model.isButtonBusy
                                  ? SizedBox(
                                      height: 50.0,
                                      child: Utils.loaderBusy(),
                                    )
                                  : model.orderLoadMoreButton
                                      ? Utils.loadMore(model.loadMoreOrder)
                                      : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    if (model.isWaiting)
                      Container(
                        child: Utils.loaderBusy(),
                        color: AppColors.bodyBusyColor,
                        height: 100.0.hp,
                        width: 100.0.wp,
                      )
                  ],
                ),
              );
  }
}
