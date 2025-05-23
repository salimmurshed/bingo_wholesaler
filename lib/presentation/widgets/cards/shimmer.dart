import '/const/all_const.dart';
import '/const/app_styles/app_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../const/app_sizes/app_sizes.dart';

class ShimmerScreen extends StatelessWidget {
  final int number;

  const ShimmerScreen({this.number = 1, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var j = 0; j < number; j++)
            Padding(
              padding: AppPaddings.bodyVertical,
              child: Container(
                margin: AppMargins.screenARDSWidgetMarginH,
                padding: AppPaddings.screenARDSWidgetInnerPadding,
                width: 100.0.wp,
                // height: 200.0,
                child: Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: AppBoxDecoration.shadowBox,
                        height: 200.0,
                        width: 200.0,
                        child: const Text(""),
                      ),
                      10.0.giveHeight,
                      for (var i = 1; i < 5; i++)
                        Column(
                          children: [
                            Container(
                              height: 10.0,
                              width: 20.0.wp * i,
                              decoration: AppBoxDecoration.shadowBox,
                              child: const Text(""),
                            ),
                            10.0.giveHeight,
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
