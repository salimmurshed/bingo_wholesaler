import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../data_models/models/customer_creditline_list/customer_creditline_list.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/sales_details_card.dart';
import 'customer_creditline_details_view_model.dart';

class CustomerCreditlineDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerCreditlineDetailsViewModel>.reactive(
        onViewModelReady: (CustomerCreditlineDetailsViewModel model) {
          model.setData(ModalRoute.of(context)!.settings.arguments
              as CustomerCreditlineData);
        },
        viewModelBuilder: () => CustomerCreditlineDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(AppLocalizations.of(context)!
                  .creditlinesDetail
                  .toUpperCase()),
            ),
            body: Padding(
              padding: AppPaddings.bodyVertical,
              child: ShadowCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            model.customerCreditlineData.clInternalId!,
                            style: AppTextStyles.dashboardHeadTitle
                                .copyWith(fontWeight: AppFontWeighs.semiBold),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    const Divider(
                      color: AppColors.dividerColor,
                    ),
                    Text(
                      AppLocalizations.of(context)!.status,
                      style: AppTextStyles.dashboardHeadTitle,
                    ),
                    model.customerCreditlineData.status!.toStatusFromInt(
                        value: StatusFile.statusForCreditline(
                            model.language,
                            model.customerCreditlineData.status!,
                            model.customerCreditlineData.statusDescription!),
                        isCenter: true),
                    const Divider(
                      color: AppColors.dividerColor,
                    ),
                    SalesDetails(
                      data: [
                        "${AppLocalizations.of(context)!.sr} ${model.customerCreditlineData.id!}",
                        "${AppLocalizations.of(context)!.retailer}: ${model.customerCreditlineData.retailerName!}",
                        "${AppLocalizations.of(context)!.fiaName}: ${model.customerCreditlineData.fieName!}",
                        "${AppLocalizations.of(context)!.appamount} ${model.customerCreditlineData.approvedCreditLineCurrency!} "
                            "${model.customerCreditlineData.approvedCreditLineAmount!}",
                        "${AppLocalizations.of(context)!.appDate}  ${model.customerCreditlineData.clApprovedDate}",
                        "${AppLocalizations.of(context)!.expDate} ${model.customerCreditlineData.expirationDate}",
                      ],
                    ),
                    20.0.giveHeight,
                    SalesDetails(
                      data: [
                        "${AppLocalizations.of(context)!.currentBalance} ${model.customerCreditlineData.approvedCreditLineCurrency!} ${model.customerCreditlineData.consumedAmount!}",
                        "${AppLocalizations.of(context)!.amountAvailable} : ${model.customerCreditlineData.approvedCreditLineCurrency!} ${model.availableAmount()}",
                      ],
                    ),
                    23.0.giveHeight,
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        minHeight: 10.0,
                        backgroundColor: const Color(0xffEBEBEB),
                        color: const Color(0xff5DC151),
                        value: model.getFrictionOfAvailability(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
