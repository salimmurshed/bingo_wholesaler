import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String time, BuildContext context) {
    List times = time.split(" ");
    debugPrint(time);
    String timeSingle = //'2020-07-12T20:42:19Z';
        "${times[0]}T${times[1]}Z";

    final year = int.parse(timeSingle.substring(0, 4));
    final month = int.parse(timeSingle.substring(5, 7));
    final day = int.parse(timeSingle.substring(8, 10));
    final hour = int.parse(timeSingle.substring(11, 13));
    final minute = int.parse(timeSingle.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;
    final int diffInMinutes = DateTime.now().difference(videoDate).inMinutes;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;
    int hoursInDay = 24;

    if (diffInMinutes < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = AppLocalizations.of(context)!.now;
    } else {
      if (diffInHours < 1) {
        final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
        timeValue = diffInMinutes;
        timeUnit = AppLocalizations.of(context)!.minute;
      } else if (diffInHours < hoursInDay) {
        timeValue = diffInHours;
        timeUnit = AppLocalizations.of(context)!.hour;
      } else if (diffInHours >= hoursInDay && diffInHours < hoursInDay * 2) {
        timeValue = (diffInHours / hoursInDay).floor();
        timeUnit = AppLocalizations.of(context)!.yesterday;
      } else if (diffInHours >= hoursInDay * 2 &&
          diffInHours < hoursInDay * 7) {
        timeValue = (diffInHours / hoursInDay).floor();
        timeUnit = AppLocalizations.of(context)!.day;
      } else if (diffInHours >= hoursInDay * 7 &&
          diffInHours < hoursInDay * 30) {
        timeValue = (diffInHours / (hoursInDay * 7)).floor();
        timeUnit = AppLocalizations.of(context)!.week;
      } else if (diffInHours >= hoursInDay * 30 &&
          diffInHours < hoursInDay * 12 * 30) {
        timeValue = (diffInHours / (hoursInDay * 30)).floor();
        timeUnit = AppLocalizations.of(context)!.month;
      } else {
        timeValue = (diffInHours / (hoursInDay * 365)).floor();
        timeUnit = AppLocalizations.of(context)!.year;
      }
    }

    if (diffInMinutes < 1) {
      return AppLocalizations.of(context)!.now;
    } else if (diffInHours >= hoursInDay && diffInHours < hoursInDay * 2) {
      return AppLocalizations.of(context)!.yesterday;
    } else {
      timeAgo = '$timeValue $timeUnit';
      timeAgo += timeValue > 1 ? 's' : '';
      return '$timeAgo ${AppLocalizations.of(context)!.ago}';
    }
  }
}
