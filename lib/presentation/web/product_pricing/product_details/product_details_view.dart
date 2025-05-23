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
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../product_navs.dart';
import 'product_details_view_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailsViewModel>.reactive(
        viewModelBuilder: () => ProductDetailsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        SecondaryNameAppBar(
                          h1: 'Product Details',
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: SubmitButton(
                            color: AppColors.bingoGreen,
                            isRadius: false,
                            height: 40,
                            width: 80,
                            onPressed: () {
                              // Navigator.pop(context);
                              // model.addNew(context);
                            },
                            text:
                                "${AppLocalizations.of(context)!.addNew}${device == ScreenSize.small ? '\n' : ' '}(Upload Massive)",
                          ),
                        ),
                      ],
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
                            Row(
                              children: [
                                SecondaryNameAppBar(
                                  h1: 'Product Details',
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SubmitButton(
                                    color: AppColors.bingoGreen,
                                    isRadius: false,
                                    height: 40,
                                    width: 80,
                                    onPressed: () {
                                      // Navigator.pop(context);
                                      // model.addNew(context);
                                    },
                                    text:
                                        "${AppLocalizations.of(context)!.addNew} (Upload Massive)",
                                  ),
                                ),
                              ],
                            ),
                          WithTabWebsiteBaseBody(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                model.isBusy
                                    ? Utils.bigLoader()
                                    : Scrollbar(
                                        controller: model.scrollController,
                                        thickness: 10,
                                        child: SingleChildScrollView(
                                          controller: model.scrollController,
                                          scrollDirection: Axis.horizontal,
                                          child: SizedBox(
                                            width: device != ScreenSize.wide
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
                                                0: const FixedColumnWidth(70.0),
                                                1: const FixedColumnWidth(
                                                    100.0),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                3: const FixedColumnWidth(
                                                    130.0),
                                                4: const FixedColumnWidth(
                                                    100.0),
                                                5: const FixedColumnWidth(
                                                    100.0),
                                                6: const FixedColumnWidth(
                                                    100.0),
                                                7: const FixedColumnWidth(
                                                    100.0),
                                                8: const FixedColumnWidth(
                                                    100.0),
                                                9: const FixedColumnWidth(
                                                    100.0),
                                                10: const FixedColumnWidth(
                                                    100.0),
                                                11: const FixedColumnWidth(
                                                    120.0),
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
                                                      dataCellHd("Category"),
                                                      dataCellHd(
                                                        "Unit",
                                                      ),
                                                      dataCellHd(
                                                        "Pricing Group ID",
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_currency,
                                                      ),
                                                      dataCellHd(
                                                        "Unit Price",
                                                      ),
                                                      dataCellHd("Tax (%)"),
                                                      dataCellHd(
                                                        "Date Updated",
                                                      ),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_status),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_action,
                                                      ),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model
                                                            .productList.length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: dataCell(
                                                          "${1 + i}",
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: dataCell(
                                                          model.productList[i]
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
                                                              .productList[i]
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
                                                              .productList[i]
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
                                                              .productList[i]
                                                              .pricing![0]
                                                              .unit!,
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
                                                              .productList[i]
                                                              .pricing![0]
                                                              .pricingGroupId!,
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
                                                              .productList[i]
                                                              .pricing![0]
                                                              .currency!,
                                                        ),
                                                      ),
                                                      dataCell(
                                                        model.productList[i]
                                                            .pricing![0].unit!,
                                                      ),
                                                      dataCell(
                                                        (model
                                                                    .productList[
                                                                        i]
                                                                    .pricing![0]
                                                                    .tax ??
                                                                0)
                                                            .toString(),
                                                      ),
                                                      dataCell(
                                                        "-",
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              color: (model
                                                                              .productList[
                                                                                  i]
                                                                              .pricing![
                                                                                  0]
                                                                              .status ??
                                                                          0) ==
                                                                      0
                                                                  ? AppColors
                                                                      .redColor
                                                                  : AppColors
                                                                      .darkGreenColor,
                                                            ),
                                                            child: Text(
                                                              (model.productList[i].pricing![0]
                                                                              .status ??
                                                                          0) ==
                                                                      0
                                                                  ? "Inactive"
                                                                  : "Active",
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .whiteColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: FittedBox(
                                                          // width: 80,
                                                          child: PopupMenuWithValue(
                                                              onTap: (int v) {},
                                                              text: AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .table_action,
                                                              color: AppColors
                                                                  .contextMenuTwo,
                                                              items: []),
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
