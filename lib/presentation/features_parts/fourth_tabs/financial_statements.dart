part of '../../ui/fourth_tab/fourth_tab_view.dart';

class FinancialStatements extends StatelessWidget {
  const FinancialStatements(this.model, {Key? key}) : super(key: key);
  final FourthTabViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.noInternet
        ? const ConnectionWidget()
        : model.busy(model.rFinStatdata)
            ? SizedBox(
                width: 100.0.wp,
                height: 100.0.hp,
                child: const Center(
                  child: LoaderWidget(),
                ),
              )
            : model.busy(model.retailerSaleFinancialStatementsList)
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: AppColors.whiteColor,
                    color: AppColors.appBarColorRetailer,
                    onRefresh: () async {
                      model.getFinancialStatement(model.date);
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 100.0.hp,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                            padding: EdgeInsets.only(
                                bottom: model.startPaymentList.isNotEmpty
                                    ? 40.0
                                    : 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                model.connectivityWidget,
                                // header(context),

                                Expanded(
                                  child: GroupedListView<SubgroupsWithData,
                                      String>(
                                    elements: model.selectedStrategySubgroups,
                                    groupBy: (element) =>
                                        (element.subgroupData!.isNotEmpty
                                            ? element.groupName!
                                            : ""),
                                    sort: false,
                                    order: GroupedListOrder.DESC,
                                    groupHeaderBuilder: (SubgroupsWithData v) {
                                      return v.subgroupData!.isNotEmpty
                                          ? SizedBox(
                                              height: 60,
                                              child: ShadowCard(
                                                child: Center(
                                                  child: Text(
                                                    v.groupName!,
                                                    style: AppTextStyles
                                                        .successStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    },
                                    groupStickyHeaderBuilder:
                                        (SubgroupsWithData v) => Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black54,
                                              blurRadius: 2.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(0.0, 1))
                                        ],
                                      ),
                                      height: 90,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          header(context),
                                          Text(
                                            v.groupName!,
                                            style: AppTextStyles.successStyle
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    footer: model.rFinStatLoadMoreButton
                                        ? SizedBox(
                                            height: 60.0,
                                            child: model.isLoaderBusy
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12.0),
                                                    child: Utils.loaderBusy(),
                                                  )
                                                : Center(
                                                    child: Utils.loadMore(model
                                                        .loadMoreFinancialStatement),
                                                  ),
                                          )
                                        : const SizedBox(),
                                    itemBuilder:
                                        (context, SubgroupsWithData element) =>
                                            Column(
                                      children: [
                                        for (SubgroupData v
                                            in element.subgroupData!)
                                          documentCard(context, v, () {
                                            model.addForStartPayment(v);
                                          }, model.startPaymentList),
                                      ],
                                    ),
                                    // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                                    useStickyGroupSeparators: true, // optional
                                    floatingHeader: true, // optional
                                    // shrinkWrap: false, // optional
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // if (model.startPaymentList.isNotEmpty)
                        AnimatedPositioned(
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                          bottom: model.startPaymentList.isNotEmpty ? 0 : -40,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColors.whiteColor),
                            width: 100.0.wp,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 4.0, 12.0, 0.0),
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: model.busy(model.startPaymentList)
                                    ? Center(
                                        child: Utils.loaderBusy(),
                                      )
                                    : SubmitButton(
                                        isRadius: false,
                                        onPressed: () {
                                          if (model
                                              .startPaymentList.isNotEmpty) {
                                            model.createPayment(context);
                                          }
                                        },
                                        text: AppLocalizations.of(context)!
                                            .startPayment,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }

  Widget documentCard(BuildContext context, SubgroupData data,
      Function()? checkSelection, List<SubgroupData> startPaymentList) {
    var existingItem = startPaymentList
        .any((itemToCheck) => itemToCheck.documentId == data.documentId);
    return GestureDetector(
      onTap: () {
        model.gotoStatementSalesDetails(
            data.saleUniqueId ?? "", data.invoice ?? "");
      },
      child: ShadowCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: AutoSizeText(
                    data.wholesalerName!,
                    // maxLines: 2,
                    style: AppTextStyles.statusCardTitle,
                  ),
                ),
                Expanded(
                  child: data.status!.toStatusFinStat(
                      value: StatusFile.statusForFinState(model.language,
                          data.status!, data.statusDescription!)),
                ),
              ],
            ),
            Text(
              "${AppLocalizations.of(context)!.invoiceNumber}: ${data.invoice}",
              maxLines: 2,
              style: AppTextStyles.statusCardSubTitle,
            ),
            8.0.giveHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.storeName}:",
                  style: AppTextStyles.dashboardHeadTitleAsh,
                ),
                Text(
                  data.storeName!,
                  style: AppTextStyles.dashboardHeadTitleAsh
                      .copyWith(fontWeight: AppFontWeighs.regular),
                )
              ],
            ),
            4.0.giveHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.totalDocuments}:",
                  style: AppTextStyles.dashboardHeadTitleAsh,
                ),
                Text(
                  data.otherDocumentsCount!.toString(),
                  style: AppTextStyles.dashboardHeadTitleAsh
                      .copyWith(fontWeight: AppFontWeighs.regular),
                )
              ],
            ),
            4.0.giveHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.totalAmount}:",
                  style: AppTextStyles.dashboardHeadTitleAsh,
                ),
                Text(
                  "${data.currency} ${data.invoiceAmount}",
                  style: AppTextStyles.dashboardHeadTitleAsh
                      .copyWith(fontWeight: AppFontWeighs.regular),
                )
              ],
            ),
            if (data.canStartPayment!) 10.0.giveHeight,
            if (data.canStartPayment!)
              Row(
                children: [
                  InkWell(
                    onTap: checkSelection,
                    child: Center(
                      child: CheckedBox(
                        check: existingItem,
                      ),
                    ),
                  ),
                  const Text(
                    "Select this sale if you want to pay",
                    style: AppTextStyles.successStyle,
                  )
                ],
              )
          ],
        ),
      ),
    );
  }

  Widget header(context) {
    if (model.selectedStrategySubgroups.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: const BoxDecoration(
          color: AppColors.cardColor,
        ),
        child: Column(
          children: [
            Utils.commonText(
              '${AppLocalizations.of(context)!.grandTotal} '
              '${model.grandTotalFinancialStatements}',
              needPadding: false,
              style: AppTextStyles.statusCardTitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "By Weeks",
                  style: AppTextStyles.successStyle
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: model.isDay,
                    onChanged: (value) {
                      model.changeWeekOrDay(value, '1', context);
                    },
                  ),
                ),
                Text(
                  "By Days",
                  style: AppTextStyles.successStyle
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }

// Widget saleCard(
//     BuildContext context, FinancialStatementsData data, int i, bool bool) {
//   return ShadowCard(
//     child: ExpandablePanel(
//       onTap: () {
//         model.changeStatementCardNumber(i);
//       },
//       // controller: model.expansionTileController,
//       expanded: Column(
//         children: [
//           const Divider(
//                             color: AppColors.dividerColor,),
//           for (int j = 0; j < data.documents!.length; j++)
//             statementCard(context, data.documents![j], j),
//         ],
//       ),
//
//       collapsed: const SizedBox(),
//       isTrue: model.statementCardNumber == i,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 200,
//                 child: AutoSizeText(
//                   data.wholesalerName!,
//                   // maxLines: 2,
//                   style: AppTextStyles.statusCardTitle,
//                 ),
//               ),
//               data.status!.toStatusFinStat(
//                   value: StatusFile.statusForFinState(
//                       model.language, data.status!, data.statusDescription!)),
//             ],
//           ),
//           Text(
//             "${AppLocalizations.of(context)!.invoiceNumber}: ${data.invoice}",
//             maxLines: 2,
//             style: AppTextStyles.statusCardSubTitle,
//           ),
//           8.0.giveHeight,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "${AppLocalizations.of(context)!.storeName}:",
//                 style: AppTextStyles.dashboardHeadTitleAsh,
//               ),
//               Text(
//                 data.storeName!,
//                 style: AppTextStyles.dashboardHeadTitleAsh
//                     .copyWith(fontWeight: AppFontWeighs.regular),
//               )
//             ],
//           ),
//           4.0.giveHeight,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "${AppLocalizations.of(context)!.totalDocuments}:",
//                 style: AppTextStyles.dashboardHeadTitleAsh,
//               ),
//               Text(
//                 data.documents!.length.toString(),
//                 style: AppTextStyles.dashboardHeadTitleAsh
//                     .copyWith(fontWeight: AppFontWeighs.regular),
//               )
//             ],
//           ),
//           4.0.giveHeight,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "${AppLocalizations.of(context)!.totalAmount}:",
//                 style: AppTextStyles.dashboardHeadTitleAsh,
//               ),
//               Text(
//                 "${data.currency} ${data.amount}",
//                 style: AppTextStyles.dashboardHeadTitleAsh
//                     .copyWith(fontWeight: AppFontWeighs.regular),
//               )
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// ShadowCard statementCard(
//   BuildContext context,
//   Documents data,
//   int i,
// ) {
//   return ShadowCard(
//     isChild: true,
//     padding: 0.1,
//     child: SizedBox(
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.documentType}${data.documentType}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.contractAccount}${model.contractAccount(data.contractAccount!)}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.dueDate}:${data.dueDate}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.invoice}${data.invoice}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.amounT}${data.amount}",
//                     nxtln: true),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.documentId} "
//                     "${data.documentId!.lastChars(10)}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.dateGenerated}${data.dateGenerated}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(AppLocalizations.of(context)!.statuS),
//                 data.status!.toStatusFinStat(
//                     value: StatusFile.statusForFinState(model.language,
//                         data.status!, data.statusDescription!)),
//                 //toStatusFinStat()
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.currencY}${data.currency}",
//                     nxtln: true),
//                 10.0.giveHeight,
//                 Utils.getNiceText(
//                     "${AppLocalizations.of(context)!.openBalance}${data.openBalance}",
//                     nxtln: true),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
