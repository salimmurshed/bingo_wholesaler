import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import '../../../../const/app_styles/app_text_styles.dart';

Widget dataCell(String title, {bool isCenter = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
    child: isCenter
        ? Center(
            child: Text(
              title,
              style: AppTextStyles.webTableBody,
              textAlign: TextAlign.center,
            ),
          )
        : Text(
            title,
            style: AppTextStyles.webTableBody,
          ),
  );
}

Widget dataCellInMiddle(String title,
    {bool isCenter = true, TextStyle? style}) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: isCenter
          ? Center(
              child: Text(
                title,
                style: style ?? AppTextStyles.formTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            )
          : Text(
              title,
              style: style ?? AppTextStyles.formTitleTextStyle,
            ),
    ),
  );
}

Widget dataCellAmount(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
    child: Text(
      title,
      style: AppTextStyles.webTableBody,
      textAlign: TextAlign.right,
    ),
  );
}

Widget dataCellHd(String title, {bool isCenter = true, double padding = 12.0}) {
  return isCenter
      ? Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: padding, horizontal: 2.0),
            child: Center(
              child: Text(
                title.replaceAll(":", ""),
                style: AppTextStyles.webTableHeader,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Text(
            title.replaceAll(":", ""),
            style: AppTextStyles.webTableHeader,
          ),
        );
}

Widget dataCellHdTitle(String title, {align = TextAlign.center}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    child: Text(
      title,
      style: AppTextStyles.statusCardTitle,
    ),
  );
}

Widget noDataInTable() {
  return SizedBox(
    width: 100.0.wp,
    height: 200,
    child: const Center(
      child: Text("No data available in table"),
    ),
  );
}
