part of '../../ui/static_screen/static_screen_view.dart';

class WholesalerTabs extends StatelessWidget {
  StaticViewModel model;

  WholesalerTabs(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.isCustomerTabBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.refreshWholesaler,
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
                        sortedItem: model.wholesalerSortedItem),
                    for (int i = 0; i < model.wholesaler.length; i++)
                      InkWell(
                        onTap: () {
                          model.gotoWholesalerDetails(
                              model.wholesaler[i], context, true);
                        },
                        child: ShadowCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    // width: 100,
                                    child: AutoSizeText(
                                      model.wholesaler[i].wholesalerName!,
                                      // maxLines: 2,
                                      style: AppTextStyles.statusCardTitle,
                                    ),
                                  ),
                                  activeInactiveStatusWidget(
                                    text: StatusFile.statusForWholesaler(
                                        model.language,
                                        model.wholesaler[i].status!),
                                    color: StatusFile.statusForWholesaler(
                                                        model.language,
                                                        model.wholesaler[i]
                                                            .status!)
                                                    .toLowerCase() ==
                                                "active" ||
                                            StatusFile.statusForWholesaler(
                                                        model.language,
                                                        model.wholesaler[i]
                                                            .status!)
                                                    .toLowerCase() ==
                                                'activa'
                                        ? AppColors.statusVerified
                                        : AppColors.statusReject,
                                    isIconAvailable: true,
                                  )
                                ],
                              ),
                              Text(
                                model.wholesaler[i].taxId!,
                                maxLines: 2,
                                style: AppTextStyles.statusCardSubTitle,
                              ),
                              8.0.giveHeight,
                              Utils.getNiceText(
                                  "${AppLocalizations.of(context)!.phoneNo}: ${model.wholesaler[i].phoneNumber!}"),
                              Utils.getNiceText(
                                  "${AppLocalizations.of(context)!.email}: ${model.wholesaler[i].bpEmail!}")
                            ],
                          ),
                        ),
                      ),
                    if (model.wholesaler.isEmpty) Utils.noDataWidget(context),
                  ],
                ),
              ),
            ),
          );
  }
}
