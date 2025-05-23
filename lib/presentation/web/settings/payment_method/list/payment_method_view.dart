import 'package:bingo/const/all_const.dart';
import 'package:bingo/presentation/web/settings/payment_method/list/payment_method_view_model.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../../data_models/enums/user_type_for_web.dart';
import '../../../../widgets/buttons/submit_button.dart';
import '../../../../widgets/web_widgets/body/table.dart';
import '../../../../widgets/web_widgets/cards/popup_menu_with_value.dart';
import '../../../../widgets/web_widgets/website_base_body.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentMethodViewModel>.reactive(
        viewModelBuilder: () => PaymentMethodViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            drawer: WebAppBar(
                onTap: (String v) {
                  model.changeTab(context, v);
                },
                tabNumber: model.tabNumber),
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: Row(
                      children: [
                        SecondaryNameAppBar(
                          h1: 'Order Payment Method',
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
                              model.gotoDetails(2, context);
                            },
                            text: AppLocalizations.of(context)!.addNew,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                  h1: 'Order Payment Method',
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
                                      model.gotoDetails(2, context);
                                    },
                                    text: AppLocalizations.of(context)!.addNew,
                                  ),
                                ),
                              ],
                            ),
                          WebsiteBaseBody(
                            body: model.isBusy
                                ? Utils.bigLoader()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flex(
                                        direction: device == ScreenSize.wide
                                            ? Axis.horizontal
                                            : Axis.vertical,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Order Payment Method',
                                            style: AppTextStyles.headerText,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .search),
                                              ),
                                              10.0.giveWidth,
                                              SizedBox(
                                                  width: 100,
                                                  height: 50,
                                                  child: NameTextField(
                                                    hintStyle: AppTextStyles
                                                        .formTitleTextStyleNormal,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      Scrollbar(
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
                                                0: const FixedColumnWidth(
                                                    100.0),
                                                1: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
                                                2: device != ScreenSize.wide
                                                    ? const FixedColumnWidth(
                                                        150.0)
                                                    : const FlexColumnWidth(),
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
                                                        "Payment Method",
                                                      ),
                                                      dataCellHd(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .table_action,
                                                      ),
                                                    ]),
                                                for (int i = 0;
                                                    i <
                                                        model
                                                            .paymentMethodsModel
                                                            .data!
                                                            .length;
                                                    i++)
                                                  TableRow(
                                                    decoration: BoxDecoration(
                                                      border: Utils.tableBorder,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    children: [
                                                      dataCell(
                                                        "${1 + i}",
                                                      ),
                                                      dataCell(
                                                          model
                                                              .paymentMethodsModel
                                                              .data![i]
                                                              .paymentMethod!,
                                                          isCenter: false),
                                                      Center(
                                                        child:
                                                            PopupMenuWithValue(
                                                          onTap: (int v) {
                                                            model.gotoDetails(
                                                                v, context,
                                                                id: model
                                                                    .paymentMethodsModel
                                                                    .data![i]
                                                                    .uniqueId!
                                                                    .toString(),
                                                                title: model
                                                                    .paymentMethodsModel
                                                                    .data![i]
                                                                    .paymentMethod!);
                                                          },
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .table_action,
                                                          color: AppColors
                                                              .contextMenuTwo,
                                                          items: [
                                                            {
                                                              "t": AppLocalizations
                                                                      .of(context)!
                                                                  .webActionButtons_edit,
                                                              "v": 0
                                                            },
                                                            {
                                                              "t": AppLocalizations
                                                                      .of(context)!
                                                                  .webActionButtons_delete,
                                                              "v": 1
                                                            },
                                                          ],
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
