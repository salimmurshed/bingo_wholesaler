part of '../../../ui/home_screen/home_screen_view.dart';

class RetailerTabsInRequestTab extends StatelessWidget {
  final HomeScreenViewModel model;

  const RetailerTabsInRequestTab(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.allTabBarPadding,
      height: 72,
      child: TabBar(
        dividerColor: AppColors.transparent,
        tabAlignment: TabAlignment.start,
        controller: DefaultTabController.of(context),
        // indicatorWeight: 0.1,
        indicatorColor: AppColors.transparent,
        padding: AppPaddings.zero,
        labelPadding: AppPaddings.zero,
        isScrollable: true,
        indicatorPadding: AppPaddings.zero,
        onTap: (int i) {
          model.changeRequestTabRetailer(i, context);
        },
        tabs: [
          TabBarButton(
            active: model.requestTabTitleRetailer ==
                    HomePageRequestTabsR.wAssociateRequest
                ? true
                : false,
            text: AppLocalizations.of(context)!.wAssociationRequests,
          ),
          TabBarButton(
            active: model.requestTabTitleRetailer ==
                    HomePageRequestTabsR.fAssociateRequest
                ? true
                : false,
            text: AppLocalizations.of(context)!.fAssociationRequests,
          ),
          TabBarButton(
            active: model.requestTabTitleRetailer ==
                    HomePageRequestTabsR.creditLineRequest
                ? true
                : false,
            text: AppLocalizations.of(context)!.creditLineRequests,
          ),
        ],
      ),
    );
  }
}
