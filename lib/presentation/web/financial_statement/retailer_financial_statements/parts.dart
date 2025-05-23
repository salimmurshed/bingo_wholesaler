part of 'financial_statements_view.dart';

mainHeader(BuildContext context, UserTypeForWeb enrollment,
    {bool withDetails = true,
    bool isDetailsScreen = true,
    bool withSelection = true}) {
  return TableRow(
    decoration: const BoxDecoration(
      color: AppColors.tableHeaderColor,
    ),
    children: [
      if (enrollment == UserTypeForWeb.retailer)
        if (withSelection) SizedBox(),

      dataCellHd(AppLocalizations.of(context)!.table_srNO, padding: 2),
      dataCellHd(AppLocalizations.of(context)!.invoice, padding: 2),
      dataCellHd(AppLocalizations.of(context)!.saleId, padding: 2),
      if (isDetailsScreen)
        dataCellHd(AppLocalizations.of(context)!.documentType, padding: 2),
      if (isDetailsScreen)
        dataCellHd(AppLocalizations.of(context)!.documentId, padding: 2),
      dataCellHd(AppLocalizations.of(context)!.contractAccount, padding: 2),
      dataCellHd(AppLocalizations.of(context)!.dateGenerated, padding: 2),
      dataCellHd("commercial credit's due date", padding: 2),
      dataCellHd("Due Date", padding: 2, isCenter: true),
      // dataCellHd("Due Date To", padding: 2),
      dataCellHd("Remaining Days", padding: 2),
      dataCellHd(AppLocalizations.of(context)!.currency, padding: 2),
      dataCellHd(isDetailsScreen ? "Amount" : "Invoice Amount", padding: 2),
      if (!isDetailsScreen) dataCellHd("Financial Charges", padding: 2),
      dataCellHd(AppLocalizations.of(context)!.openBalance, padding: 2),
      dataCellHd(AppLocalizations.of(context)!.status, padding: 2),
      if (withDetails)
        dataCellHd(AppLocalizations.of(context)!.action, padding: 2),
    ],
  );
}

TableRow subgroupMetadata(Subgroups rFinStat, model,
    {required bool isRetailer}) {
  return TableRow(
      decoration: const BoxDecoration(
        color: AppColors.webBackgroundColor,
      ),
      children: [
        Table(
          border: TableBorder.all(color: AppColors.whiteColor),
          columnWidths:
              isRetailer ? widthsForHeaderRetailer : widthsForHeaderWholesaler,
          children: [
            TableRow(
              children: [
                dataCellInMiddle((rFinStat.subgroupMetadata!.groupTitle!),
                    isCenter: true, style: AppTextStyles.webTableHeader),
                SizedBox(),
                SizedBox(),
                dataCellInMiddle(
                    (rFinStat.subgroupMetadata!.totalInvoiceAmount!),
                    isCenter: true,
                    style: AppTextStyles.webTableHeader),
                dataCellInMiddle(
                    (rFinStat.subgroupMetadata!.totalFinancialCharge!),
                    isCenter: true,
                    style: AppTextStyles.webTableHeader),
                dataCellInMiddle((rFinStat.subgroupMetadata!.totalOpenBalance!),
                    isCenter: true, style: AppTextStyles.webTableHeader),
                SizedBox(),
                SizedBox(),
              ],
            ),
          ],
        ),
      ]);
}

TableRow bodyRows(
  SubgroupData subgroupData,
  int itemNUmber,
  List<SubgroupData> startPaymentList,
  UserTypeForWeb enrollment, {
  bool isDetailsScreen = true,
  final Function()? onPressed,
  Function()? addForStartPayment,
  bool withDetails = true,
  bool withSelection = true,
  AutoSizeGroup? group,
}) {
  var existingItem = startPaymentList
      .any((itemToCheck) => itemToCheck.documentId == subgroupData.documentId);
  return TableRow(
    decoration: BoxDecoration(
      color: true ? AppColors.whiteColor : AppColors.tableHeaderBody,
    ),
    children: [
      if (enrollment == UserTypeForWeb.retailer)
        if (withSelection)
          subgroupData.canStartPayment!
              ? TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: InkWell(
                    onTap: addForStartPayment,
                    child: Center(
                      child: CheckedBox(
                        check: existingItem,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
      dataCellInMiddle(
        itemNUmber.toString(),
      ),
      dataCellInMiddle(
        subgroupData.invoice!,
      ),
      dataCellInMiddle(
        subgroupData.saleUniqueId!.lastChars(10),
      ),
      if (isDetailsScreen)
        dataCellInMiddle(
          subgroupData.documentType!,
        ),
      if (isDetailsScreen)
        dataCellInMiddle(
          subgroupData.documentId!.lastChars(10),
        ),
      dataCellInMiddle(
        Utils.contractAccount(subgroupData.contractAccount!),
      ),
      dataCellInMiddle(
        subgroupData.dateGenerated!, //date_generated
      ),
      dataCellInMiddle(
        subgroupData.paymentDate!,
      ),
      dataCellInMiddle(
        subgroupData.dueDateFrom!,
      ),
      // dataCellInMiddle(
      //   subgroupData.dueDateTo!,
      // ),
      dataCellInMiddle(
        subgroupData.remainingDays!.toString(),
      ),
      dataCellInMiddle(
        subgroupData.currency!,
      ),
      if (!isDetailsScreen)
        dataCellInMiddle(
          subgroupData.totalInvoiceAmount!.toString(),
        ),
      if (isDetailsScreen)
        dataCellInMiddle(
          subgroupData.documentType!.toLowerCase() == "sale"
              ? subgroupData.invoiceAmount!.toString()
              : subgroupData.financialCharge!.toString(),
        ),
      if (!isDetailsScreen)
        dataCellInMiddle(
          subgroupData.totalFinancialCharge!.toString(),
        ),
      dataCellInMiddle(
        subgroupData.openBalance!,
      ),
      statusBtn(
          statusDescription: subgroupData.statusDescription!,
          status: subgroupData.status!,
          group: group),
      if (withDetails)
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: Center(
              child: SubmitButton(
                  textPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  isPadZero: true,
                  color: AppColors.bingoGreen,
                  // width: 100,
                  onPressed: () {
                    onPressed!();
                  },
                  text: "Details",
                  isRadius: false),
            ),
          ),
        )
    ],
  );
}

TableRow bodyRowsForDetailsScreen(
  FinancialStatementsDetails subgroupData,
  int itemNUmber,
  List<FinancialStatementsDetails> startPaymentList,
  UserTypeForWeb enrollment, {
  bool isDetailsScreen = true,
  final Function()? onPressed,
  Function()? addForStartPayment,
  bool withDetails = true,
  bool withSelection = true,
  AutoSizeGroup? group,
}) {
  var existingItem = startPaymentList
      .any((itemToCheck) => itemToCheck.documentId == subgroupData.documentId);
  return TableRow(
    decoration: BoxDecoration(
      color: true ? AppColors.whiteColor : AppColors.tableHeaderBody,
    ),
    children: [
      if (enrollment == UserTypeForWeb.retailer)
        if (withSelection)
          subgroupData.canStartPayment!
              ? TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: InkWell(
                    onTap: addForStartPayment,
                    child: Center(
                      child: CheckedBox(
                        check: existingItem,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
      dataCellInMiddle(
        itemNUmber.toString(),
      ),
      dataCellInMiddle(
        subgroupData.invoice!,
      ),
      dataCellInMiddle(
        subgroupData.saleUniqueId!.lastChars(10),
      ),
      dataCellInMiddle(
        subgroupData.documentType!,
      ),
      dataCellInMiddle(
        subgroupData.documentId!.lastChars(10),
      ),
      dataCellInMiddle(
        Utils.contractAccount(subgroupData.contractAccount!),
      ),
      dataCellInMiddle(
        subgroupData.dateGenerated!, //date_generated
      ),
      dataCellInMiddle(
        subgroupData.paymentDate!,
      ),
      dataCellInMiddle(
        subgroupData.dueDateFrom!,
      ),
      // dataCellInMiddle(
      //   subgroupData.dueDateTo!,
      // ),
      dataCellInMiddle(
        subgroupData.remainingDays!.toString(),
      ),
      dataCellInMiddle(
        subgroupData.currency!,
      ),

      dataCellInMiddle(
        subgroupData.amount!.toString(),
      ),

      dataCellInMiddle(
        subgroupData.openBalance!,
      ),
      statusBtn(
          statusDescription: subgroupData.statusDescription!,
          status: subgroupData.status!,
          group: group),
      if (withDetails)
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: Center(
              child: SubmitButton(
                  textPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  isPadZero: true,
                  color: AppColors.bingoGreen,
                  // width: 100,
                  onPressed: () {
                    onPressed!();
                  },
                  text: "Details",
                  isRadius: false),
            ),
          ),
        )
    ],
  );
}

Widget statusBtn({
  String statusDescription = "",
  int status = 0,
  AutoSizeGroup? group,
}) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: status.toStatusFinStatWeb(),
          borderRadius: BorderRadius.circular(3),
        ),
        child: AutoSizeText(
          group: group,
          statusDescription,
          maxLines: 1,
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

SizedBox sortedGrandTotalBox(
    BuildContext context, RetailerFinancialStatementViewModel model) {
  return SizedBox(
    width: 100.0.wp,
    child: Flex(
      direction: MediaQuery.of(context).size.width > 850
          ? Axis.horizontal
          : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flex(
          direction:
              device == ScreenSize.small ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: Text(
                'View ${model.enrollment == UserTypeForWeb.retailer ? "Retailer" : "Wholesaler"} Financial Statements List',
                style: AppTextStyles.headerText,
              ),
            ),
            10.0.giveWidth,
            Text(
              'Grand Total = ${model.grandTotalFinancialStatements}',
              style: AppTextStyles.headerText,
            ),
          ],
        ),
        SizedBox(
          height: device == ScreenSize.small ? null : 70,
          child: Flex(
            direction:
                device == ScreenSize.small ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: device == ScreenSize.medium
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              if (device == ScreenSize.small) 10.0.giveHeight,
              SizedBox(
                  height: 55,
                  width: device == ScreenSize.small ? 80.0.wp : null,
                  child: SubmitButton(
                    height: 45,
                    width: device == ScreenSize.small ? 80.0.wp : 120.0,
                    color: AppColors.redColor,
                    onPressed: model.clear,
                    isRadius: false,
                    text: "Clear",
                  )

                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.red, // Background color
                  //     ),
                  //     onPressed: model.clear,
                  //     child: const Text(
                  //       "CLEAR",
                  //       style: AppTextStyles.webBtnTxtStyle,
                  //     )),
                  ),
              if (device != ScreenSize.small) 10.0.giveWidth,
              if (device == ScreenSize.small) 10.0.giveHeight,
              SizedBox(
                height: 70,
                width: device == ScreenSize.small ? 80.0.wp : 200,
                child: GestureDetector(
                  onTap: () {
                    model.openDateTime(context, model.dateFromController);
                  },
                  child: AbsorbPointer(
                    child: NameTextField(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      controller: model.dateFromController,
                      enable: true,
                      hintText: DateFormat(SpecialKeys.dateFormatYDM)
                          .format(DateTime.now())
                          .toString(),
                      fieldName: "From Date",
                    ),
                  ),
                ),
              ),
              if (device != ScreenSize.small) 10.0.giveWidth,
              if (device == ScreenSize.small) 10.0.giveHeight,
              SizedBox(
                height: 70,
                width: device == ScreenSize.small ? 80.0.wp : 200,
                child: GestureDetector(
                  onTap: () {
                    model.openDateTime(context, model.dateToController);
                  },
                  child: AbsorbPointer(
                    child: NameTextField(
                      hintStyle: AppTextStyles.formTitleTextStyleNormal,
                      controller: model.dateToController,
                      enable: true,
                      hintText: DateFormat(SpecialKeys.dateFormatYDM)
                          .format(DateTime.now())
                          .toString(),
                      fieldName: "To Date",
                    ),
                  ),
                ),
              ),
              if (device != ScreenSize.small) 10.0.giveWidth,
              if (device == ScreenSize.small) 10.0.giveHeight,
              SizedBox(
                height: 55,
                width: device == ScreenSize.small ? 80.0.wp : 120.0,
                child: SubmitButton(
                  color: AppColors.bingoGreen,
                  onPressed: () {
                    model.filterSearch(context, 1);
                  },
                  isRadius: false,
                  text: "Submit",
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget checkBox(GestureTapCallback addForStartPayment, bool contains) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: GestureDetector(
      onTap: () {
        addForStartPayment();
      },
      child: CheckedBox(
        check: contains,
      ),
    ),
  );
}

Padding body(
  RetailerFinancialStatementViewModel model,
  context,
  String? page,
  String? from,
  String? to,
) {
  return Padding(
    padding: EdgeInsets.all(device != ScreenSize.wide ? 0.0 : 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WebAppBar(
            onTap: (String v) {
              model.changeTab(context, v);
            },
            tabNumber: model.tabNumber),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondaryNameAppBar(
                h1: AppLocalizations.of(context)!.finScreen_header,
              ),
              Container(
                padding:
                    EdgeInsets.all(device != ScreenSize.wide ? 12.0 : 32.0),
                color: Colors.white,
                width: 100.0.wp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.finScreen_body,
                          style: AppTextStyles.headerText,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(AppLocalizations.of(context)!.search),
                            ),
                            10.0.giveWidth,
                            SizedBox(
                              width: 100,
                              height: 70,
                              child: NameTextField(
                                hintStyle: AppTextStyles.formTitleTextStyle
                                    .copyWith(
                                        color: AppColors.ashColor,
                                        fontWeight: FontWeight.normal),
                              ),
                            ),
                            20.0.giveWidth,
                            Row(
                              children: [
                                Text(
                                  "By Weeks",
                                  style: AppTextStyles.priceTextStyle,
                                ),
                                CupertinoSwitch(
                                  value: model.isDay,
                                  onChanged: (value) {
                                    model.changeWeekOrDay(
                                        value, page, from, to, context);
                                  },
                                ),
                                Text(
                                  "By Days",
                                  style: AppTextStyles.priceTextStyle,
                                ),
                                // a == model.selectedDayRange
                                //     ? NeonContainer(
                                //         spreadColor:
                                //             AppColors.checkBoxSelected,
                                //         lightSpreadRadius: 0,
                                //         lightBlurRadius: 20,
                                //         containerColor:
                                //             AppColors.bingoGreen,
                                //         borderRadius:
                                //             BorderRadius.circular(50),
                                //         borderWidth: 0,
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(50),
                                //             boxShadow: [
                                //               BoxShadow(
                                //                 color: AppColors
                                //                     .checkBoxSelected
                                //                     .withAlpha(60),
                                //                 blurRadius: 6.0,
                                //                 spreadRadius: 1.0,
                                //                 offset: const Offset(
                                //                   1.0,
                                //                   4.0,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //           child: Icon(
                                //             Icons.circle_rounded,
                                //             color: AppColors
                                //                 .checkBoxSelected,
                                //           ),
                                //         ),
                                //       )
                                //     : Icon(Icons.circle_outlined,
                                //         color: AppColors.checkBox),
                                // 10.0.giveWidth,
                                // Text(a == "1" ? "Weekdays" : "Day Range")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    sortedGrandTotalBox(context, model),
                    20.0.giveHeight,
                    if (model.isBusy) Utils.bigLoader(),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

footer(model, context, String? page, String? from, String? to) {
  return Column(
    children: [
      20.0.giveHeight,
      if (model.rFinStat.isEmpty)
        model.isBusy
            ? const SizedBox()
            : SizedBox(
                width: 100.0.wp,
                height: 200,
                child: Center(
                  child: Text(AppLocalizations.of(context)!.noDataInTable("")),
                ),
              ),
      model.isBusy
          ? const SizedBox()
          : PaginationWidget(
              totalPage: model.rFinStatTotalData,
              perPage: 10,
              startTo: model.rFinStatTo,
              startFrom: model.rFinStatFrom,
              pageNumber: int.parse(page!),
              total: model.rFinTotalData,
              onPageChange: (int v) {
                model.changePage(v, from, to, context);
              }),
      30.0.giveHeight,
    ],
  );
}

var tableWidths = {
  0: FixedColumnWidth(40.0),
  1: FixedColumnWidth(40.0),
  2: FlexColumnWidth(.5),
  3: FixedColumnWidth(85.0),
  4: FixedColumnWidth(90.0),
  5: FlexColumnWidth(0.8),
  6: FixedColumnWidth(75.0),
  7: FixedColumnWidth(75.0),
  8: FixedColumnWidth(70.0),
  // 9: FixedColumnWidth(70.0),
  9: FixedColumnWidth(65.0),
  10: FixedColumnWidth(80.0),
  11: FixedColumnWidth(80.0),
  12: FixedColumnWidth(80.0),
  13: FixedColumnWidth(100.0),
  14: FixedColumnWidth(70.0),
  15: FixedColumnWidth(80.0),
  16: FixedColumnWidth(80.0),
};

var tableWidthsForMain = {
  0: FixedColumnWidth(40.0),
  1: FixedColumnWidth(40.0),
  2: FixedColumnWidth(90.0),
  3: FlexColumnWidth(.5),

  4: FixedColumnWidth(90.0),
  5: FlexColumnWidth(0.8),
  6: FixedColumnWidth(85.0),
  7: FixedColumnWidth(95.0),
  8: FixedColumnWidth(70.0),
  // 9: FixedColumnWidth(70.0),
  9: FixedColumnWidth(85.0),
  10: FixedColumnWidth(80.0),
  11: FixedColumnWidth(80.0),
  12: FixedColumnWidth(100.0),
  13: FixedColumnWidth(80.0),
  14: FixedColumnWidth(80.0),
  15: FixedColumnWidth(80.0),
};

var widthsWholesalerMain = {
  0: FixedColumnWidth(40.0),
  1: FixedColumnWidth(70.0),
  2: FlexColumnWidth(),
  3: FixedColumnWidth(85.0),
  5: FlexColumnWidth(),
  6: FixedColumnWidth(85.0),
  7: FixedColumnWidth(90.0),
  8: FixedColumnWidth(90.0),
  // 9: FixedColumnWidth(85.0),
  9: FixedColumnWidth(80.0),
  10: FixedColumnWidth(80.0),
  11: FixedColumnWidth(80.0),
  12: FixedColumnWidth(80.0),
  13: FixedColumnWidth(70.0),
  14: FixedColumnWidth(80.0),
  15: FixedColumnWidth(80.0),
};
var tableWidthsDialog = {
  0: FixedColumnWidth(40.0),
  1: FixedColumnWidth(40.0),
  2: FixedColumnWidth(85.0),
  3: FixedColumnWidth(85.0),
  4: FixedColumnWidth(90.0),
  5: FixedColumnWidth(85.0),
  6: FixedColumnWidth(85.0),
  7: FixedColumnWidth(75.0),
  8: FixedColumnWidth(70.0),
  // 9: FixedColumnWidth(70.0),
  9: FixedColumnWidth(85.0),
  10: FixedColumnWidth(80.0),
  11: FixedColumnWidth(80.0),
  12: FixedColumnWidth(80.0),
  13: FixedColumnWidth(100.0),
  14: FixedColumnWidth(70.0),
  15: FixedColumnWidth(60.0),
  16: FixedColumnWidth(80.0),
};
var widthsWholesaler = {
  0: FixedColumnWidth(40.0),
  1: FixedColumnWidth(70.0),
  2: FlexColumnWidth(),
  3: FixedColumnWidth(85.0),
  4: FixedColumnWidth(90.0),
  5: FlexColumnWidth(),
  6: FixedColumnWidth(85.0),
  7: FixedColumnWidth(140.0),
  8: FixedColumnWidth(90.0),
  // 9: FixedColumnWidth(85.0),
  9: FixedColumnWidth(80.0),
  10: FixedColumnWidth(80.0),
  11: FixedColumnWidth(80.0),
  12: FixedColumnWidth(100.0),
  13: FixedColumnWidth(80.0),
  14: FixedColumnWidth(100.0),
  15: FixedColumnWidth(80.0),
};

var widthsForHeaderRetailer = {
  0: FlexColumnWidth(),
  1: FixedColumnWidth(70.0),
  2: FixedColumnWidth(85.0),
  3: FixedColumnWidth(80.0),
  4: FixedColumnWidth(80.0),
  5: FixedColumnWidth(100.0),
  6: FixedColumnWidth(80.0),
  7: FixedColumnWidth(80.0),
};

var widthsForHeaderWholesaler = {
  0: FlexColumnWidth(),
  1: FixedColumnWidth(90.0),
  2: FixedColumnWidth(90.0),
  3: FixedColumnWidth(80.0),
  4: FixedColumnWidth(80.0),
  5: FixedColumnWidth(80.0),
  6: FixedColumnWidth(80.0),
  7: FixedColumnWidth(70.0),
};
