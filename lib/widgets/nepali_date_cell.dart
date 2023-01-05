import 'package:calendar_app/extensions/date_extension.dart';
import 'package:calendar_app/providers/selected_date_provider.dart';
import 'package:calendar_app/styles/app_colors.dart';
import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NepaliDateCell extends ConsumerWidget {
  final bool isToday;
  final bool isSelected;
  final bool isDisabled;
  final NepaliDateTime nepaliDate;
  final String label;
  final String text;
  final CalendarStyle calendarStyle;
  final bool isWeekend;
  final Function getEvents;
  const NepaliDateCell(
      {super.key,
      required this.isToday,
      required this.isSelected,
      required this.isDisabled,
      required this.nepaliDate,
      required this.label,
      required this.text,
      required this.calendarStyle,
      required this.isWeekend,
      required this.getEvents});

  @override
  Widget build(BuildContext context, ref) {
    bool isSelected = nepaliDate.toDateTime().getDate() ==
        ref.read(selectedDateProvider).getDate();

    Color getBoxColor() {
      if (isSelected) {
        return AppColors.selectedDate;
      }
      if (isToday) return AppColors.focusedDate;

      return Colors.transparent;
    }

    Color getTextColor() {
      Color color = Colors.white;
      if (isSelected) return color;
      if (isWeekend) {
        color = AppColors.weekendColor;
      }
      return color;
    }

    final eventsLength = getEvents(nepaliDate.toDateTime()).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 3.7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getBoxColor(),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: getTextColor(),
                ),
              ),
            ),
            if (eventsLength != 0)
              Positioned(
                height: 10,
                bottom: 0,
                width: constraints.maxWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < eventsLength; i++)
                        if (i < 3)
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              shape: BoxShape.circle,
                            ),
                            width: 7.5,
                          )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
