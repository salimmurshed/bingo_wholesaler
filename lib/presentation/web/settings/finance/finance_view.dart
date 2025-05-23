import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

import '../../../../app/locator.dart';
import '../../../../app/web_route.dart';
import '../../../../const/web_devices.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../../../../services/web_basic_service/WebBasicService.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../widgets/web_widgets/cards/logistic_cards.dart';

class Finance extends StatelessWidget {
  Finance({Key? key}) : super(key: key);
  final WebBasicService _webBasicService = locator<WebBasicService>();
  void changeTab(BuildContext context, String v) {
    _webBasicService.changeTab(context, v);
  }

  UserTypeForWeb get enrollment => locator<AuthService>().enrollment.value;
  String get tabNumber => _webBasicService.tabNumber.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: WebAppBar(
          onTap: (String v) {
            changeTab(context, v);
          },
          tabNumber: tabNumber),
      appBar: device == ScreenSize.wide
          ? null
          : AppBar(
              backgroundColor: enrollment == UserTypeForWeb.retailer
                  ? AppColors.bingoGreen
                  : AppColors.appBarColorWholesaler,
              title: SecondaryNameAppBar(
                h1: 'Finance',
              ),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (device != ScreenSize.small)
                WebAppBar(
                    onTap: (String v) {
                      changeTab(context, v);
                    },
                    tabNumber: tabNumber),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      SecondaryNameAppBar(
                        h1: 'Finance',
                      ),
                    Container(
                      padding: EdgeInsets.all(
                          device != ScreenSize.wide ? 12.0 : 32.0),
                      color: Colors.white,
                      width: 100.0.wp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: AppColors.dividerColor,
                          ),
                          Flex(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: device == ScreenSize.wide
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.start,
                            crossAxisAlignment: device == ScreenSize.wide
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            direction: device == ScreenSize.wide
                                ? Axis.horizontal
                                : Axis.vertical,
                            children: const [
                              LogisticCard(
                                  "Bank Accounts",
                                  AppColors.business_cardColor1,
                                  Routes.customerTypesView),
                              LogisticCard(
                                  "Credit Line Limits",
                                  AppColors.business_cardColor2,
                                  Routes.gracePeriodsGroupsView),
                              LogisticCard(
                                  "Settlements",
                                  AppColors.business_cardColor3,
                                  Routes.pricingGroupView),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
