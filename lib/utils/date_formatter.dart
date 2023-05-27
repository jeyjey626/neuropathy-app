import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../languages.dart';

class DateFormatter extends StatelessWidget {
  final DateTime dateTime;

  const DateFormatter({super.key, required this.dateTime});

  String getFormattedTime(DateTime dateTime, BuildContext context) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();
    String timeString = DateFormat('jm').format(dateTime);

    if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day) {
      String today = Languages.of(context)!.translate('result-screen.today');
      return '$today, $timeString';
    } else if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day + 1) {
      String yesterday =
          Languages.of(context)!.translate('result-screen.yesterday');
      return '$yesterday, $timeString';
    } else if (now.difference(localDateTime).inDays < 7) {
      String weekDay =
          DateFormat('EEEE', Languages.of(context)!.locale.toLanguageTag())
              .format(localDateTime);
      return '$weekDay, $timeString';
    }
    String date = DateFormat('dd/MM/yyyy').format(localDateTime);
    return '$date, $timeString';
  }

  @override
  Widget build(BuildContext context) {
    return Text(getFormattedTime(dateTime, context));
  }
}