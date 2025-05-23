part of '../../ui/static_screen/static_screen_view.dart';

class FieTabs extends StatelessWidget {
  StaticViewModel model;

  FieTabs(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.isCustomerTabBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.refreshFie,
            child: SizedBox(
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
                                  model.wholesalerSortList(e);
                                },
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        sortedItem: model.fieSortedItem),
                    for (int i = 0;
                        i < model.retailerAssociationFie.length;
                        i++)
                      GestureDetector(
                        onTap: () {
                          model.gotoFieDetails(
                              model.retailerAssociationFie[i], context, false);
                        },
                        child: StatusCardFourPart(
                          firstBoxWidth: 280,
                          // status: 0,
                          title: model.retailerAssociationFie[i].fieName!,

                          subTitle: model.retailerAssociationFie[i].taxId!,
                          bodyFirstValue:
                              "${AppLocalizations.of(context)!.email}: ${model.retailerAssociationFie[i].bpEmail!}",

                          bodyFirstKey:
                              "${AppLocalizations.of(context)!.phoneNo}: ${model.retailerAssociationFie[i].phoneNumber!}",
                          statusChild: activeInactiveStatusWidget(
                              text: StatusFile.statusForWholesaler(
                                  model.language,
                                  model.retailerAssociationFie[i].status!),
                              color: StatusFile.statusForWholesaler(
                                                  model.language,
                                                  model
                                                      .retailerAssociationFie[i]
                                                      .status!)
                                              .toLowerCase() ==
                                          "active" ||
                                      StatusFile.statusForWholesaler(
                                                  model.language,
                                                  model
                                                      .retailerAssociationFie[i]
                                                      .status!)
                                              .toLowerCase() ==
                                          'activa'
                                  ? AppColors.statusVerified
                                  : AppColors.statusReject,
                              isIconAvailable: true),
                        ),
                      ),
                    if (model.retailerAssociationFie.isEmpty)
                      Utils.noDataWidget(context),
                    // if (model.retailerAssociationFie.isNotEmpty)
                    //   model.isButtonBusy
                    //       ? SizedBox(
                    //           height: 50.0,
                    //           child: Utils.loaderBusy(),
                    //         )
                    //       : model.isWholesalerLoadMoreButtonAvailable
                    //           ? Utils.loadMore(model.loadMoreFie)
                    //           : Utils.endOfData(),
                  ],
                ),
              ),
            ),
          );
  }
}
