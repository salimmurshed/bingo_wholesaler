import 'package:bingo/const/all_const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusWidgetCenter extends StatelessWidget {
  const StatusWidgetCenter({
    this.color = AppColors.statusProgress,
    this.text = "",
    this.isIconAvailable = true,
    this.textAlign = TextAlign.start,
    this.textStyle = AppTextStyles.statusCardStatus,
    this.isCenter = false,
    super.key,
  });
  final Color color;
  final String text;
  final bool isIconAvailable;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    return isCenter
        ? SizedBox(
            width: 100.0.wp,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: kIsWeb
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisAlignment: kIsWeb
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: [
                  if (isIconAvailable)
                    Image.asset(
                      AppAsset.statusIcon,
                      color: color,
                    ),
                  if (!isIconAvailable) SizedBox(),
                  Text(
                    text,
                    textAlign: textAlign,
                    maxLines: 1,
                    softWrap: true,
                    style: textStyle.copyWith(color: color),
                  ),
                ],
              ),
            ),
          )
        : kIsWeb
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    style: textStyle.copyWith(color: color),
                  ),
                ),
              )
            : SizedBox(
                width: 150,
                child: RichText(
                  textAlign: textAlign,
                  maxLines: 2,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      if (isIconAvailable)
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 4, 2),
                            child: Icon(
                              Icons.circle_rounded,
                              size: 10,
                              color: color,
                            ),
                          ),
                        ),
                      TextSpan(
                          text: text, style: textStyle.copyWith(color: color)),
                    ],
                  ),
                ),
              );
  }
}
