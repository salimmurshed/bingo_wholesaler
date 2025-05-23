import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../product_navs.dart';
import 'summury_view_model.dart';

class ProductSummaryView extends StatelessWidget {
  const ProductSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductSummaryViewModel>.reactive(
        viewModelBuilder: () => ProductSummaryViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'Product Summary',
                    ),
                  ),
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (device != ScreenSize.small)
                      WebAppBar(
                          onTap: (String v) {
                            model.changeTab(context, v);
                          },
                          tabNumber: model.tabNumber),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (device != ScreenSize.small)
                            SecondaryNameAppBar(
                              h1: 'Product Summary',
                            ),
                          WithTabWebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      model.isBusy
                                          ? Utils.bigLoader()
                                          : Scrollbar(
                                              controller:
                                                  model.scrollController,
                                              thickness: 10,
                                              child: SingleChildScrollView(
                                                controller:
                                                    model.scrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: SizedBox(
                                                  width:
                                                      device != ScreenSize.wide
                                                          ? null
                                                          : 100.0.wp - 64 - 64,
                                                  child: Table(
                                                    defaultVerticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    border: TableBorder.all(
                                                        color: AppColors
                                                            .tableHeaderBody),
                                                    columnWidths: {
                                                      0: const FixedColumnWidth(
                                                          70.0),
                                                      1: const FixedColumnWidth(
                                                          150.0),
                                                      2: device !=
                                                              ScreenSize.wide
                                                          ? const FixedColumnWidth(
                                                              150.0)
                                                          : const FlexColumnWidth(),
                                                      3: const FixedColumnWidth(
                                                          150.0),
                                                      4: const FixedColumnWidth(
                                                          150.0),
                                                      for (int i = 0;
                                                          i <
                                                              model
                                                                  .pricingGroups
                                                                  .length;
                                                          i++)
                                                        5 + i:
                                                            const FixedColumnWidth(
                                                                130.0)
                                                    },
                                                    children: [
                                                      TableRow(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: AppColors
                                                                .tableHeaderColor,
                                                          ),
                                                          children: [
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .sNo,
                                                            ),
                                                            dataCellHd(
                                                              "SKU ID",
                                                            ),
                                                            dataCellHd(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .table_description,
                                                            ),
                                                            dataCellHd(
                                                                "Category"),
                                                            dataCellHd(
                                                              "Unit",
                                                            ),
                                                            for (int i = 0;
                                                                i <
                                                                    model
                                                                        .pricingGroups
                                                                        .length;
                                                                i++)
                                                              dataCellHd(
                                                                model.pricingGroups[
                                                                    i],
                                                              ),
                                                          ]),
                                                      for (int j = 0;
                                                          j <
                                                              model.summaryList
                                                                  .length;
                                                          j++)
                                                        TableRow(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Utils
                                                                .tableBorder,
                                                            color: AppColors
                                                                .whiteColor,
                                                          ),
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                "${1 + j}",
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                model
                                                                    .summaryList[
                                                                        j]
                                                                    .skuId!,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                model
                                                                    .summaryList[
                                                                        j]
                                                                    .pricing![0]
                                                                    .description!,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                model
                                                                    .summaryList[
                                                                        j]
                                                                    .pricing![0]
                                                                    .category!,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: dataCell(
                                                                model
                                                                    .summaryList[
                                                                        j]
                                                                    .pricing![0]
                                                                    .unit!,
                                                              ),
                                                            ),
                                                            for (int i = 0;
                                                                i <
                                                                    model
                                                                        .pricingGroups
                                                                        .length;
                                                                i++)
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                                child: dataCell(
                                                                  model.summaryList[j].pricing![0].pricingGroupId ==
                                                                          model.pricingGroups[
                                                                              i]
                                                                      ? model
                                                                          .summaryList[
                                                                              j]
                                                                          .pricing![
                                                                              0]
                                                                          .unitPrice!
                                                                          .toString()
                                                                      : "-",
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                            child: Flex(
                              direction: device == ScreenSize.wide
                                  ? Axis.horizontal
                                  : Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const ProductNavs(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .search),
                                      ),
                                      10.0.giveWidth,
                                      SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: NameTextField(
                                            hintStyle: AppTextStyles
                                                .formTitleTextStyleNormal,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
