import '/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlertDialogMessage extends StatelessWidget {
  final String error;

  const AlertDialogMessage(this.error);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(AppLocalizations.of(context)!.alert),
      content: SingleChildScrollView(
        child: Text(error),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.closeButton,
            style: AppTextStyles.addRequestSubTitle,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
