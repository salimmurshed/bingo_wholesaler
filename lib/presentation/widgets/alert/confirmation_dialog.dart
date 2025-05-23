import 'package:flutter/foundation.dart';

import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String submitButtonText;
  final bool ifYesNo;

  const ConfirmationDialog(
      {this.title = "",
      this.content = "",
      this.submitButtonText = "Submit",
      this.ifYesNo = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Text(title,
          style: AppTextStyles.salesScannerDialog
              .copyWith(fontWeight: AppFontWeighs.semiBold)),
      content: Text(content, style: AppTextStyles.salesScannerDialog),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SubmitButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              color: submitButtonText == AppLocalizations.of(context)!.reject
                  ? AppColors.statusVerified
                  : AppColors.statusReject,
              text: ifYesNo
                  ? AppLocalizations.of(context)!.rejectSell
                  : AppLocalizations.of(context)!.cancelButton.toUpperCase(),
              width: kIsWeb ? 10.0.wp : 29.0.wp,
            ),
            SubmitButton(
              color: submitButtonText == AppLocalizations.of(context)!.reject
                  ? AppColors.statusReject
                  : AppColors.statusVerified,
              onPressed: () {
                Navigator.pop(context, true);
              },
              text: ifYesNo
                  ? AppLocalizations.of(context)!.acceptSell
                  : submitButtonText.toUpperCase(),
              width: kIsWeb ? 10.0.wp : 29.0.wp,
            ),
          ],
        ),
      ],
    );
  }
}
