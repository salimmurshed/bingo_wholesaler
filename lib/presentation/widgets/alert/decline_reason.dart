import '/const/all_const.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import '/presentation/widgets/dropdowns/selected_dropdown.dart';
import '/presentation/widgets/text_fields/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclineReason extends StatelessWidget {
  DeclineReason({Key? key}) : super(key: key);

  void function(v) {}
  var selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.addDecalineReason,
          style: AppTextStyles.alertBlueTextStyle,
        ),
      ),
      content: SizedBox(
        width: 100.0.wp,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectedDropdown(
                items: [],
                dropdownValue: selectedValue,
                onChange: (newValue) {
                  function(newValue);
                },
                hintText: AppLocalizations.of(context)!.selectReason,
                fieldName: ""),
            20.0.giveHeight,
            NameTextField(
              maxLine: 10,
              hintText: AppLocalizations.of(context)!.enterMessage,
              fieldName: AppLocalizations.of(context)!.writeDeclineReason,
            ),
            20.0.giveHeight,
            SubmitButton(
              text: AppLocalizations.of(context)!.submitButton,
              width: 180.0,
              height: 45.0,
            )
          ],
        ),
      ),
    );
  }
}
