part of '../../../ui/customer_details/customer_details_view.dart';

class CustomerTabs extends StatelessWidget {
  CustomerDetailsViewModel model;

  CustomerTabs(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 60,
      child: TabBar(
        dividerColor: AppColors.transparent,
        tabAlignment: TabAlignment.start,
        controller: DefaultTabController.of(context),
        indicatorWeight: 0.1,
        dividerHeight: 0,
        indicatorColor: AppColors.transparent,
        padding: AppPaddings.zero,
        labelPadding: AppPaddings.zero,
        isScrollable: true,
        indicatorPadding: AppPaddings.zero,
        onTap: (int i) {
          model.changeTab(i, context);
        },
        tabs: [
          tab(CustomersTabs.creditlines,
              AppLocalizations.of(context)!.creditlines),
          tab(CustomersTabs.orders, AppLocalizations.of(context)!.orders),
          tab(CustomersTabs.sales, AppLocalizations.of(context)!.sales),
          tab(CustomersTabs.locations, AppLocalizations.of(context)!.locations),
          tab(CustomersTabs.profile, AppLocalizations.of(context)!.profile),
          tab(CustomersTabs.internal, AppLocalizations.of(context)!.internal),
        ],
      ),
    );
  }

  tab(CustomersTabs item, String name) {
    return TabBarButton(
      fit: true,
      // width: 30.0.wp,
      active: model.customerTab == item ? true : false,
      // width: 150.0,
      text: name.trim().toUpperCase(),
    );
  }
}
