import '/const/all_const.dart';
import '/const/app_styles/app_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../const/app_sizes/app_sizes.dart';

class SingleLineShimmerScreen extends StatelessWidget {
  const SingleLineShimmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bodyVertical,
      child: SizedBox(
        width: 100.0.wp,
        // height: 200.0,
        child: Shimmer.fromColors(
          baseColor: AppColors.shimmerBaseColor,
          highlightColor: AppColors.shimmerHighlightColor,
          child: Container(
            height: 20.0,
            width: 100.0.wp,
            decoration: AppBoxDecoration.dashboardCardDecoration,
            child: const Text(""),
          ),
        ),
      ),
    );
  }
}
