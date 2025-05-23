part of '../../../ui/home_screen/home_screen_view.dart';

class WholesalerDashboardRequestTabPart extends StatelessWidget {
  final HomeScreenViewModel model;

  const WholesalerDashboardRequestTabPart(this.model, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.allBottomTabBarPadding,
      color: AppColors.background,
      width: 100.0.wp,
      height: 9.0.hp,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                width: 174.0,
                height: 30.0,
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
                width: 174.0,
                height: 30.0,
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
                width: 174.0,
                height: 30.0,
                text: AppLocalizations.of(context)!.settings.toUpperCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
