import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bingo/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/cupertino.dart';
import '../../../data_models/enums/todo_sale_type.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../../data_models/models/statement_web_model/statement_web_model.dart';
// import '../../web/financial_statement/retailer_financial_statements/grouped_list.dart';
import '../../widgets/checked_box.dart';
import '../../widgets/grouped_list.dart';
import '../../widgets/utils_folder/connection_widget.dart';
import '/const/all_const.dart';
import '/const/app_extensions/date_time.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/const/app_extensions/widgets_extensions.dart';
import '/data_models/models/all_sales_model/all_sales_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/routes_model/routes_model.dart';
import '../../../data_models/models/sales_zones/sales_zones.dart';
import '../../../data_models/models/today_route_list_model/today_route_list_model.dart';
import '../../../main.dart';
import '../../widgets/buttons/tab_bar_button.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/loader/loader.dart';
import '../../widgets/cards/route_card.dart';
import '../../widgets/cards/shadow_card.dart';
import '../../widgets/cards/slider.dart';
import '../../widgets/dropdowns/sort_card_design.dart';

import '../../widgets/slidable/slider.dart';
import 'fourth_tab_view_model.dart';

part '../../features_parts/fourth_tabs/creditline.dart';

part '../../features_parts/fourth_tabs/financial_statements.dart';

part '../../features_parts/fourth_tabs/settlements.dart';

class FourthTabView extends StatelessWidget {
  const FourthTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FourthTabViewModel>.reactive(
        viewModelBuilder: () => FourthTabViewModel(),
        onViewModelReady: (FourthTabViewModel model) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => model.stageReady(context));
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: Image.asset(AppAsset.moreIcon),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      model.readQrScanner(context);
                    },
                    icon: const Icon(Icons.qr_code),
                  ),
                ),
              ],
              backgroundColor: model.enrollment == UserTypeForWeb.retailer
                  ? AppColors.appBarColorRetailer
                  : AppColors.appBarColorWholesaler,
              title: AppBarText(model.enrollment == UserTypeForWeb.retailer
                  ? AppLocalizations.of(context)!.finance
                  : AppLocalizations.of(context)!.logistic),
            ),
            body: model.enrollment == UserTypeForWeb.wholesaler
                ? wholesalerParts(context, model)
                : getViewForIndex(model.currentTabIndex, model),
            bottomNavigationBar: model.enrollment == UserTypeForWeb.wholesaler
                ? const SizedBox()
                : DefaultTabController(
                    length: 3,
                    child: Container(
                      padding: AppPaddings.allBottomTabBarPadding,
                      color: AppColors.background,
                      height: 9.0.hp,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                model.setTabIndex(0);
                              },
                              child: TabBarButton(
                                  // width: 110,
                                  active:
                                      model.currentTabIndex == 0 ? true : false,
                                  text: AppLocalizations.of(context)!
                                      .creditlines),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.setTabIndex(1);
                              },
                              child: TabBarButton(
                                  // width: 160,
                                  active:
                                      model.currentTabIndex == 1 ? true : false,
                                  text: AppLocalizations.of(context)!.fIS),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.setTabIndex(2);
                              },
                              child: TabBarButton(
                                  // width: 110,
                                  active:
                                      model.currentTabIndex == 2 ? true : false,
                                  text: AppLocalizations.of(context)!
                                      .settlements),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }

  Widget getViewForIndex(int index, FourthTabViewModel model) {
    switch (index) {
      case 0:
        return Creditlines(model);
      case 1:
        return FinancialStatements(model);
      case 2:
        return Settlements(model);
      // return model.isRetailer ? WholesalerTabs(model) : CustomerTab(model);
      case 3:
      // return FieTabs(model);
    }
    return const SizedBox();
  }

  Widget wholesalerParts(context, FourthTabViewModel model) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 60,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // controller: DefaultTabController.of(context),

              children: [
                GestureDetector(
                  onTap: () {
                    model.changeTab(0);
                  },
                  child: TabBarButton(
                    // width: 40.0.wp,
                    active: model.logisticTab == 0 ? true : false,
                    // width: 150.0,
                    text: AppLocalizations.of(context)!.todayRoutTabName,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeTab(1);
                  },
                  child: TabBarButton(
                    // width: 40.0.wp,
                    active: model.logisticTab == 1 ? true : false,
                    // width: 150.0,
                    text: AppLocalizations.of(context)!.dynamicRoutTabName,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeTab(2);
                  },
                  child: TabBarButton(
                    // width: 40.0.wp,
                    active: model.logisticTab == 2 ? true : false,
                    // width: 150.0,
                    text: AppLocalizations.of(context)!.staticRoutTabName,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.changeTab(3);
                  },
                  child: TabBarButton(
                    // width: 40.0.wp,
                    active: model.logisticTab == 3 ? true : false,
                    // width: 150.0,
                    text: AppLocalizations.of(context)!.saleZoneTabName,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: model.logisticTab == 0
              ? todoList(model, context)
              : model.logisticTab == 1
                  ? dynamicRoutes(model, context)
                  : model.logisticTab == 2
                      ? staticRoute(model, context)
                      : salesZone(model, context),
        )
      ],
    );
  }

  Widget todoList(FourthTabViewModel model, BuildContext context) {
    return model.busy(model.todayRouteList)
        ? const LoaderWidget()
        : model.isBusy
            ? const LoaderWidget()
            : model.todayRouteList.pendingToAttendStores == null ||
                    model.todayRouteList.completedStores == null
                ? Utils.noDataWidget(context)
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RefreshIndicator(
                      backgroundColor: AppColors.whiteColor,
                      color: AppColors.appBarColorRetailer,
                      onRefresh: model.pullTodoForRefresh,
                      child: SingleChildScrollView(
                        physics: Utils.pullScrollPhysic,
                        child: SlidableAutoCloseBehavior(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                  visible: !(model.todayRouteList
                                          .pendingToAttendStores!.isEmpty &&
                                      model.todayRouteList.completedStores!
                                          .isEmpty),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SubmitButton(
                                      onPressed: model.clear,
                                      width: 50.0,
                                      text: "CLEAR",
                                    ),
                                  )),
                              if (!model.isVisitTutorialOne)
                                Showcase(
                                  onTargetClick: model.setTutorialOneVisited,
                                  onToolTipClick: model.setTutorialOneVisited,
                                  onBarrierClick: model.setTutorialOneVisited,
                                  disposeOnTap: model.isVisitTutorialOne,
                                  key: model.one,
                                  title: AppLocalizations.of(context)!
                                      .showcaseHeader,
                                  description: AppLocalizations.of(context)!
                                      .showcaseBody1,
                                  child: Image.asset(AppAsset.tutorial1),
                                ),
                              if ((model.todayRouteList.pendingToAttendStores ==
                                          [] &&
                                      model.todayRouteList.completedStores ==
                                          []) ||
                                  (model.todayRouteList.pendingToAttendStores!
                                          .isEmpty &&
                                      model.todayRouteList.completedStores!
                                          .isEmpty))
                                Utils.noDataWidget(context),
                              if (model.todayRouteList.pendingToAttendStores!
                                  .isNotEmpty)
                                for (int p = 0;
                                    p <
                                        model.todayRouteList
                                            .pendingToAttendStores!.length;
                                    p++)
                                  todaySaleCard(
                                      model,
                                      p,
                                      model.todayRouteList
                                          .pendingToAttendStores![p],
                                      true,
                                      context,
                                      TodoSaleType.pending),
                              40.0.giveHeight,
                              if (model
                                  .todayRouteList.completedStores!.isNotEmpty)
                                Text(
                                  "${AppLocalizations.of(context)!.completed} (${model.todayRouteList.completedStores!.length})",
                                  style: AppTextStyles.headerText,
                                ),
                              20.0.giveHeight,
                              for (int c = 0;
                                  c <
                                      model.todayRouteList.completedStores!
                                          .length;
                                  c++)
                                todaySaleCard(
                                    model,
                                    c,
                                    model.todayRouteList.completedStores![c],
                                    false,
                                    context,
                                    TodoSaleType.complete),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
  }

  Widget todaySaleCard(
      FourthTabViewModel model,
      int k,
      PendingToAttendStores todayRouteListData,
      bool isPending,
      BuildContext context,
      TodoSaleType todoSaleType) {
    return Card(
      color: isPending ? AppColors.whiteColor : AppColors.cardShadow,
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          color: isPending ? AppColors.whiteColor : AppColors.cardShadow,
          // color: AppColors.whiteColor,
          borderRadius: AppRadius.mainCardThemeRadius,
        ),
        child: Column(
          children: [
            SliderCard(
              isPending: isPending,
              longPull: () {
                // if (isPending) {
                //   todayRouteListData.sales!.isEmpty
                //       ? model.saleAddition(todayRouteListData, isPending)
                //       : model.salesExecution(todayRouteListData.sales![0],
                //           todayRouteListData.routeId!);
                // } else {
                //   model.saleAddition(todayRouteListData, isPending);
                // }
                if (isPending) {
                  todayRouteListData.sales!.isEmpty
                      ? model.saleAddition(todayRouteListData, isPending)
                      : model.salesExecution(todayRouteListData.sales![0],
                          todayRouteListData.routeId!);
                } else {
                  model.saleAddition(todayRouteListData, isPending);
                }
              },
              isAddNew: todayRouteListData.sales!.isEmpty,
              group: '1',
              keyValue: 3,
              actionFirst: (_) {
                model.openMoreOption(k, isPending: isPending);
              },
              actionTwo: (_) {
                if (isPending) {
                  todayRouteListData.sales!.isEmpty
                      ? model.saleAddition(todayRouteListData, isPending)
                      : model.salesExecution(todayRouteListData.sales![0],
                          todayRouteListData.routeId!);
                } else {
                  model.saleAddition(todayRouteListData, isPending);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  borderRadius: AppRadius.mainCardThemeRadius,
                  color: isPending ? AppColors.cardColor : AppColors.cardShadow,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.0.giveWidth,
                    if (todayRouteListData.sales!.isNotEmpty)
                      Utils.notificationNumberingDesign(
                          todayRouteListData.sales!.length.toString()),
                    Expanded(
                      child: ListTile(
                        minVerticalPadding: 0.0,
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          AppAsset.house,
                          height: 32.0,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todayRouteListData.storeName!,
                              style: AppTextStyles.normalCopyText,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    todayRouteListData.address!, //store address
                                    style: AppTextStyles.successStyle.copyWith(
                                        fontWeight: AppFontWeighs.medium,
                                        color: AppColors.ashColor),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    10.0.giveWidth,
                  ],
                ),
              ),
            ),
            for (int i = 0; i < todayRouteListData.sales!.length; i++)
              Card(
                clipBehavior: Clip.hardEdge,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.mainCardThemeRadius,
                  ),
                  child: SliderCard(
                      isPending: isPending,
                      longPull: () {
                        if (isPending) {
                          model.salesExecution(todayRouteListData.sales![i],
                              todayRouteListData.routeId!);
                        } else {
                          model.saleAddition(todayRouteListData, isPending,
                              saleId: todayRouteListData.sales![i].uniqueId!);
                        }
                      },
                      isAddNew: false,
                      actionFirst: (_) {
                        model.openMoreOption(k,
                            isPending: isPending,
                            saleId: todayRouteListData.sales![i].uniqueId!);
                      },
                      actionTwo: (_) {
                        if (isPending) {
                          model.salesExecution(todayRouteListData.sales![i],
                              todayRouteListData.routeId!);
                        } else {
                          model.saleAddition(todayRouteListData, isPending,
                              saleId: todayRouteListData.sales![i].uniqueId!);
                        }
                      },
                      group: '1',
                      keyValue: i,
                      child: todoSaleCard(
                          todayRouteListData.sales![i], model, context)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget todoSaleCard(
      AllSalesData sales, FourthTabViewModel model, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.mainCardThemeRadius,
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    sales.invoiceNumber!,
                    style: AppTextStyles.statusCardTitle,
                  ),
                ),
                Text(
                  "${sales.currency} ${sales.amount}",
                  style: AppTextStyles.statusCardTitle,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sales.retailerName!,
                  style: AppTextStyles.statusCardSubTitle,
                ),
                sales.status!.toSaleStatus(
                    text: StatusFile.statusForSale(model.language,
                        sales.status!, sales.statusDescription!)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40.0.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.saleDate}: ${sales.saleDate}'),
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.dueDate}: ${sales.dueDate}'),
                    ],
                  ),
                ),
                20.0.giveWidth,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Utils.getNiceText(
                          '${AppLocalizations.of(context)!.fie}: ${sales.fieName}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dynamicRoutes(FourthTabViewModel model, context) {
    return model.dynamicRouteBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.pullToRefreshDynamicRoutes,
            child: SizedBox(
              height: 100.00.hp,
              width: 100.00.wp,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Column(
                  children: [
                    Padding(
                      padding: AppPaddings.commonTextPadding,
                      child: InkWell(
                        onTap: () {
                          model.openDateTime(context);
                        },
                        child: Container(
                          width: 90.0.wp,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              "${model.dateDynamicRoutes[0].formatSlash()} - ${model.dateDynamicRoutes[1].formatSlash()}",
                              style: AppTextStyles.successStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (model.dynamicRoutes.isEmpty)
                      Utils.noDataWidget(context, height: 60.0.hp - 58.0),
                    for (RoutesModelData data in model.dynamicRoutes)
                      InkWell(
                          onTap: () {
                            model.gotoRoutesDetails(
                                data.uniqueId, data.routeId, true);
                          },
                          child: RouteCard(
                            routes: data,
                            isDynamic: true,
                          )),
                    if (model.hasDynamicRoutesNextPage)
                      model.isLoaderBusy
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Utils.loaderBusy(),
                            )
                          : Utils.loadMore(model.loadMoreDynamicRoutes)
                  ],
                ),
              ),
            ),
          );
  }

  Widget staticRoute(FourthTabViewModel model, BuildContext context) {
    return model.staticRouteBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.pullToRefreshStaticRoutes,
            child: SizedBox(
              height: 100.00.hp,
              width: 100.00.wp,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Column(
                  children: [
                    if (model.staticRoutes.isEmpty)
                      Utils.noDataWidget(context, height: 60.0.hp + 32),
                    for (RoutesModelData data in model.staticRoutes)
                      InkWell(
                          onTap: () {
                            model.gotoRoutesDetails(
                                data.uniqueId, data.routeId, false);
                          },
                          child: RouteCard(routes: data)),
                    if (model.hasDynamicRoutesNextPage)
                      model.isLoaderBusy
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Utils.loaderBusy(),
                            )
                          : Utils.loadMore(model.loadMoreDynamicRoutes)
                  ],
                ),
              ),
            ),
          );
  }

  Widget salesZone(FourthTabViewModel model, BuildContext context) {
    return model.staticZoneBusy
        ? const LoaderWidget()
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.pullToRefreshSalesZone,
            child: SizedBox(
              height: 100.00.hp,
              width: 100.00.wp,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Column(
                  children: [
                    if (model.saleZones.isEmpty)
                      Utils.noDataWidget(context, height: 60.0.hp + 32),
                    for (SaleZonesData data in model.saleZones)
                      InkWell(
                          onTap: () {
                            model.gotoSalesZoneDetails(
                                data.uniqueId, data.salesId, false);
                          },
                          child: RouteCard(
                            salesZone: data,
                          )),
                    if (model.hasDynamicRoutesNextPage)
                      model.isLoaderBusy
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Utils.loaderBusy(),
                            )
                          : Utils.loadMore(model.loadMoreDynamicRoutes)
                  ],
                ),
              ),
            ),
          );
  }

  tab(item) {
    return TabBarButton(
      active: false,
      text: item,
    );
  }
}
