import '../../../../const/web_devices.dart';
import '/const/all_const.dart';
import '/const/special_key.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calender extends StatelessWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.whiteColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
      content: SizedBox(
        height: 300,
        width: device != ScreenSize.wide ? 80.0.wp : 40.0.wp,
        child: CalendarDatePicker2(
          config: CalendarDatePicker2Config(
              todayTextStyle: TextStyle(color: Colors.red),
              yearTextStyle: TextStyle(color: Colors.black),
              yearBuilder: ({
                required year,
                decoration,
                isCurrentYear,
                isDisabled,
                isSelected,
                textStyle,
              }) {
                return Center(
                  child: Container(
                    decoration: decoration,
                    height: 36,
                    width: 72,
                    child: Center(
                      child: Semantics(
                        selected: isSelected,
                        button: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              year.toString(),
                              style: textStyle,
                            ),
                            if (isCurrentYear == true)
                              Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(left: 5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
              calendarType: CalendarDatePicker2Type.single,
              controlsHeight: 50),
          // initialValue: const [],
          onValueChanged: (List<DateTime?> value) async {
            Navigator.pop(context, value[0]);
          },

          value: const [],
        ),
      ),
    );
  }
}
