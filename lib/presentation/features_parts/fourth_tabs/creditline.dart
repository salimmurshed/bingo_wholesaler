part of '../../ui/fourth_tab/fourth_tab_view.dart';

class Creditlines extends StatelessWidget {
  const Creditlines(this.model, {Key? key}) : super(key: key);
  final FourthTabViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.noInternet
        ? const ConnectionWidget()
        : model.busy(model.approveCreditlineRequestData)
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
                onRefresh: model.pullToRefreshCreditline,
                child: SizedBox(
                  height: 100.0.hp,
                  child: SingleChildScrollView(
                    physics: Utils.pullScrollPhysic,
                    child: Padding(
                      padding: AppPaddings.bodyTop,
                      child: Column(
                        children: [
                          model.connectivityWidget,
                          if (model.approveCreditlineRequestData.isNotEmpty)
                            SortCardDesing(
                              height: 50.0,
                              items: [
                                AppLocalizations.of(context)!.status,
                                AppLocalizations.of(context)!.date
                              ]
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      onTap: () {
                                        model.creditlineSortList(e);
                                      },
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              sortedItem: model.creditlinesSortedItem,
                            ),
                          Column(
                            children: [
                              for (int i = 0;
                                  i < model.approveCreditlineRequestData.length;
                                  i++)
                                InkWell(
                                  onTap: () {
                                    model.gotoCreditlineDetails(i);
                                  },
                                  child: ShadowCard(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(model
                                                .approveCreditlineRequestData[i]
                                                .internalId!),
                                            Flexible(
                                              // width: 120.0,
                                              child: statusNamesEnumFromServer(model
                                                      .approveCreditlineRequestData[
                                                          i]
                                                      .statusDescription!)
                                                  .toStatus(),
                                            ),
                                          ],
                                        ),
                                        10.0.giveHeight,
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 60.0.wp - 50.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.wholesalerCamelkCase.toUpperCamelCase()}:${model.approveCreditlineRequestData[i].wholesalerName}",
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.currentBalance}${model.approveCreditlineRequestData[i].currency} ${model.approveCreditlineRequestData[i].currentBalance}",
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.expirationDate}${model.approveCreditlineRequestData[i].expirationDate}",
                                                      nxtln: true),
                                                ],
                                              ),
                                            ),
                                            10.0.giveHeight,
                                            SizedBox(
                                              width: 40.0.wp - 50.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.fiaName}:${model.approveCreditlineRequestData[i].fieName}",
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.appamount}${model.approveCreditlineRequestData[i].currency} ${model.approveCreditlineRequestData[i].approvedAmount}",
                                                      nxtln: true),
                                                  10.0.giveHeight,
                                                  Utils.getNiceText(
                                                      "${AppLocalizations.of(context)!.amountBalance}${model.approveCreditlineRequestData[i].currency} ${model.approveCreditlineRequestData[i].amountAvailable}",
                                                      nxtln: true),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        15.0.giveHeight,
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: LinearProgressIndicator(
                                            minHeight: 10.0,
                                            backgroundColor:
                                                const Color(0xffEBEBEB),
                                            color: const Color(0xff5DC151),
                                            value:
                                                model.progressBarCreditLine(i),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (model.approveCreditlineRequestData.isEmpty)
                            Utils.noDataWidget(context)
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}
