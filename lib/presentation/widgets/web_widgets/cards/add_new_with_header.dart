import 'package:bingo/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/web_devices.dart';
import '../../buttons/submit_button.dart';
import '../../text_fields/name_text_field.dart';

class AddNewWithHeader extends StatelessWidget {
  const AddNewWithHeader(
      {this.onTap, this.label = "", this.onTapTitle = "", Key? key})
      : super(key: key);
  final Function()? onTap;
  final String label;
  final String onTapTitle;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: device == ScreenSize.wide ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.headerText,
            ),
            if (onTap != null)
              SubmitButton(
                color: AppColors.bingoGreen,
                // color: AppColors.bingoGreen,
                isRadius: false,
                height: 30,
                width: 80,
                onPressed: () {
                  onTap!();
                },
                text: onTapTitle,
              ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(AppLocalizations.of(context)!.search),
            ),
            10.0.giveWidth,
            SizedBox(
                width: 100,
                height: 70,
                child: NameTextField(
                  hintStyle: AppTextStyles.formTitleTextStyle.copyWith(
                      color: AppColors.ashColor, fontWeight: FontWeight.normal),
                ))
          ],
        ),
      ],
    );
  }
}
