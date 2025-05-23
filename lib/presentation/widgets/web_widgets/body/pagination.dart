import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

import '../../../../const/web_devices.dart';
import '../pagination/flutter_pagination.dart';
import '../pagination/pagination.dart';
import '../pagination/widgets/button_styles.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget(
      {this.totalPage = 0,
      this.perPage = 0,
      this.startTo = 0,
      this.startFrom = 0,
      this.pageNumber = 0,
      this.total = 0,
      required this.onPageChange,
      Key? key})
      : super(key: key);
  final int totalPage;
  final int perPage;
  final int startTo;
  final int startFrom;
  final int pageNumber;
  final int total;
  final Function(int number) onPageChange;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: device == ScreenSize.small ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (device == ScreenSize.small) 10.0.giveHeight,
        Text(
          "Showing $startFrom to $startTo of $total entries",
          style: AppTextStyles.retailerStoreCard,
        ),
        WebPagination(
            currentPage: pageNumber,
            totalPage: totalPage,
            displayItemCount: 10,
            onPageChanged: (page) {
              onPageChange(page);
            }),
      ],
    );
  }
}
