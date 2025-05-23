import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../const/web_devices.dart';

class LogisticCard extends StatelessWidget {
  const LogisticCard(this.title, this.color, this.route,
      {this.hasPage = false, super.key});
  final String title;
  final Color color;
  final String route;
  final bool hasPage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        hasPage
            ? context.goNamed(route, pathParameters: {"page": '1'})
            : context.goNamed(route);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: color),
        height: 70,
        width: device == ScreenSize.wide ? (100.0.wp - (32 * 6)) / 3 : 100.0.wp,
        child: Center(
            child: Text(
          title,
          style: AppTextStyles.appBarTitle,
        )),
      ),
    );
    ;
  }
}
