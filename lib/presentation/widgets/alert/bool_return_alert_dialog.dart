import '/const/all_const.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data_models/models/failure.dart';

class BoolReturnAlertDialog extends StatelessWidget {
  final String message;
  final Widget titleWidget;
  final String? yesButton;
  final String? noButton;

  const BoolReturnAlertDialog(this.message,
      {this.titleWidget = const Icon(
        Icons.warning_amber,
        size: 64.0,
        color: AppColors.alertDialogIconColor,
      ),
      this.yesButton,
      this.noButton,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: titleWidget,
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CancelButton(
              width: 28.0.wp,
              text: noButton ?? AppLocalizations.of(context)!.cancelButton,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            SubmitButton(
              width: 28.0.wp,
              text: yesButton ?? AppLocalizations.of(context)!.confirmButton,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
