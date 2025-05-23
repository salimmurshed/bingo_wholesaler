import 'package:flutter/foundation.dart';

import '/const/all_const.dart';
import '/presentation/widgets/buttons/cancel_button.dart';
import '/presentation/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DatePicker extends StatelessWidget {
  DateTime _selectDate = DateTime.now();
  bool isPreviousData;
  bool cancelEmpty;

  DatePicker(
      {this.isPreviousData = false, this.cancelEmpty = false, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.calenderBackground,
      content: kIsWeb
          ? Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.bingoGreen, // header background color
                  onPrimary: AppColors.selectedButton, // header text color
                  onSurface: AppColors.blackColor, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                ),

                // TextButtonThemeData(
                //   style: TextButton.styleFrom(
                //     foregroundColor: Colors.red, // button text color
                //   ),
                // ),
              ),
              child: DatePickerDialog(
                restorationId: 'date_picker_dialog',
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 2),
                lastDate: DateTime(DateTime.now().year + 5),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 600.0,
                  width: 600.0,
                  child: DatePickerWidget(
                    looping: false,
                    // default is not looping
                    firstDate: isPreviousData ? DateTime(1960) : DateTime.now(),
                    //DateTime(1960),

                    dateFormat:
                        // "MM-dd(E)",
                        "dd/MMMM/yyyy",
                    // locale: DatePicker.localeFromString('th'),
                    onChange: (DateTime newDate, _) {
                      _selectDate = newDate;
                    },
                    pickerTheme: const DateTimePickerTheme(
                      backgroundColor: AppColors.transparent,
                      itemTextStyle: AppTextStyles.appBarTitle,
                      dividerColor: AppColors.cardShadow,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CancelButton(
                      width: kIsWeb ? 20.0.wp : 55.0.wp / 2,
                      onPressed: () {
                        Navigator.pop(
                            context, cancelEmpty ? "" : DateTime.now());
                      },
                      text: AppLocalizations.of(context)!.cancelButton,
                    ),
                    SubmitButton(
                      width: kIsWeb ? 20.0.wp : 55.0.wp / 2,
                      onPressed: () {
                        Navigator.pop(context, _selectDate);
                      },
                      text: AppLocalizations.of(context)!.selectDate,
                    )
                  ],
                )
              ],
            ),
    );
  }
}
