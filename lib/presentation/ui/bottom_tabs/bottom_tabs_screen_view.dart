import '../../../data_models/enums/user_type_for_web.dart';
import '/const/all_const.dart';
import '/const/app_sizes/app_icon_sizes.dart';
import '/const/app_sizes/app_sizes.dart';
import '/presentation/ui/home_screen/home_screen_view.dart';
import '/presentation/ui/static_screen/static_screen_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:stacked/stacked.dart';

import '../../../const/utils.dart';
import '../../../main.dart';
import '../drawer/drawer.dart';
import '../fourth_tab/fourth_tab_view.dart';
import '../notification/notification_view.dart';
import '../sales_add/sales_add_view.dart';
import 'bottom_tabs_view_model.dart';

class BottomTabsScreenView extends StatelessWidget {
  const BottomTabsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomTabsScreenViewModel>.reactive(
      viewModelBuilder: () => BottomTabsScreenViewModel(),
      builder: (context, model, child) {
        return DefaultTabController(
          initialIndex: model.selectedNumber,
          length: model.numberOfTabs,
          child: Builder(
            builder: (context) {
              FirebaseMessaging.onMessageOpenedApp
                  .listen((RemoteMessage message) {
                model.getNotification(context);
              });
              return WillPopScope(
                onWillPop: () => model.showExitPopup(context),
                child: Scaffold(
                  key: scaffoldKey,
                  endDrawerEnableOpenDragGesture: true,
                  drawer: const MyDrawer(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Visibility(
                    visible: model.selectedNumber != 2,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        // model.openAddDialog();
                        model.onChangedTab(context, 2);
                      },
                      elevation: 2.0,
                      child: Icon(
                        Icons.add,
                        size: AppIconSizes.s40,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  body: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      const HomeScreenView(),
                      StaticView(),
                      AddSalesView(),
                      ShowCaseWidget(
                        builder: (context) => const FourthTabView(),
                      ),
                      const NotificationView(),
                    ],
                  ),
                  bottomNavigationBar: Visibility(
                    visible: model.selectedNumber != 2,
                    child: BottomAppBar(
                      height: 50,
                      padding: const EdgeInsets.only(bottom: 0),
                      notchMargin: 0.0,
                      shape: const CircularNotchedRectangle(),
                      child: Padding(
                        padding: AppPaddings.bottomTabBarH,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset(
                                  AppAsset.navDashboardIcon,
                                  color: model.selectedNumber == 0
                                      ? AppColors.navBarActiveColor
                                      : AppColors.navBarInactiveColor,
                                  height: model.iconHeight,
                                ),
                                onPressed: () {
                                  model.onChangedTab(context, 0);
                                }),
                            IconButton(
                                icon: Image.asset(
                                  AppAsset.navStatIcon,
                                  color: model.selectedNumber == 1
                                      ? AppColors.navBarActiveColor
                                      : AppColors.navBarInactiveColor,
                                  height: model.iconHeight,
                                ),
                                onPressed: () {
                                  model.onChangedTab(context, 1);
                                }),
                            40.0.giveWidth,
                            IconButton(
                                icon: Image.asset(
                                  model.enrollment == UserTypeForWeb.retailer
                                      ? AppAsset.navOrder
                                      : AppAsset.navMapIcon,
                                  color: model.selectedNumber == 3
                                      ? AppColors.navBarActiveColor
                                      : AppColors.navBarInactiveColor,
                                  height: model.iconHeight,
                                ),
                                onPressed: () {
                                  model.onChangedTab(context, 3);
                                }),
                            Stack(
                              children: [
                                if (model.unseenNotification > 0)
                                  Positioned(
                                    top: 3,
                                    right: 8,
                                    child: Utils.notificationNumberingDesign(
                                        model.unseenNotification.toString(),
                                        size: 14.0,
                                        color: AppColors.redColor),
                                  ),
                                IconButton(
                                    icon: Image.asset(
                                      AppAsset.navBellIcon,
                                      color: model.selectedNumber == 4
                                          ? AppColors.navBarActiveColor
                                          : AppColors.navBarInactiveColor,
                                      height: model.iconHeight,
                                    ),
                                    onPressed: () {
                                      model.onChangedTab(context, 4);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
