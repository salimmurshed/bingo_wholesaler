import 'package:bingo/const/all_const.dart';
import 'package:bingo/const/app_extensions/strings_extention.dart';
import 'package:bingo/data_models/enums/user_type_for_web.dart';
import 'package:bingo/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:bingo/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_network/image_network.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bingo/const/utils.dart';
import 'package:bingo/const/web_devices.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/secondaryNameAppBar.dart';
import 'package:bingo/presentation/widgets/web_widgets/app_bars/web_app_bar.dart';

import '../../../../const/server_status_file/server_status_file.dart';
import '../../../../data_models/construction_model/static_data_models/visit_frequent_list_model.dart';
import '../../../widgets/buttons/submit_button.dart';
import 'credit_line_request_details_view_model.dart';

class CreditLineRequestDetailsView extends StatelessWidget {
  const CreditLineRequestDetailsView(
      {super.key, this.id, this.data, this.enroll});

  final String? id;
  final String? data;
  final String? enroll;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreditLineRequestDetailsViewModel>.reactive(
        viewModelBuilder: () => CreditLineRequestDetailsViewModel(),
        onViewModelReady: (CreditLineRequestDetailsViewModel model) {
          model.prefill(id, data);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: device == ScreenSize.wide
                ? null
                : AppBar(
                    backgroundColor: model.enrollment == UserTypeForWeb.retailer
                        ? AppColors.bingoGreen
                        : AppColors.appBarColorWholesaler,
                    title: SecondaryNameAppBar(
                      h1: 'View Credit Line Request Information',
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
                              h1: 'View Credit Line Request Information',
                            ),
                          Container(
                            padding: EdgeInsets.all(
                                device != ScreenSize.wide ? 12.0 : 32.0),
                            color: Colors.white,
                            width: 100.0.wp,
                            child: model.isBusy
                                ? Utils.bigLoader()
                                : model.enrollment == UserTypeForWeb.wholesaler
                                    ? wholeSaler(model, context)
                                    : retailer(model, context),
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

  Column retailer(
      CreditLineRequestDetailsViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Credit Line Information",
              style: AppTextStyles.headerText,
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
                  model.goBack(context);
                },
                text: "View All Creditline Request",
              ),
            )
          ],
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Credit Line Information",
              style: AppTextStyles.headerText.copyWith(
                fontSize: AppFontSize.s18,
                fontWeight: AppFontWeighs.regular,
              ),
            ),
            SizedBox(
              width: 100.0.wp,
              child: Wrap(
                runSpacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: model.isEdit,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.wholesalerNameController,
                        fieldName: "Wholesaler Name"),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.fieController,
                        fieldName: "Financial Institution Name"),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.dateRequestedController,
                        fieldName: "Date Requested"),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: SelectedDropdown(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      isDisable: true,
                      fieldName: "Currency",
                      dropdownValue: model.selectedCurrency,
                      items: [
                        for (var i = 0; i < model.currencyList.length; i++)
                          DropdownMenuItem<String>(
                            value: model.currencyList[i],
                            child: Text(model.currencyList[i]),
                          )
                      ],
                      onChange: (v) {},
                    ),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.monthlyPurchaseController,
                        fieldName: "Monthly Purchase"),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.averagePurchaseController,
                        fieldName: "Average Purchase Ticket"),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: SelectedDropdown(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      isDisable: true,
                      fieldName: "Visit Frequency",
                      dropdownValue: model.selectedVisitFrequently,
                      items: [
                        for (var i = 0;
                            i < model.visitFrequentlyList.length;
                            i++)
                          DropdownMenuItem<VisitFrequentListModel>(
                            value: model.visitFrequentlyList[i],
                            child: Text(StatusFile.visitFrequent(
                                'en', model.visitFrequentlyList[i].id!)),
                          )
                      ],
                      onChange: (v) {},
                    ),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.requestedAmountController,
                        fieldName: "Requested Amount"),
                  ),
                  if (device != ScreenSize.small)
                    SizedBox(
                      width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    )
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
        SizedBox(
          width: 100.0.wp,
          child: Wrap(
            runSpacing: 20.0,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.spaceBetween,
            children: [
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 45.0.wp,
                child: NameTextField(
                    enable: false,
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                    style: AppTextStyles.formFieldTextStyle,
                    controller: model.crn1Controller,
                    fieldName: "Commercial Reference Name 1"),
              ),
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 45.0.wp,
                child: NameTextField(
                    enable: false,
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                    style: AppTextStyles.formFieldTextStyle,
                    controller: model.crp1Controller,
                    fieldName: "Commercial Reference Phone No 1"),
              ),
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 45.0.wp,
                child: NameTextField(
                    enable: false,
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                    style: AppTextStyles.formFieldTextStyle,
                    controller: model.crn2Controller,
                    fieldName: "Commercial Reference Name 2"),
              ),
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 45.0.wp,
                child: NameTextField(
                    enable: false,
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                    style: AppTextStyles.formFieldTextStyle,
                    controller: model.crp2Controller,
                    fieldName: "Commercial Reference Phone No 2"),
              ),
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 45.0.wp,
                child: NameTextField(
                    enable: false,
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                    style: AppTextStyles.formFieldTextStyle,
                    controller: model.crn3Controller,
                    fieldName: "Commercial Reference Name 3"),
              ),
              SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 45.0.wp,
                child: NameTextField(
                    enable: false,
                    hintStyle: AppTextStyles.formTitleTextStyleNormal,
                    style: AppTextStyles.formFieldTextStyle,
                    controller: model.crp3Controller,
                    fieldName: "Commercial Reference Phone No 3"),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            color: AppColors.dividerColor,
          ),
        ),
        SizedBox(
          width: 100.0.wp,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.0.wp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Retailer Completed Information",
                      style: AppTextStyles.headerText.copyWith(
                        fontSize: AppFontSize.s18,
                        fontWeight: AppFontWeighs.regular,
                      ),
                    ),
                    const Divider(
                      color: AppColors.dividerColor,
                    ),
                    DataTable(
                      decoration:
                          const BoxDecoration(color: AppColors.tableHeadColor),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'S.No.',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 200,
                            child: Text(
                              'Question',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 200,
                            child: Text(
                              'Answer',
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Text(
                              'Action',
                            ),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        for (int i = 0;
                            i <
                                model.retailerCreditLineReqDetails.data!
                                    .fieQuestionAnswer!.length;
                            i++)
                          DataRow(
                            color: MaterialStateProperty.resolveWith((states) {
                              // If the button is pressed, return green, otherwise blue
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.red;
                              }
                              return AppColors.whiteColor;
                            }),
                            cells: <DataCell>[
                              DataCell(Text("${i + 1}")),
                              DataCell(Text(model.retailerCreditLineReqDetails
                                  .data!.fieQuestionAnswer![i].question!)),
                              DataCell(Text(model.retailerCreditLineReqDetails
                                  .data!.fieQuestionAnswer![i].answer!)),
                              DataCell(
                                FittedBox(
                                  child: Material(
                                    color: Colors.white,
                                    child: PopupMenuButton<int>(
                                        color: Colors.white,
                                        splashRadius: 20.0,
                                        offset: const Offset(0, 40),
                                        onSelected: (int v) {
                                          model.openQuestion(
                                              model
                                                  .retailerCreditLineReqDetails
                                                  .data!
                                                  .fieQuestionAnswer![i]
                                                  .question!,
                                              model
                                                  .retailerCreditLineReqDetails
                                                  .data!
                                                  .fieQuestionAnswer![i]
                                                  .answer!,
                                              model.retailerCreditLineReqDetails
                                                  .data!.supportedDocuments!);
                                        },
                                        elevation: 8.0,
                                        tooltip: "",
                                        itemBuilder: (BuildContext context) {
                                          return [
                                            PopupMenuItem<int>(
                                              height: 30,
                                              value: 0,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .view,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.ashColor,
                                                ),
                                              ),
                                            ),
                                          ];
                                        },
                                        child: Card(
                                          color: AppColors.contextMenuTwo,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 2.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .actions,
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.whiteColor),
                                                ),
                                                const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: AppColors.whiteColor)
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "View Supported Documents",
                      style: AppTextStyles.headerText.copyWith(
                        fontSize: AppFontSize.s18,
                        fontWeight: AppFontWeighs.regular,
                      ),
                    ),
                    const Divider(
                      color: AppColors.dividerColor,
                    ),
                    Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        for (int i = 0;
                            // i < 10;
                            i <
                                model.retailerCreditLineReqDetails.data!
                                    .supportedDocuments!.length;
                            i++)
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ImageNetwork(
                              onTap: () {
                                model.openImage(model
                                    .retailerCreditLineReqDetails
                                    .data!
                                    .supportedDocuments![i]
                                    .retailerDocument!);
                              },
                              image: model.retailerCreditLineReqDetails.data!
                                  .supportedDocuments![i].retailerDocument!,
                              height: 100,
                              width: 100,
                            ),
                          )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column wholeSaler(
      CreditLineRequestDetailsViewModel model, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Credit Line Information",
              style: AppTextStyles.headerText,
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
                  model.goBack(context);
                },
                text: "View All Creditline Request",
              ),
            )
          ],
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Credit Line Information",
              style: AppTextStyles.headerText.copyWith(
                fontSize: AppFontSize.s18,
                fontWeight: AppFontWeighs.regular,
              ),
            ),
            SizedBox(
              width: 100.0.wp,
              child: Wrap(
                runSpacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: GestureDetector(
                      onTap: () {
                        model.openCalender();
                      },
                      child: AbsorbPointer(
                        child: NameTextField(
                            hintStyle: AppTextStyles.formTitleTextStyleNormal,
                            style: AppTextStyles.formFieldTextStyle,
                            controller: model.customerSinceController,
                            fieldName: "Customer Since Date".isRequired),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        isFloat: true,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.monthlySaleController,
                        fieldName: "Monthly Sales".isRequired),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        isFloat: true,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.averageSaleTicketController,
                        fieldName: "Average Sales Ticket".isRequired),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: SelectedDropdown(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      fieldName: "Visit Frequency",
                      dropdownValue: model.selectedVisitFrequently,
                      items: [
                        for (var i = 0;
                            i < model.visitFrequentlyList.length;
                            i++)
                          DropdownMenuItem<VisitFrequentListModel>(
                            value: model.visitFrequentlyList[i],
                            child: Text(StatusFile.visitFrequent(
                                'en', model.visitFrequentlyList[i].id!)),
                          )
                      ],
                      onChange: (v) {},
                    ),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        isFloat: true,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.rcCreditLineAmountController,
                        fieldName: "Recommended Credit Line Amount".isRequired),
                  ),
                  if (device != ScreenSize.small)
                    SizedBox(
                      width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    )
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Retailer Completed Infomation",
              style: AppTextStyles.headerText.copyWith(
                fontSize: AppFontSize.s18,
                fontWeight: AppFontWeighs.regular,
              ),
            ),
            SizedBox(
              width: 100.0.wp,
              child: Wrap(
                runSpacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: SelectedDropdown(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      isDisable: true,
                      fieldName: "Select Currency",
                      dropdownValue: model.selectedCurrency,
                      items: [
                        for (var i = 0; i < model.currencyList.length; i++)
                          DropdownMenuItem<String>(
                            value: model.currencyList[i],
                            child: Text(model.currencyList[i]),
                          )
                      ],
                      onChange: (v) {},
                    ),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.monthlyPurchaseController,
                        fieldName: "Monthly Purchase".isRequired),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.averagePurchaseController,
                        fieldName: "Average Purchase Ticket".isRequired),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: NameTextField(
                        enable: false,
                        hintStyle: AppTextStyles.formTitleTextStyleNormal,
                        style: AppTextStyles.formFieldTextStyle,
                        controller: model.requestedAmountController,
                        fieldName: "Requested Amount".isRequired),
                  ),
                  SizedBox(
                    width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    child: SelectedDropdown(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      isDisable: true,
                      dropdownValue: model.selectedVisitFrequently,
                      fieldName: "Visit Frequency",
                      items: [
                        for (var i = 0;
                            i < model.visitFrequentlyList.length;
                            i++)
                          DropdownMenuItem<VisitFrequentListModel>(
                            value: model.visitFrequentlyList[i],
                            child: Text(StatusFile.visitFrequent(
                                'en', model.visitFrequentlyList[i].id!)),
                          )
                      ],
                      onChange: (v) {},
                    ),
                  ),
                  if (device != ScreenSize.small)
                    SizedBox(
                      width: device == ScreenSize.small ? 80.0.wp : 30.0.wp,
                    )
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: AppColors.dividerColor,
        ),
        20.0.giveHeight,
        model.isButtonBusy
            ? SizedBox(
                width: device == ScreenSize.small ? 80.0.wp : 150,
                height: 45,
                child: Center(
                  child: Utils.loaderBusy(),
                ),
              )
            : SubmitButton(
                isRadius: false,
                text: AppLocalizations.of(context)!.submitButton,
                onPressed: () {
                  // model.addEditUser(context);
                },
                width: device == ScreenSize.small ? 80.0.wp : 150,
                height: 45,
              )
      ],
    );
  }
}
