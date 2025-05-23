import 'package:flutter/foundation.dart';

import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDraftAlertDialog extends StatelessWidget {
  const OrderDraftAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: SizedBox(
          width: kIsWeb ? 20.0.wp : null,
          child: Text(
            AppLocalizations.of(context)!.draftOrderDialogBody,
            style: kIsWeb
                ? AppTextStyles.salesScannerDialog
                    .copyWith(fontSize: AppFontSize.s14)
                : const TextStyle(),
          )),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            kIsWeb ? MainAxisAlignment.spaceAround : MainAxisAlignment.end,
        children: [
          SubmitButton(
            color: AppColors.redColor,
            width: kIsWeb ? 8.0.wp : 28.0.wp,
            onPressed: () {
              Navigator.pop(context, false);
            },
            text: AppLocalizations.of(context)!.cancelButton,
          ),
          SubmitButton(
            width: kIsWeb ? 8.0.wp : 28.0.wp,
            onPressed: () {
              Navigator.pop(context, true);
            },
            text: AppLocalizations.of(context)!.ok,
          )
        ],
      ),
    );
  }
}
