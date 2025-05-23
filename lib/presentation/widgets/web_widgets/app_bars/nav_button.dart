import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../const/app_font_manager.dart';
import '../../../../const/web_devices.dart';
import '../../text/common_text.dart';

class NavButton extends StatelessWidget {
  NavButton({
    this.text = "",
    this.onTap,
    Key? key,
    this.isBottom = false,
    this.isColor = false,
  }) : super(key: key);
  final String text;
  Function()? onTap;
  bool isBottom;
  bool isColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 3, color: isBottom ? Colors.blue : Colors.white),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextButton(
          onPressed: onTap,
          child: CommonText(
            text,
            style: TextStyle(
                fontWeight: kIsWeb && device == ScreenSize.small
                    ? isBottom
                        ? FontWeight.w900
                        : AppFontWeighs.medium
                    : isBottom
                        ? FontWeight.w900
                        : FontWeight.normal,
                fontFamily: kIsWeb ? "Lato" : "",
                color: isColor ? Colors.blue : Colors.blueGrey,
                fontSize: kIsWeb ? 16 : 18),
          ),
        ),
      ),
    );
  }
}
