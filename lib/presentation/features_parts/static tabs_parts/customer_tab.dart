part of '../../ui/static_screen/static_screen_view.dart';

class CustomerTab extends StatelessWidget {
  CustomerTab(this.model, {Key? key}) : super(key: key);
  StaticViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.isCustomerTabBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.refreshCustomer,
            child: SizedBox(
              height: 100.0.hp,
              width: 100.0.wp,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Column(
                  children: [
                    SortCardDesing(
                        height: 60,
                        items: [
                          AppLocalizations.of(context)!.status,
                          AppLocalizations.of(context)!.date
                        ]
                            .map(
                              (e) => DropdownMenuItem<String>(
                                onTap: () {
                                  model.customerSortList(e);
                                },
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        sortedItem: model.customerSortedItem),
                    for (int i = 0; i < model.customers.length; i++)
                      GestureDetector(
                        onTap: () {
                          model.gotoDetails(
                            model.customers[i].tempTxAddress!,
                            model.customers[i].retailerName!,
                            model.customers[i].uniqueId!,
                          );
                        },
                        child: StatusCardFourPart(
                          // status: 0,
                          title: model.customers[i].retailerName!,

                          subTitle: model.customers[i].taxId!,
                          bodyFirstKey:
                              "${AppLocalizations.of(context)!.email}:\nanacaona@mailnator.com",
                          bodySecondKey:
                              "${AppLocalizations.of(context)!.phoneNo}:\n${model.customers[i].phoneNumber!}",
                          statusChild: statusWidget(
                              text: StatusFile.statusForCustomer(
                                  model.language, model.customers[i].status!),
                              color: StatusFile.statusForCustomer(
                                                  model.language,
                                                  model.customers[i].status!)
                                              .toLowerCase() ==
                                          "active" ||
                                      StatusFile.statusForCustomer(
                                                  model.language,
                                                  model.customers[i].status!)
                                              .toLowerCase() ==
                                          "activa"
                                  ? AppColors.statusVerified
                                  : AppColors.statusReject,
                              isIconAvailable: true),
                        ),
                      ),
                    if (model.customers.isNotEmpty)
                      model.isButtonBusy
                          ? SizedBox(
                              height: 50.0,
                              child: Utils.loaderBusy(),
                            )
                          : model.isCustomerPageAvailable
                              ? Utils.loadMore(model.getMoreCustomer)
                              : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
  }
}
