import '/const/all_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableBody extends StatelessWidget {
  const TableBody(
      {this.scrollController,
      required this.columnsNames,
      required this.rows,
      Key? key})
      : super(key: key);
  final ScrollController? scrollController;
  final List<String> columnsNames;
  final List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0.wp,
      child: Scrollbar(
        controller: scrollController,
        interactive: true,
        thickness: 16.0,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.tableHeaderBody,
                border: Border.all(color: AppColors.tableHeaderBody, width: 1)),
            padding: const EdgeInsets.only(bottom: 20.0),
            child: DataTable(
              decoration: const BoxDecoration(color: AppColors.tableHeaderBody),
              dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.tableHeaderColor;
                }
                return null; // Use the default value.
              }),
              sortAscending: true,
              columnSpacing: 20.0,
              dataRowMaxHeight: double.infinity,
              dataRowMinHeight: 60,
              dividerThickness: 1,
              columns: columnsNames.map((e) => dataColumn(e)).toList(),
              rows: rows,
            ),
          ),
        ),
      ),
    );
  }

  DataColumn dataColumn(String title) {
    return DataColumn(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: AppTextStyles.webTableHeader,
        ),
      ),
    );
  }
}
