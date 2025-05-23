import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../const/utils.dart';
import '../../../data_models/enums/user_type_for_web.dart';
import '../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:stacked/stacked.dart';
import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/app_styles/app_box_decoration.dart';
import '../../../const/web_devices.dart';
import '../../../data_models/construction_model/date_filter_model/date_filter_model.dart';
import '../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../widgets/cards/dashboard_tiles_card.dart';
import 'dash_board_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashBoardViewWeb extends StatelessWidget {
  const DashBoardViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashBoardViewModel>.reactive(
        viewModelBuilder: () => DashBoardViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        Expanded(
                          child: SecondaryNameAppBar(
                            h1: "${AppLocalizations.of(context)!.dashboard_h1} ${model.enrollment == UserTypeForWeb.retailer ? AppLocalizations.of(context)!.retailer : AppLocalizations.of(context)!.wholesaler.toUpperCamelCase()}",
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      WebAppBar(
                          onTap: (String v) {
                            model.changeTab(context, v);
                          },
                          tabNumber: model.tabNumber),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.dashboard_h1} ${model.enrollment == UserTypeForWeb.retailer ? AppLocalizations.of(context)!.retailer : AppLocalizations.of(context)!.wholesaler.toUpperCamelCase()}",
                            style: AppTextStyles.heading1,
                          ),
                          Text(
                            AppLocalizations.of(context)!.dashboard_h2,
                            style: AppTextStyles.headerText,
                          ),
                          FB5Row(
                            classNames: 'col-12',
                            children: [
                              FB5Col(
                                classNames:
                                    'col-12 col-lg-6 col-xl-6 col-sm-12',
                                child: SizedBox(
                                  width: 55.0.wp,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FB5Grid(
                                        classNames: 'row-cols-2 row-cols-sm-3',
                                        children: [
                                          for (var i = 0;
                                              i <
                                                  model
                                                      .retailerCardsPropertiesList
                                                      .length;
                                              i++)
                                            GestureDetector(
                                              onTap: () async {
                                                String? token =
                                                    await FirebaseMessaging
                                                        .instance
                                                        .getToken();
                                                Utils.fPrint(token);
                                              },
                                              child: DashboardTilesCard(
                                                color: model
                                                    .retailerCardsPropertiesList[
                                                        i]
                                                    .color!,
                                                icon: model
                                                    .retailerCardsPropertiesList[
                                                        i]
                                                    .icon!,
                                                amount: model
                                                    .retailerCardsPropertiesList[
                                                        i]
                                                    .amount!,
                                                title: model
                                                    .retailerCardsPropertiesList[
                                                        i]
                                                    .title!,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FB5Col(
                                classNames:
                                    'col-12 col-lg-6 col-xl-6 col-sm-12',
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: device == ScreenSize.wide
                                          ? 12.0
                                          : 0.0),
                                  color: Colors.white,
                                  width: 45.0.wp - 60,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Flex(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: device ==
                                                  ScreenSize.wide
                                              ? MainAxisAlignment.spaceBetween
                                              : MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              device == ScreenSize.wide
                                                  ? CrossAxisAlignment.center
                                                  : CrossAxisAlignment.start,
                                          direction: device == ScreenSize.wide
                                              ? Axis.horizontal
                                              : Axis.vertical,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .dashboard_depositSection_h2,
                                              style: AppTextStyles.headerText,
                                            ),
                                            Container(
                                              decoration: AppBoxDecoration
                                                  .dashboardCardDecoration
                                                  .copyWith(
                                                borderRadius:
                                                    AppRadius.s50Padding,
                                              ),
                                              // width: 100.0.wp - 80,
                                              height: 33.0,
                                              child: SizedBox(
                                                // width: 100.0.wp,
                                                child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  padding: AppPaddings.zero,
                                                  disabledColor:
                                                      AppColors.borderColors,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: Theme(
                                                      data: ThemeData(
                                                        primaryColor:
                                                            Colors.white,
                                                      ),
                                                      child: DropdownButton<
                                                          DateFilterModel>(
                                                        isDense: false,
                                                        style: AppTextStyles
                                                            .dashboardHeadTitleAsh,
                                                        value: model
                                                            .selectedDateFilter,
                                                        items: [
                                                          for (DateFilterModel item
                                                              in model
                                                                  .dateFilters)
                                                            DropdownMenuItem<
                                                                DateFilterModel>(
                                                              // onTap:
                                                              //     model.getDepositRecommendation,
                                                              value: item,
                                                              child: Text(
                                                                  item.title!),
                                                            )
                                                        ],
                                                        onChanged:
                                                            (DateFilterModel?
                                                                value) {
                                                          model
                                                              .changeFilterDate(
                                                                  value!);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: AppColors.dividerColor,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
