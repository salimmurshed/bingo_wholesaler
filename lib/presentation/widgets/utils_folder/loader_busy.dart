import 'package:flutter/material.dart';

import '../../../const/app_colors.dart';

class LoaderBusy extends StatelessWidget {
  const LoaderBusy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 10.0,
        width: 10.0,
        child: CircularProgressIndicator(
          color: AppColors.loader1,
        ),
      ),
    );
  }
}
