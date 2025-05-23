part of '../../../ui/home_screen/home_screen_view.dart';

class Requests extends StatelessWidget {
  const Requests({Key? key, required this.model, required this.isRetailer})
      : super(key: key);
  final HomeScreenViewModel model;
  final bool isRetailer;

  @override
  Widget build(BuildContext context) {
    return model.isBusy
        ? SizedBox(
            width: 100.0.wp,
            height: 100.0.hp,
            child: const Center(
              child: LoaderWidget(),
            ),
          )
        : isRetailer
            ? SizedBox(
                width: 100.0.wp,
                child: DefaultTabController(
                  length: 3,
                  initialIndex: model.requestTabTitleRetailer.index,
                  child: Column(
                    children: [
                      RetailerTabsInRequestTab(model),
                      Expanded(
                        child: TabBarView(
                          dragStartBehavior: DragStartBehavior.down,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            RefreshIndicator(
                              backgroundColor: AppColors.whiteColor,
                              color: AppColors.appBarColorRetailer,
                              onRefresh: model.refreshRetailerWHSAssReq,
                              child: SizedBox(
                                height: 100.00.hp,
                                width: 100.00.wp,
                                child: SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (model.globalMessage.message != null)
                                        SnackBarRepo(
                                          success:
                                              !model.globalMessage.success!,
                                          text: model.globalMessage.message!,
                                        ),
                                      if (model.isUserHaveAccess(UserRolesFiles
                                          .addWholesalerAssociationRequest))
                                        Padding(
                                          padding: AppPaddings.allTabBarPadding,
                                          child: SizedBox(
                                            width: 100.0.wp,
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(),
                                                SubmitButton(
                                                  onPressed: () {
                                                    model.gotoAddNewRequest(
                                                        RetailerTypeAssociationRequest
                                                            .wholesaler);
                                                  },
                                                  width: 100.0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .addNew,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (model.wholesalerAssociationRequestData
                                          .isEmpty)
                                        Center(
                                          child: Utils.noDataWidget(context),
                                        ),
                                      for (int j = 0;
                                          j <
                                              model
                                                  .wholesalerAssociationRequestData
                                                  .length;
                                          j++)
                                        StatusCard(
                                          onTap: () {
                                            model.gotoAssociationRequestDetailsScreen(
                                                model
                                                    .wholesalerAssociationRequestData[
                                                        j]
                                                    .associationUniqueId!,
                                                RetailerTypeAssociationRequest
                                                    .wholesaler,
                                                isFie: false);
                                          },
                                          title: model
                                              .wholesalerAssociationRequestData[
                                                  j]
                                              .wholesalerName!,
                                          subTitle: model
                                              .wholesalerAssociationRequestData[
                                                  j]
                                              .id!,
                                          // statusWidget: Expanded(
                                          //     child: statusNamesEnumFromServer(model
                                          //             .wholesalerAssociationRequestData[
                                          //                 j]
                                          //             .status!)
                                          //         .toStatus()),
                                          status: model
                                              .wholesalerAssociationRequestData[
                                                  j]
                                              .status!,
                                          bodyFirstKey:
                                              "${AppLocalizations.of(context)!.emailTitle}:",
                                          bodyFirstValue: model
                                              .wholesalerAssociationRequestData[
                                                  j]
                                              .email!,
                                          bodySecondKey:
                                              "${AppLocalizations.of(context)!.phoneNo}:",
                                          bodySecondValue: model
                                              .wholesalerAssociationRequestData[
                                                  j]
                                              .phoneNumber!,
                                        ),
                                      20.0.giveHeight,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            RefreshIndicator(
                              backgroundColor: AppColors.whiteColor,
                              color: AppColors.appBarColorRetailer,
                              onRefresh: model.refreshRetailerFIEAssReq,
                              child: SizedBox(
                                height: 100.00.hp,
                                width: 100.00.wp,
                                child: SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (model.globalMessage.message != null)
                                        SnackBarRepo(
                                          success:
                                              !model.globalMessage.success!,
                                          text: model.globalMessage.message!,
                                        ),
                                      if (model.isUserHaveAccess(UserRolesFiles
                                          .addFieAssociationRequest))
                                        Padding(
                                          padding: AppPaddings.allTabBarPadding,
                                          child: SizedBox(
                                            width: 100.0.wp,
                                            height: 50.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(),
                                                SubmitButton(
                                                  onPressed: () {
                                                    model.gotoAddNewRequest(
                                                        RetailerTypeAssociationRequest
                                                            .fie);
                                                  },
                                                  width: 100.0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .addNew,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (model
                                          .fieAssociationRequestData.isEmpty)
                                        Utils.noDataWidget(context),
                                      for (int j = 0;
                                          j <
                                              model.fieAssociationRequestData
                                                  .length;
                                          j++)
                                        StatusCard(
                                          onTap: () {
                                            model.gotoAssociationRequestDetailsScreen(
                                                model
                                                    .fieAssociationRequestData[
                                                        j]
                                                    .uniqueId!,
                                                RetailerTypeAssociationRequest
                                                    .fie,
                                                isFie: true);
                                          },
                                          title: model
                                              .fieAssociationRequestData[j]
                                              .fieName!,
                                          subTitle: model
                                              .fieAssociationRequestData[j].id!,
                                          status: model
                                              .fieAssociationRequestData[j]
                                              .status!,
                                          bodyFirstKey:
                                              "${AppLocalizations.of(context)!.emailTitle}:",
                                          bodyFirstValue: model
                                              .fieAssociationRequestData[j]
                                              .email!,
                                          bodySecondKey:
                                              "${AppLocalizations.of(context)!.phoneNo}:",
                                          bodySecondValue: model
                                              .fieAssociationRequestData[j]
                                              .phoneNumber!,
                                        ),
                                      20.0.giveHeight,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            RefreshIndicator(
                              backgroundColor: AppColors.whiteColor,
                              color: AppColors.appBarColorRetailer,
                              onRefresh: model.refreshRetailerCreditLine,
                              child: SizedBox(
                                height: 100.00.hp,
                                width: 100.00.wp,
                                child: SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: AppPaddings.allTabBarPadding,
                                        child: SizedBox(
                                          width: 100.0.wp,
                                          height: 50.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(),
                                              if (model.isMaster ||
                                                  model.isUserHaveAccess(
                                                      UserRolesFiles
                                                          .addCreditlineRequest))
                                                SubmitButton(
                                                  onPressed:
                                                      model.gotoAddCreditLine,
                                                  width: 100.0,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .addNew,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (model.retailerCreditLineRequestData
                                          .isEmpty)
                                        Utils.noDataWidget(context),
                                      for (int j = 0;
                                          j <
                                              model
                                                  .retailerCreditLineRequestData
                                                  .length;
                                          j++)
                                        StatusCardCreditLine(
                                          onTap: () {
                                            model.gotoViewCreditLine(j);
                                          },
                                          title:
                                              "${model.retailerCreditLineRequestData[j].fieName!}\n${model.getSaleId(model.retailerCreditLineRequestData[j].creditlineUniqueId!)}",
                                          subTitle: model
                                              .retailerCreditLineRequestData[j]
                                              .wholesalerName!,
                                          statusWidget: model.isUserHaveAccess(
                                                  UserRolesFiles
                                                      .showRetailerCreditlineStatus)
                                              ? (model
                                                  .retailerCreditLineRequestData[
                                                      j]
                                                  .status!
                                                  .toStatusFromInt(
                                                      value: StatusFile.statusForCreditline(
                                                          model.language,
                                                          model
                                                              .retailerCreditLineRequestData[
                                                                  j]
                                                              .status!,
                                                          model
                                                              .retailerCreditLineRequestData[
                                                                  j]
                                                              .statusDescription!)))
                                              : const SizedBox(),
                                          bodyFirstKey:
                                              "${AppLocalizations.of(context)!.dateRequested}:",
                                          bodyFirstValue: model
                                              .retailerCreditLineRequestData[j]
                                              .dateRequested!,
                                          bodySecondKey:
                                              "${AppLocalizations.of(context)!.amount}:",
                                          bodySecondValue:
                                              "${model.retailerCreditLineRequestData[j].currency} ${model.retailerCreditLineRequestData[j].requestedAmount}",
                                        ),
                                      20.0.giveHeight,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                width: 100.0.wp,
                child: DefaultTabController(
                  length: 2,
                  initialIndex: model.requestTabTitleWholesaler.index,
                  child: Column(
                    children: [
                      WholesalerTabsInRequestTab(model),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            RefreshIndicator(
                              backgroundColor: AppColors.whiteColor,
                              color: AppColors.appBarColorWholesaler,
                              onRefresh: model.refreshWholesalerAssReq,
                              child: SizedBox(
                                height: 100.0.hp,
                                width: 100.0.wp,
                                child: SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (model
                                          .wholesalerAssociationRequest.isEmpty)
                                        Utils.noDataWidget(context),
                                      for (int j = 0;
                                          j <
                                              model.wholesalerAssociationRequest
                                                  .length;
                                          j++)
                                        StatusCard(
                                          onTap: () {
                                            model.gotoAssociationRequestDetailsScreen(
                                                model
                                                    .wholesalerAssociationRequest[
                                                        j]
                                                    .associationUniqueId!,
                                                RetailerTypeAssociationRequest
                                                    .wholesaler);
                                          },
                                          title: model
                                              .wholesalerAssociationRequest[j]
                                              .retailerName!,
                                          subTitle: model
                                              .wholesalerAssociationRequest[j]
                                              .id!,
                                          status: model
                                              .wholesalerAssociationRequest[j]
                                              .status!,
                                          bodyFirstKey:
                                              AppLocalizations.of(context)!
                                                  .emailTitle,
                                          bodyFirstValue: model
                                              .wholesalerAssociationRequest[j]
                                              .email!,
                                          bodySecondKey:
                                              AppLocalizations.of(context)!
                                                  .phoneTitle,
                                          bodySecondValue: model
                                              .wholesalerAssociationRequest[j]
                                              .phoneNumber!,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            RefreshIndicator(
                              backgroundColor: AppColors.whiteColor,
                              color: AppColors.appBarColorWholesaler,
                              onRefresh: model.refreshWholesalerCreditLine,
                              child: SizedBox(
                                height: 100.0.hp,
                                width: 100.0.wp,
                                child: SingleChildScrollView(
                                  physics: Utils.pullScrollPhysic,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (model.wholesalerCreditLineRequestData
                                          .isEmpty)
                                        Utils.noDataWidget(context),
                                      for (int j = 0;
                                          j <
                                              model
                                                  .wholesalerCreditLineRequestData
                                                  .length;
                                          j++)
                                        StatusCardCreditLine(
                                          onTap: () {
                                            model.gotoViewCreditLineWholeSaler(
                                                j);
                                          },
                                          title: model
                                              .wholesalerCreditLineRequestData[
                                                  j]
                                              .retailerName!,
                                          subTitle: model
                                              .wholesalerCreditLineRequestData[
                                                  j]
                                              .uniqueId!
                                              .substring(0, 8),
                                          status: model
                                              .wholesalerCreditLineRequestData[
                                                  j]
                                              .status!,
                                          statusDescription:
                                              model.statusForCreditline(j),
                                          bodyFirstKey:
                                              "${AppLocalizations.of(context)!.dateRequested}:",
                                          bodyFirstValue: model
                                              .wholesalerCreditLineRequestData[
                                                  j]
                                              .dateRequested!,
                                          bodySecondKey:
                                              "${AppLocalizations.of(context)!.amount}:",
                                          bodySecondValue:
                                              "${model.wholesalerCreditLineRequestData[j].currency} ${model.wholesalerCreditLineRequestData[j].requestedAmount}",
                                        ),
                                      10.0.giveHeight,
                                      if (model.hasCreditLineNextPage)
                                        model.busy(model.hasCreditLineNextPage)
                                            ? Utils.loaderBusy()
                                            : Utils.loadMore(model
                                                .loadMoreCreditLineWholesaler),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}
