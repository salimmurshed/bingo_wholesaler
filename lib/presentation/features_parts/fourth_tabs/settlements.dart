part of '../../ui/fourth_tab/fourth_tab_view.dart';

class Settlements extends StatelessWidget {
  const Settlements(this.model, {Key? key}) : super(key: key);
  final FourthTabViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.busy(model.settlementList)
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
            onRefresh: model.getRetailerSettlementList,
            child: SizedBox(
              height: 100.0.hp,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Padding(
                  padding: AppPaddings.bodyTop,
                  child: Column(
                    children: [
                      model.connectivityWidget,
                      if (model.settlementList.isNotEmpty)
                        SortCardDesing(
                          height: 50.0,
                          items: [
                            AppLocalizations.of(context)!.status,
                            AppLocalizations.of(context)!.date
                          ]
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  onTap: () {
                                    model.settlementsSortList(e);
                                  },
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          sortedItem: model.settlementsSortedItem,
                        ),
                      Column(
                        children: [
                          for (int i = 0; i < model.settlementList.length; i++)
                            InkWell(
                              onTap: () {
                                model.gotoSettlementsDetails(
                                    model.settlementList[i].lotId!, context);
                              },
                              child: ShadowCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          model.settlementList[i].lotId!
                                              .lastChars(10),
                                          style: AppTextStyles.statusCardTitle,
                                        ),
                                        Text(
                                          "${model.settlementList[i].currency} ${model.settlementList[i].amount}",
                                          style: AppTextStyles.statusCardTitle
                                              .copyWith(
                                                  fontWeight:
                                                      AppFontWeighs.regular),
                                        ),
                                      ],
                                    ),
                                    10.0.giveHeight,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${model.settlementList[i].postingDate}",
                                          style:
                                              AppTextStyles.statusCardSubTitle,
                                        ),
                                        model.settlementList[i].status!
                                            .toStatusSettleMent(
                                                value: StatusFile
                                                    .statusForSettlement(
                                                        model.language,
                                                        model.settlementList[i]
                                                            .status!,
                                                        model.settlementList[i]
                                                            .statusDescription!)),
                                      ],
                                    ),
                                    20.0.giveHeight,
                                    Text(
                                      "${AppLocalizations.of(context)!.settNo} ${i + 1}",
                                      style: AppTextStyles.statusCardSubTitle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          //settlementPageAvailable
                          if (model.settlementPageAvailable)
                            model.isLoaderBusy
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    child: Utils.loaderBusy(),
                                  )
                                : Utils.loadMore(
                                    model.loadMoreRetailerSettlementList),
                          if (model.settlementList.isEmpty)
                            Utils.noDataWidget(context)
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
