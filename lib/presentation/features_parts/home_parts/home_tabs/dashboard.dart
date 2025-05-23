part of '../../../ui/home_screen/home_screen_view.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key, required this.model, required this.isRetailer})
      : super(key: key);
  final HomeScreenViewModel model;
  final bool isRetailer;

  @override
  Widget build(BuildContext context) {
    return isRetailer
        ? SizedBox(
            width: 100.0.wp,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.0.giveHeight,
                  Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    runSpacing: OtherSizes.runSpacing,
                    spacing: OtherSizes.spacing,
                    children: [
                      for (var i = 0;
                          i < model.retailerCardsPropertiesList.length;
                          i++)
                        DashboardTilesCard(
                          color: model.retailerCardsPropertiesList[i].color!,
                          icon: model.retailerCardsPropertiesList[i].icon!,
                          amount: model.retailerCardsPropertiesList[i].amount!,
                          title: model.retailerCardsPropertiesList[i].title!,
                        ),
                    ],
                  ),
                  10.0.giveHeight,
                  SizedBox(
                    width: 100.0.wp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (model.isUserHaveAccess(
                            UserRolesFiles.pendingSaleOnDashBoard))
                          ShadowCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100.0.wp,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .dashboardConfirmText,
                                      style: AppTextStyles.dashboardHeadTitle
                                          .copyWith(
                                        fontWeight: AppFontWeighs.semiBold,
                                      ),
                                    ),
                                  ),
                                ),
                                model.busy(model.pendingSaleData)
                                    ? SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: Utils.loaderBusy(),
                                        ),
                                      )
                                    : model.pendingSaleData.isEmpty
                                        ? Utils.noDataWidget(context,
                                            height: 100)
                                        : Column(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      model.pendingSaleData
                                                          .length;
                                                  i++)
                                                InkWell(
                                                  onTap: () {
                                                    model.gotoSalesDetails(model
                                                        .pendingSaleData[i]);
                                                  },
                                                  // onTap: function,
                                                  child: Container(
                                                    margin: AppMargins
                                                        .retailerConfirmationMarginV,
                                                    padding: AppPaddings
                                                        .retailerConfirmationPadding,
                                                    decoration: BoxDecoration(
                                                      borderRadius: AppRadius
                                                          .retailerConfirmationRadius,
                                                      border: Border.all(
                                                        color: AppColors
                                                            .borderColors,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                model
                                                                            .pendingSaleData[
                                                                                i]
                                                                            .invoiceNumber!
                                                                            .isEmpty ||
                                                                        model.pendingSaleData[i].invoiceNumber ==
                                                                            "-"
                                                                    ? model
                                                                        .pendingSaleData[
                                                                            i]
                                                                        .orderNumber!
                                                                    : model
                                                                        .pendingSaleData[
                                                                            i]
                                                                        .invoiceNumber!,
                                                                style: AppTextStyles
                                                                    .statusCardTitle,
                                                              ),
                                                            ),
                                                            AutoSizeText(
                                                              "${model.pendingSaleData[i].currency} "
                                                              "${model.pendingSaleData[i].amount}",
                                                              maxLines: 1,
                                                              style: AppTextStyles
                                                                  .statusCardTitle,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  model.enrollment ==
                                                                          UserTypeForWeb
                                                                              .retailer
                                                                      ? model
                                                                          .pendingSaleData[
                                                                              i]
                                                                          .saleDate!
                                                                      : model
                                                                          .pendingSaleData[
                                                                              i]
                                                                          .retailerName!,
                                                                  style: AppTextStyles
                                                                      .dashboardBodyTitle,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ClassifiedText(
                                                                    text1:
                                                                        "${AppLocalizations.of(context)!.orderID}\n",
                                                                    text2:
                                                                        '${model.pendingSaleData[i].orderNumber}'),
                                                                ClassifiedText(
                                                                    text1:
                                                                        "${AppLocalizations.of(context)!.invoiceTo}:\n",
                                                                    text2:
                                                                        '${model.pendingSaleData[i].invoiceNumber}'),
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                FittedBox(
                                                                  // width: 100.0,
                                                                  child: model
                                                                      .pendingSaleData[
                                                                          i]
                                                                      .status!
                                                                      .toSaleStatus(
                                                                    text: model
                                                                        .statusForConfirmationBoard(
                                                                            i),
                                                                  ),
                                                                ),
                                                                10.0.giveHeight,
                                                                ClassifiedText(
                                                                    text1:
                                                                        "${AppLocalizations.of(context)!.fiaName}:\n",
                                                                    text2:
                                                                        '${model.pendingSaleData[i].fieName}'),
                                                                ClassifiedText(
                                                                    text1: AppLocalizations.of(
                                                                            context)!
                                                                        .sr,
                                                                    text2:
                                                                        '${i + 1}'),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                              ],
                            ),
                          ),
                        if (model.isUserHaveAccess(
                            UserRolesFiles.pendingSaleOnDashBoard))
                          10.0.giveHeight,
                        ShadowCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .dashboardRecommendation,
                                style:
                                    AppTextStyles.dashboardHeadTitle.copyWith(
                                  fontWeight: AppFontWeighs.semiBold,
                                ),
                              ),
                              if (model.connection)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  decoration: AppBoxDecoration
                                      .dashboardCardDecoration
                                      .copyWith(
                                    borderRadius: AppRadius.s50Padding,
                                  ),
                                  width: 100.0.wp,
                                  height: 33.0,
                                  child: SizedBox(
                                    width: 100.0.wp,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<DateFilterModel>(
                                        dropdownColor: AppColors.whiteColor,
                                        isDense: false,
                                        style:
                                            AppTextStyles.dashboardHeadTitleAsh,
                                        value: model.selectedDateFilter,
                                        items: [
                                          for (DateFilterModel item
                                              in model.dateFilters)
                                            DropdownMenuItem<DateFilterModel>(
                                              // onTap:
                                              //     model.getDepositRecommendation,
                                              value: item,
                                              child: Text(item.title!),
                                            )
                                        ],
                                        onChanged: (DateFilterModel? value) {
                                          model.changeFilterDate(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              model.connectivityWidget,
                              if (model.depositRecommendationData.isEmpty)
                                Utils.noDataWidget(context, height: 60),
                              // if (model
                              //     .getDepositRecommendationError.isNotEmpty)
                              //   Center(
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           vertical: 8.0),
                              //       child: Text(
                              //           model.getDepositRecommendationError),
                              //     ),
                              //   ),
                              if (model.connection)
                                if (model.isDepositRecommendationBusy)
                                  SizedBox(
                                    height: 200.0,
                                    width: 100.0.wp,
                                    child: Utils.loaderBusy(),
                                  ),
                              if (model.connection)
                                if (!model.isDepositRecommendationBusy)
                                  for (int i = 0;
                                      i <
                                          model
                                              .depositRecommendationData.length;
                                      i++)
                                    retailerDepositRecommendation(
                                        model.depositRecommendationData[i],
                                        i + 1,
                                        context)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            width: 100.0.wp,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.0.giveHeight,
                  Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    runSpacing: OtherSizes.runSpacing,
                    spacing: OtherSizes.spacing,
                    children: [
                      for (var i = 0;
                          i < model.wholesalerCardsPropertiesList.length;
                          i++)
                        DashboardTilesCard(
                          color: model.wholesalerCardsPropertiesList[i].color!,
                          icon: model.wholesalerCardsPropertiesList[i].icon!,
                          amount:
                              model.wholesalerCardsPropertiesList[i].amount!,
                          title: model.wholesalerCardsPropertiesList[i].title!,
                        ),
                    ],
                  ),
                  Padding(
                    padding: AppPaddings.dashboardOtherCardPadding,
                    child: Card(
                      child: Container(
                        width: 100.0.wp,
                        padding: AppPaddings.dashboardOtherCardPadding,
                        decoration: AppBoxDecoration.dashboardCardDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.invoices,
                              style: AppTextStyles.dashboardHeadTitle.copyWith(
                                fontWeight: AppFontWeighs.semiBold,
                              ),
                            ),
                            16.0.giveHeight,
                            for (int i = 0;
                                i <
                                    (model.invoiceData.length < 4
                                        ? model.invoiceData.length
                                        : 4);
                                i++)
                              WholesalerInvoicePartInDashboard(
                                  model.invoiceData[i]),
                            20.0.giveHeight,
                            Text(
                              AppLocalizations.of(context)!.newOrderRequest,
                              style: AppTextStyles.dashboardHeadTitle.copyWith(
                                fontWeight: AppFontWeighs.semiBold,
                              ),
                            ),
                            16.0.giveHeight,
                            for (int i = 0; i < 4; i++)
                              const WholesalerNewOrderPartInDashboard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget retailerDepositRecommendation(
      DepositRecommendationData recommadationData, int sNo, context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: AppPaddings.borderCardPadding,
      decoration: BoxDecoration(
        borderRadius: AppRadius.retailerRecommandationCardRadius,
        border: Border.all(
          color: AppColors.borderColors,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClassifiedText(
                      text1: "${AppLocalizations.of(context)!.fiaName}:\n",
                      text2: "${recommadationData.fieName}"),
                  ClassifiedText(
                      text1: "${AppLocalizations.of(context)!.balance}:\n",
                      text2:
                          "${recommadationData.currency} ${recommadationData.balance}"),
                ],
              ),
              10.0.giveWidth,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 34.0.wp,
                    child: RichText(
                      // maxLines: 3,
                      text: TextSpan(
                        text: '${AppLocalizations.of(context)!.caNumber}\n',
                        style: AppTextStyles.dashboardHeadTitleAsh,
                        children: <TextSpan>[
                          TextSpan(
                            text: "${recommadationData.bankAccountNumber}",
                            style: AppTextStyles.dashboardHeadTitleAsh
                                .copyWith(fontWeight: AppFontWeighs.semiBold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClassifiedText(
                      text1: AppLocalizations.of(context)!.sr, text2: "$sNo"),
                ],
              ),
            ],
          ),
          ClassifiedText(
              text1: "${AppLocalizations.of(context)!.expireDateSale} \n",
              text2: "${recommadationData.currency} "
                  "${recommadationData.dueSaleAmount}"),
          ClassifiedText(
              text1:
                  "${AppLocalizations.of(context)!.depositRecommendation}: \n",
              text2: "${recommadationData.currency} "
                  "${recommadationData.depositeRecAmt}"),
        ],
      ),
    );
  }
}
