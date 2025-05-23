import '/const/all_const.dart';
import '/const/app_extensions/status.dart';
import '/const/app_extensions/strings_extention.dart';
import '/presentation/widgets/cards/app_bar_text.dart';
import '/presentation/widgets/cards/shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../const/server_status_file/server_status_file.dart';
import '../../../const/utils.dart';
import '../../../data_models/models/all_sales_model/all_sales_model.dart';

class StatementCard extends StatelessWidget {
  const StatementCard(this.allTransaction, this.language, this.invoiceNumber,
      {Key? key})
      : super(key: key);
  final List<TranctionDetails> allTransaction;
  final String language;
  final String invoiceNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColorRetailer,
        title: AppBarText(invoiceNumber),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.0.giveHeight,
            for (int i = 0; i < allTransaction.length; i++)
              ShadowCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40.0.wp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.saleId}${allTransaction[i].saleUniqueId!.lastChars(10)}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.documentType}${allTransaction[i].documentType}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.collectionLott}:${allTransaction[i].collectionLotId}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.invoice}${allTransaction[i].invoice}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.amount}:${allTransaction[i].amount}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.appliedAmount}${allTransaction[i].appliedAmount}",
                              nxtln: true),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40.0.wp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.documentId} "
                              "${allTransaction[i].documentId!.lastChars(10)}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.storeName}:${allTransaction[i].storeName}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              AppLocalizations.of(context)!.statuS),
                          allTransaction[i].status!.toStatusTransaction(
                              value: StatusFile.statusForFinState(
                                  language,
                                  allTransaction[i].status!,
                                  allTransaction[i].statusDescription!),
                              treansactionScreen: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.retailerName}:${allTransaction[i].retailerName}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.currency}:${allTransaction[i].currency}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.openBalance}${allTransaction[i].openBalance}",
                              nxtln: true),
                          10.0.giveHeight,
                          Utils.getNiceText(
                              "${AppLocalizations.of(context)!.postingDate}${allTransaction[i].postingDate}",
                              nxtln: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            35.0.giveHeight,
          ],
        ),
      ),
    );
  }
}
