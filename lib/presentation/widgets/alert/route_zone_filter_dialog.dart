import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../buttons/cancel_button.dart';
import '../buttons/submit_button.dart';

class RouteZoneFilterDialog extends StatelessWidget {
  const RouteZoneFilterDialog(this.available, this.length, {Key? key})
      : super(key: key);
  final bool available;
  final int length;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      content: const SingleChildScrollView(
        child: Text('Do you want to load it in today list or filter the app?'),
      ),
      title: const Icon(
        Icons.warning_amber,
        size: 64.0,
        color: AppColors.alertDialogIconColor,
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CancelButton(
              width: 80.0.wp,
              text: AppLocalizations.of(context)!.filterAppCta,
              onPressed: () {
                Navigator.of(context).pop(2);
              },
            ),
            if (!available)
              SubmitButton(
                width: 80.0.wp,
                text: AppLocalizations.of(context)!.addTodoCta,
                onPressed: () {
                  Navigator.of(context).pop(0);
                },
              ),
            if (length != 0)
              SubmitButton(
                width: 80.0.wp,
                color: AppColors.redColor,
                text: AppLocalizations.of(context)!.replaceTodoCta,
                onPressed: () {
                  Navigator.of(context).pop(1);
                },
              ),
          ],
        ),
      ],
    );
  }
}
