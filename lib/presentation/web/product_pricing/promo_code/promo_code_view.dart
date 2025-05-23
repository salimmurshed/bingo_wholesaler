import 'package:bingo/app/web_route.dart';
import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/widgets_extensions.dart';
import 'package:bingo/presentation/web/product_pricing/promo_code/promo_code_view_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../../data_models/enums/user_type_for_web.dart';
import '../../../widgets/buttons/submit_button.dart';
import '../../../widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/utils.dart';
import '../../../../const/web_devices.dart';
import '../../../widgets/web_widgets/app_bars/nav_button.dart';
import '../../../widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import '../../../widgets/web_widgets/app_bars/web_app_bar.dart';
import '../../../widgets/web_widgets/body/pagination.dart';
import '../../../widgets/web_widgets/body/table.dart';
import '../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../widgets/web_widgets/with_tab_website_base_body.dart';
import '../product_navs.dart';

class PromoCodeView extends StatelessWidget {
  const PromoCodeView({super.key, this.page});

  final String? page;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PromoCodeViewModel>.reactive(
        viewModelBuilder: () => PromoCodeViewModel(),
        onViewModelReady: (PromoCodeViewModel model) {
          model.getPromoCode(page!);
        },
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
                          h1: AppLocalizations.of(context)!
                              .promoScreen_bodyText,
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
                              model.addNew(context);
                            },
                            text: AppLocalizations.of(context)!.addNew,
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
                                  h1: AppLocalizations.of(context)!
                                      .promoScreen_bodyText,
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
                                      model.addNew(context);
                                    },
                                    text: AppLocalizations.of(context)!.addNew,
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
                                                    120.0),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                3: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                4: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                5: const FixedColumnWidth(
                                                    100.0),
                                                6: const FixedColumnWidth(
                                                    150.0),
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
                                                              .table_sNo),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_promoCode),
                                                      dataCellHd(AppLocalizations
                                                              .of(context)!
                                                          .table_description
                                                          .toUpperCamelCase()),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_startDate),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_endDate),
                                                      dataCellHd(AppLocalizations
                                                              .of(context)!
                                                          .status
                                                          .toUpperCamelCase()),
                                                      dataCellHd(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .table_action),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model.promoCodeData
                                                            .length;
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
                                                          model.promoCodeData[i]
                                                              .promocode!,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: dataCell(
                                                          model.promoCodeData[i]
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
                                                          model.promoCodeData[i]
                                                              .startDate!,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: dataCell(
                                                          model.promoCodeData[i]
                                                              .endDate!,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 20),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: model
                                                                        .promoCodeData[
                                                                            i]
                                                                        .status ==
                                                                    1
                                                                ? AppColors
                                                                    .statusVerified
                                                                : AppColors
                                                                    .statusReject),
                                                        child: Center(
                                                          child: Text(
                                                            model.promoCodeData[i]
                                                                        .status ==
                                                                    1
                                                                ? "Active"
                                                                : "Inactive",
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .whiteColor),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        // width: 80,
                                                        child:
                                                            PopupMenuWithValue(
                                                                onTap: (int v) {
                                                                  if (v == 0) {
                                                                    model.editNew(
                                                                        context,
                                                                        model
                                                                            .promoCodeData[
                                                                                i]
                                                                            .uniqueId!,
                                                                        model.promoCodeData[
                                                                            i]);
                                                                  }
                                                                },
                                                                text: AppLocalizations.of(
                                                                        context)!
                                                                    .table_action,
                                                                color: AppColors
                                                                    .contextMenuTwo,
                                                                items: [
                                                              {
                                                                't': AppLocalizations.of(
                                                                        context)!
                                                                    .webActionButtons_edit,
                                                                'v': 0
                                                              },
                                                              {
                                                                't': AppLocalizations.of(
                                                                        context)!
                                                                    .webActionButtons_delete,
                                                                'v': 1
                                                              },
                                                              model
                                                                          .promoCodeData[
                                                                              i]
                                                                          .status ==
                                                                      0
                                                                  ? {
                                                                      't': AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_active,
                                                                      'v': 2
                                                                    }
                                                                  : {
                                                                      't': AppLocalizations.of(
                                                                              context)!
                                                                          .webActionButtons_inactive,
                                                                      'v': 2
                                                                    },
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                20.0.giveHeight,
                                if (model.totalPage > 0)
                                  model.isBusy
                                      ? const SizedBox()
                                      : PaginationWidget(
                                          totalPage: model.totalPage,
                                          perPage: 1,
                                          startTo: model.pageTo,
                                          startFrom: model.pageFrom,
                                          pageNumber: model.pageNumber,
                                          total: model.dataTotal,
                                          onPageChange: (int v) {
                                            model.changePage(context, v);
                                          })
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
