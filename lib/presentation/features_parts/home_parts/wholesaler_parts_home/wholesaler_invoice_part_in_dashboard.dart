part of '../../../ui/home_screen/home_screen_view.dart';

class WholesalerInvoicePartInDashboard extends StatelessWidget {
  final InvoiceModel invoiceData;

  const WholesalerInvoicePartInDashboard(this.invoiceData, {Key? key})
      : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 35.0.wp,
                child: Utils.getNiceText(
                    "${AppLocalizations.of(context)!.invoiceTo}:${invoiceData.invoiceTo}",
                    nxtln: true),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child:
                      statusNamesEnumFromServer(invoiceData.status).toStatus(),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 35.0.wp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.getNiceText(
                        "${AppLocalizations.of(context)!.dateOfInvoice}${invoiceData.dateOfInvoice}",
                        nxtln: true),
                    Utils.getNiceText(
                        "${AppLocalizations.of(context)!.amounT}${invoiceData.amount}",
                        nxtln: true),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.getNiceText(
                        "${AppLocalizations.of(context)!.daysOfPayment}:${invoiceData.paymentDuration}",
                        nxtln: true),
                    Utils.getNiceText(
                      "${AppLocalizations.of(context)!.sNo}: ${invoiceData.sNo}",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
