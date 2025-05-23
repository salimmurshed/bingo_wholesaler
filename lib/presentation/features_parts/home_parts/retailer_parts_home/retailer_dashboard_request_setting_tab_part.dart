part of '../../../ui/home_screen/home_screen_view.dart';

class RetailerDashboardRequestSettingTabPart extends StatelessWidget {
  final HomeScreenViewModel model;

  const RetailerDashboardRequestSettingTabPart(this.model, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.allBottomTabBarPadding,
      color: AppColors.background,
      height: 9.0.hp,
      width: 100.0.wp,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                model.changeSecondaryBottomTab(
                    HomePageBottomTabs.dashboard, context);
              },
              child: TabBarButton(
                active:
                    model.homeScreenBottomTabs == HomePageBottomTabs.dashboard
                        ? true
                        : false,
                width: 114.0,
                text: AppLocalizations.of(context)!.dashBoard.toUpperCase(),
              ),
            ),
            GestureDetector(
              onTap: () {
                model.changeSecondaryBottomTab(
                    HomePageBottomTabs.requests, context);
              },
              child: TabBarButton(
                active:
                    model.homeScreenBottomTabs == HomePageBottomTabs.requests
                        ? true
                        : false,
                width: 114.0,
                text: AppLocalizations.of(context)!.requests.toUpperCase(),
              ),
            ),
            GestureDetector(
              onTap: () {
                model.changeSecondaryBottomTab(
                    HomePageBottomTabs.settings, context);
              },
              child: TabBarButton(
                active:
                    model.homeScreenBottomTabs == HomePageBottomTabs.settings
                        ? true
                        : false,
                width: 114.0,
                text: AppLocalizations.of(context)!.settings.toUpperCase(),
              ),
            ),
            if (model
                .isUserHaveAccess(UserRolesFiles.accountBalanceTabVisibility))
              GestureDetector(
                onTap: () {
                  model.changeSecondaryBottomTab(
                      HomePageBottomTabs.accountBalance, context);
                },
                child: TabBarButton(
                  active: model.homeScreenBottomTabs ==
                          HomePageBottomTabs.accountBalance
                      ? true
                      : false,
                  // width: 114.0,
                  text: AppLocalizations.of(context)!
                      .accountBalance
                      .toUpperCase(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
