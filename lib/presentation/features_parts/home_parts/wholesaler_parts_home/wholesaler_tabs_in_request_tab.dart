part of '../../../ui/home_screen/home_screen_view.dart';

class WholesalerTabsInRequestTab extends StatelessWidget {
  final HomeScreenViewModel model;

  const WholesalerTabsInRequestTab(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.allTabBarPadding,
      height: 72,
      width: 100.0.wp,
      child: TabBar(
        controller: DefaultTabController.of(context),
        indicatorWeight: 0.1,
        dividerColor: AppColors.transparent,
        indicatorColor: AppColors.transparent,
        automaticIndicatorColorAdjustment: false,
        padding: AppPaddings.zero,
        labelPadding: AppPaddings.zero,
        isScrollable: false,
        indicatorPadding: AppPaddings.zero,
        onTap: (int i) {
          model.changeRequestTabWholesaler(i, context);
          print(model.requestTabTitleWholesaler);
        },
        // mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          TabBarButton(
            active: model.requestTabTitleWholesaler ==
                    HomePageRequestTabsW.associateRequest
                ? true
                : false,
            // width: 150.0,
            text: AppLocalizations.of(context)!.associationRequests,
          ),
          TabBarButton(
            active: model.requestTabTitleWholesaler ==
                    HomePageRequestTabsW.creditLineRequest
                ? true
                : false,
            // width: 150.0,
            text: AppLocalizations.of(context)!.creditLineRequests,
          ),
        ],
      ),
    );
  }
}
