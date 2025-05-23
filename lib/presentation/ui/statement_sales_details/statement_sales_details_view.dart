import 'package:stacked/stacked.dart';

import '../../../const/app_sizes/app_sizes.dart';
import '../../widgets/buttons/submit_button.dart';
import '../../widgets/cards/loader/loader.dart';
import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/retailer_sale_financial_statements/retailer_sale_financial_statements.dart';
import '../../widgets/cards/app_bar_text.dart';
import '../../widgets/cards/shadow_card.dart';
import 'statement_sales_details_view_model.dart';

class StatementSalesDetails extends StatelessWidget {
  const StatementSalesDetails({
    // required this.data,
    // required this.language,
    // required this.invoice,
    Key? key,
  }) : super(key: key);
  // List<RetailerSaleFinancialStatementsData> data;
  // String language;
  // String invoice;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StatementSalesDetailsModel>.reactive(
        onViewModelReady: (StatementSalesDetailsModel model) {
          model.setId(ModalRoute.of(context)!.settings.arguments
              as StatementListToDetailsArguments);
        },
        viewModelBuilder: () => StatementSalesDetailsModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appBarColorRetailer,
              title: AppBarText(model.invoice),
            ),
            body: model.isBusy
                ? SizedBox(
                    width: 100.0.wp,
                    height: 100.0.hp,
                    child: const Center(
                      child: LoaderWidget(),
                    ),
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  16.0,
                                  20,
                                  16.0,
                                  model.allData[0].canStartPayment!
                                      ? 80.0
                                      : 20),
                              child: Column(
                                children: model.allData
                                    .map((e) => ShadowCard(
                                          padding: 0.1,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.documentType}${e.documentType}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.contractAccount}${model.contractAccount(e.contractAccount!)}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.dueDate}:${e.dueDate}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.invoice}${e.invoice}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.amounT}${e.amount}",
                                                          nxtln: true),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.documentId} "
                                                          "${e.documentId!.lastChars(10)}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.dateGenerated}${e.dateGenerated}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .statuS),
                                                      e.status!.toStatusTransaction(
                                                          value: StatusFile
                                                              .statusForFinState(
                                                                  model
                                                                      .language,
                                                                  e.status!,
                                                                  e
                                                                      .statusDescription!),
                                                          treansactionScreen:
                                                              true),
                                                      //toStatusFinStat()
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.currencY}${e.currency}",
                                                          nxtln: true),
                                                      10.0.giveHeight,
                                                      Utils.getNiceText(
                                                          "${AppLocalizations.of(context)!.openBalance}${e.openBalance}",
                                                          nxtln: true),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            if (model.hasNextPage)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: SizedBox(
                                  height: 60.0,
                                  child: model.isLoaderBusy
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Utils.loaderBusy(),
                                        )
                                      : Center(
                                          child: Utils.loadMore(
                                              model.getSalesFinancialStatement),
                                        ),
                                ),
                              )
                          ],
                        ),
                      ),
                      if (model.allData[0].canStartPayment!)
                        Positioned(
                          bottom: 10,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColors.whiteColor),
                            width: 100.0.wp,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 200,
                                height: 40,
                                child: model.busy(model.saleId)
                                    ? Utils.loaderBusy()
                                    : SubmitButton(
                                        isRadius: false,
                                        onPressed: () {
                                          model.createPayment(
                                              context, model.saleId);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .startPayment,
                                      ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          );
        });
  }
}
