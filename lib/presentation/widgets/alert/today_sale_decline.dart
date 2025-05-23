import '/const/all_const.dart';
import '/data_models/models/today_decline_reason_model/today_decline_reason_model.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/dropdowns/selected_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodaySaleDecline extends StatelessWidget {
  TextEditingController reasonController = TextEditingController();
  TodayDeclineReasonsData? selectedDeclineReason;

  TodaySaleDecline(this.todayDeclineReasons, {super.key});

  List<TodayDeclineReasonsData> todayDeclineReasons;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: AppColors.whiteColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.addDecalineReason,
                style: AppTextStyles.alertBlueTextStyle,
              ),
            ),
            300.0.giveWidth,
            SelectedDropdown(
              dropdownValue: selectedDeclineReason,
              items: todayDeclineReasons
                  .map(
                    (e) => DropdownMenuItem<TodayDeclineReasonsData>(
                      value: e,
                      child: Text(e.declineReason!),
                    ),
                  )
                  .toList(),
              onChange: (TodayDeclineReasonsData? v) {
                selectedDeclineReason = v!;
                setState(() {});
              },
              hintText: AppLocalizations.of(context)!.selectReason,
            ),
            20.0.giveHeight,
            Text(
              AppLocalizations.of(context)!.writeDeclineReason,
              style: AppTextStyles.formTitleTextStyle,
            ),
            10.0.giveHeight,
            TextFormField(
              maxLength: 250,
              textCapitalization: TextCapitalization.sentences,
              scrollPadding: EdgeInsets.zero,
              maxLines: 5,
              style: AppTextStyles.formFieldTextStyle
                  .copyWith(color: AppColors.blackColor),

              decoration: AppInputStyles.ashOutlineBorder.copyWith(
                  hintText: AppLocalizations.of(context)!.enterMessage,
                  hintStyle: AppTextStyles.formFieldHintTextStyle,
                  fillColor: AppColors.whiteColor,
                  filled: true),
              // decoration: AppInputStyles.ashOutlineBorder.copyWith(
              //     fillColor:
              //         enable ? AppColors.whiteColor : AppColors.disableColor),
              controller: reasonController,
            ),
            10.0.giveHeight,
            Center(
              child: SubmitButton(
                onPressed: () {
                  Map<String, String> body = {
                    "decline_store_reason_unique_id":
                        selectedDeclineReason!.uniqueId!,
                    "description": reasonController.text
                  };
                  Navigator.pop(context, body);
                },
                height: 45.0,
                width: 200.0,
                text: AppLocalizations.of(context)!.submitButton,
              ),
            )
          ],
        ),
      );
    });
  }
}
