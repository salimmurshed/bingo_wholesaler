import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverAmountReconfirmOrder extends StatelessWidget {
  OverAmountReconfirmOrder({Key? key}) : super(key: key);
  int selectItem = 0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: AppColors.whiteColor,
        title: Text(AppLocalizations.of(context)!.creditAvailabilityCheck),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.creditAvailabilityDialogBody),
            20.0.giveHeight,
            GestureDetector(
              onTap: () {
                setState(() {
                  selectItem = 1;
                });
              },
              child: radioButton(
                  AppLocalizations.of(context)!.modifyOrder, 1, selectItem),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectItem = 2;
                });
              },
              child: radioButton(
                  AppLocalizations.of(context)!.increaseModifyOrder,
                  2,
                  selectItem),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectItem = 3;
                });
              },
              child: radioButton(
                  AppLocalizations.of(context)!.increaseModifyOrderForLater,
                  3,
                  selectItem),
            ),
          ],
        ),
        actions: [
          SubmitButton(
            color: AppColors.redColor,
            width: 30.0.wp,
            onPressed: () {
              Navigator.pop(context);
            },
            text: AppLocalizations.of(context)!.cancelButton,
          ),
          SubmitButton(
            width: 30.0.wp,
            onPressed: () {
              Navigator.pop(context, selectItem);
            },
            text: AppLocalizations.of(context)!.ok,
          ),
        ],
      );
    });
  }

  radioButton(String text, int i, int selectItem) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          i == selectItem
              ? const Icon(
                  Icons.radio_button_checked,
                  color: AppColors.greenColor,
                )
              : const Icon(Icons.radio_button_off),
          10.0.giveWidth,
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
