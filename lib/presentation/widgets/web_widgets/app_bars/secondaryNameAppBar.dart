import 'package:flutter/material.dart';

import '../../../../const/app_styles/app_text_styles.dart';
import '../../../../main.dart';
import '../../../../services/storage/db.dart';

class SecondaryNameAppBar extends StatelessWidget {
  SecondaryNameAppBar({this.h1 = "", this.h2 = "", Key? key}) : super(key: key);
  final String h1;
  final String h2;
  String section =
      (prefs.getString(DataBase.userType))!.toLowerCase() == "retailer"
          ? "Retailer Section"
          : (prefs.getString(DataBase.userType))!.toLowerCase() == "wholesaler"
              ? "Wholesaler Section"
              : "FIE Section";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          h1,
          style: AppTextStyles.headerText,
        ),
        Text(
          section,
          style: AppTextStyles.dashboardHeadTitleAsh,
        ),
      ],
    );
  }
}
