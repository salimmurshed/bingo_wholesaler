import '/const/all_const.dart';
import '/presentation/ui/split_creditline_details/split_creditline_details_view_model.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/cards/app_bar_text.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplitCreditlineDetailsView extends StatelessWidget {
  const SplitCreditlineDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplitCreditlineDetailsViewModel>.reactive(
        onViewModelReady: (SplitCreditlineDetailsViewModel model) =>
            model.setData(ModalRoute.of(context)!.settings.arguments as String),
        viewModelBuilder: () => SplitCreditlineDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appBarColorRetailer,
              title:
                  AppBarText(AppLocalizations.of(context)!.creditlineDetails),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: ShadowCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.activeCreditLine,
                        style: AppTextStyles.normalCopyText,
                      ),
                    ),
                    10.0.giveHeight,
                    Text(
                      "${AppLocalizations.of(context)!.needBankAccountAlertMessage} ${model.fieName}",
                      style: AppTextStyles.dashboardHeadTitleAsh,
                    ),
                    20.0.giveHeight,
                    SubmitButton(
                      onPressed: model.goToAddManageAccount,
                      height: 45.0,
                      width: 100.0.wp,
                      text: AppLocalizations.of(context)!.addNewBankAccount,
                    ),
                    10.0.giveHeight,
                    SubmitButton(
                      onPressed: model.goBack,
                      height: 45.0,
                      width: 100.0.wp,
                      color: AppColors.statusReject,
                      text: AppLocalizations.of(context)!.cancelButton,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
