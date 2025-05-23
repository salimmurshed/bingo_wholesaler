import 'package:flutter/material.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_sizes/app_sizes.dart';

class ShadowCard extends StatelessWidget {
  const ShadowCard(
      {this.child,
      this.isChild = false,
      this.padding = 0.0,
      this.color = AppColors.cardColor,
      Key? key})
      : super(key: key);
  final Widget? child;
  final bool isChild;
  final double padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding != 0.0
          ? EdgeInsets.symmetric(horizontal: padding)
          : isChild
              ? AppPaddings.cardPaddingChild
              : AppMargins.statusCardMargin,
      child: Card(
        color: color,
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.salesDetailsRadius,
        ),
        child: Container(
          padding: AppPaddings.cardPadding,
          decoration: BoxDecoration(
            borderRadius: AppRadius.salesDetailsRadius,
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
