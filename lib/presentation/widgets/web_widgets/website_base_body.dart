import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';

import '../../../const/web_devices.dart';

class WebsiteBaseBody extends StatelessWidget {
  const WebsiteBaseBody({
    required this.body,
    super.key,
  });
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: 100.0.wp,
        child: Padding(
          padding: EdgeInsets.all(device != ScreenSize.wide ? 12.0 : 8.0),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: device != ScreenSize.wide ? 0.0 : 24.0),
            child: body,
          ),
        ));
  }
}
