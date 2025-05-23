import 'package:bingo/const/all_const.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../const/app_colors.dart';
import '../../widgets/cards/shadow_card.dart';

class TermScreenView extends StatelessWidget {
  const TermScreenView(
      {Key? key, required this.id, required this.des, required this.isRetailer})
      : super(key: key);
  final String id;
  final String des;
  final bool isRetailer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isRetailer
            ? AppColors.appBarColorRetailer
            : AppColors.appBarColorWholesaler,
        title: Text(id),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: SizedBox(
          width: 100.0.wp,
          child: SingleChildScrollView(
            child: ShadowCard(child: Html(data: des)),
          ),
        ),
      ),
    );
  }
}
