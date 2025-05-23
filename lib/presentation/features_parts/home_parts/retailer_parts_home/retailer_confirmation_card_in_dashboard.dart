part of '../../../ui/home_screen/home_screen_view.dart';

class RetailerConfirmationCardInDashboard extends StatelessWidget {
  final ConfirmationModel confirmationData;
  final Function() function;

  const RetailerConfirmationCardInDashboard(
    this.confirmationData, {
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: AppMargins.retailerConfirmationMarginV,
        padding: AppPaddings.retailerConfirmationPadding,
        decoration: BoxDecoration(
          borderRadius: AppRadius.retailerConfirmationRadius,
          border: Border.all(
            color: AppColors.borderColors,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  confirmationData.invoice!,
                  style: AppTextStyles.dashboardHeadTitle
                      .copyWith(fontWeight: AppFontWeighs.semiBold),
                ),
                AutoSizeText(
                  "USD ${confirmationData.rate}",
                  maxLines: 1,
                  style: AppTextStyles.dashboardHeadTitle.copyWith(
                    fontWeight: AppFontWeighs.light,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      confirmationData.date!,
                      style: AppTextStyles.dashboardBodyTitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClassifiedText(
                        text1: AppLocalizations.of(context)!.orderID,
                        text2: '${confirmationData.orderId}'),
                    ClassifiedText(
                        text1: "${AppLocalizations.of(context)!.invoiceTo}:",
                        text2: '${confirmationData.invoiceTo}'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    statusNamesEnumFromServer(confirmationData.status)
                        .toStatus(),
                    10.0.giveHeight,
                    ClassifiedText(
                        text1: '${AppLocalizations.of(context)!.fiaName}:',
                        text2: '${confirmationData.fie}'),
                    ClassifiedText(
                        text1: AppLocalizations.of(context)!.sr,
                        text2: '${confirmationData.sNo}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
