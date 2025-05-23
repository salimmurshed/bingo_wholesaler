part of '../../../ui/home_screen/home_screen_view.dart';

class WholesalerNewOrderPartInDashboard extends StatelessWidget {
  const WholesalerNewOrderPartInDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppMargins.wholesalerInDashboardMarginB,
      padding: AppPaddings.wholesalerInDashboardPadding,
      decoration: BoxDecoration(
        borderRadius: AppRadius.wholesalerInDashboardRadius,
        border: Border.all(color: AppColors.borderColors),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.getNiceText(
                  "${AppLocalizations.of(context)!.orderFrom}:Domanica Inc",
                  nxtln: true),
              statusNamesEnumFromServer("Pending").toStatus(),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Utils.getNiceText("${AppLocalizations.of(context)!.sNo}: 1"),
              Utils.getNiceText(
                "${AppLocalizations.of(context)!.amount}: RD\$ 8,752.16",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
