import 'package:bingo/const/utils.dart';
import 'package:flutter/services.dart';

import '/const/all_const.dart';
import '/const/app_extensions/widgets_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../buttons/submit_button.dart';

class ActivationDialog extends StatelessWidget {
  ActivationDialog(
      {this.activationCode = "", Key? key, required this.isRetailer})
      : super(key: key);
  String activationCode;
  bool isRetailer;
  bool isEditable = true;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!isRetailer) {
      textController.text = activationCode;
      isEditable = false;
    }
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!
                .activationCode
                .toUpperCamelCaseSpaced(),
            style: AppTextStyles.dashboardHeadTitle.copyWith(
              fontWeight: AppFontWeighs.semiBold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isEditable
              ? TextField(
                  style: AppTextStyles.formFieldTextStyle,
                  enabled: isEditable,
                  // maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: textController,
                  decoration: isEditable
                      ? AppInputStyles.blackOutlineBorder
                      : AppInputStyles.ashOutlineBorderDisable,
                )
              : InkWell(
                  splashColor: AppColors.activeButtonColor,
                  onLongPress: () async {
                    await Clipboard.setData(
                        ClipboardData(text: activationCode));
                    Utils.toast("copied", sec: 1);
                  },
                  child: TextField(
                    style: AppTextStyles.formFieldTextStyle,
                    enabled: isEditable,
                    // maxLength: 6,
                    keyboardType: TextInputType.number,
                    controller: textController,
                    decoration: isEditable
                        ? AppInputStyles.blackOutlineBorder
                        : AppInputStyles.ashOutlineBorderDisable,
                  ),
                ),
          27.0.giveHeight,
          isRetailer
              ? SubmitButton(
                  onPressed: () {
                    Navigator.pop(context, textController.text);
                  },
                  // onPressed: model.openActivationCodeDialog,
                  width: 209.0,
                  height: 45.0,
                  active: true,
                  text:
                      AppLocalizations.of(context)!.submitButton.toUpperCase(),
                )
              : SubmitButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // onPressed: model.openActivationCodeDialog,
                  width: 209.0,
                  height: 45.0,
                  active: true,
                  // textController.text.trim().length == 6 ?
                  //true : false,
                  text: AppLocalizations.of(context)!.closeButton.toUpperCase(),
                )
        ],
      ),
    );
  }
}
