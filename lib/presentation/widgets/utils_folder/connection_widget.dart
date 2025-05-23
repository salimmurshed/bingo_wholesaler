import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../const/all_const.dart';
import '../../../const/app_sizes/app_icon_sizes.dart';
import '../../../const/app_sizes/app_sizes.dart';

class ConnectionWidget extends StatelessWidget {
  const ConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppMargins.connectionWidgetMargin,
      alignment: Alignment.centerLeft,
      height: 70.0,
      width: double.infinity,
      padding: AppPaddings.connectionWidgetPadding,
      decoration: BoxDecoration(
          borderRadius: AppRadius.connectionWidgetRadius,
          color: AppColors.messageColorError),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30.0,
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(
              Icons.wifi_off,
              color: Colors.red,
              size: AppIconSizes.s28,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            AppLocalizations.of(context)!.noInternet,
            style: AppTextStyles.errorTextStyle
                .copyWith(fontWeight: AppFontWeighs.bold),
          )
        ],
      ),
    );
  }
}
