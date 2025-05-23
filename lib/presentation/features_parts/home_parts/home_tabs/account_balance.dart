part of '../../../ui/home_screen/home_screen_view.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({Key? key, required this.model}) : super(key: key);
  final HomeScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return model.isBusy
        ? SizedBox(
            width: 100.0.wp,
            height: 100.0.hp,
            child: const Center(
              child: LoaderWidget(),
            ),
          )
        : RefreshIndicator(
            backgroundColor: AppColors.whiteColor,
            color: AppColors.appBarColorRetailer,
            onRefresh: model.refreshRetailerBankAccountBalance,
            child: Container(
              padding: AppPaddings.topPadding,
              width: 100.0.wp,
              child: SingleChildScrollView(
                physics: Utils.pullScrollPhysic,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (model.retailerBankAccountBalanceData.isEmpty)
                      Utils.noDataWidget(context),
                    for (int j = 0;
                        j < model.retailerBankAccountBalanceData.length;
                        j++)
                      AccountBalanceCard(
                        title:
                            "${AppLocalizations.of(context)!.balance}: ${model.retailerBankAccountBalanceData[j].currency} ${model.retailerBankAccountBalanceData[j].balance}",
                        subTitleList: [
                          "${AppLocalizations.of(context)!.accountType}:${StatusFile.bankAccountType(model.language, model.retailerBankAccountBalanceData[j].bankAccountType!)}",
                          "${AppLocalizations.of(context)!.accountNo}${model.retailerBankAccountBalanceData[j].bankAccountNumber} ",
                          "${AppLocalizations.of(context)!.bankName}:${model.retailerBankAccountBalanceData[j].bankName}",
                          "${AppLocalizations.of(context)!.iban}:${model.retailerBankAccountBalanceData[j].iban}",
                          "${AppLocalizations.of(context)!.date}:${model.retailerBankAccountBalanceData[j].date == '-' ? "-" : model.retailerBankAccountBalanceData[j].date}",
                          "${AppLocalizations.of(context)!.dateTimeUpdate}"
                              "${model.retailerBankAccountBalanceData[j].updatedAt == '-' ? "-" : DateFormat(SpecialKeys.dateFormatWithHour).format(DateTime.parse(model.retailerBankAccountBalanceData[j].updatedAt!))}"
                        ],
                      )
                  ],
                ),
              ),
            ),
          );
  }
}
