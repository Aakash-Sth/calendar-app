import 'package:calendar_app/sizes.dart';
import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NepaliCalendarHeader extends StatelessWidget {
  final BoxDecoration decoration;
  final double height;
  final Function nextMonthHandler;
  final Function prevMonthHandler;
  final NepaliDateTime nepaliDateTime;
  const NepaliCalendarHeader({
    super.key,
    required this.decoration,
    required this.height,
    required this.nextMonthHandler,
    required this.prevMonthHandler,
    required this.nepaliDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final nepaliMonths = [
      "बैशाख",
      "जेष्ठ",
      "असार",
      "साउन",
      "भदौ",
      "असोज",
      "कार्तिक",
      "मंसिर",
      "पौष",
      "माघ",
      "फागुन",
      "चैत",
    ];
    return Container(
      decoration: decoration,
      child: ListTile(
        leading: IconButton(
          onPressed: () => prevMonthHandler(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
          ),
        ),
        title: Center(
          child: Text(
            "${nepaliMonths[nepaliDateTime.month - 1]} ${DateFormat.y("ne").format(nepaliDateTime)}",
            style: const TextStyle(fontSize: Sizes.header),
          ),
        ),
        trailing: IconButton(
          onPressed: () => nextMonthHandler(),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          ),
        ),
      ),
    );
  }
}
