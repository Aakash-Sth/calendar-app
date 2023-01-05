import 'package:calendar_app/providers/focused_day_provider.dart';
import 'package:calendar_app/providers/selected_date_provider.dart';
import 'package:calendar_app/styles/app_colors.dart';
import 'package:calendar_app/widgets/nepali_calendar_header.dart';
import 'package:calendar_app/widgets/nepali_date_cell.dart';
import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNepaliCalendar extends ConsumerWidget {
  final Function getEvents;
  const CustomNepaliCalendar(this.getEvents, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
        left: 5,
      ),
      child: CleanNepaliCalendar(
        dateCellBuilder: (isToday, isSelected, isDisabled, nepaliDate, label,
                text, calendarStyle, isWeekend) =>
            NepaliDateCell(
          isToday: isToday,
          isSelected: isSelected,
          isDisabled: isDisabled,
          nepaliDate: nepaliDate,
          label: label,
          text: text,
          calendarStyle: calendarStyle,
          isWeekend: isWeekend,
          getEvents: getEvents,
        ),
        calendarStyle: CalendarStyle(
          weekEndTextColor: AppColors.weekendColor,
          selectedColor: AppColors.selectedDate,
          todayColor: AppColors.focusedDate,
        ),
        headerDayType: HeaderDayType.halfName,
        headerBuilder: (decoration, height, nextMonthHandler, prevMonthHandler,
                nepaliDateTime) =>
            NepaliCalendarHeader(
                decoration: decoration,
                height: height,
                nextMonthHandler: nextMonthHandler,
                prevMonthHandler: prevMonthHandler,
                nepaliDateTime: nepaliDateTime),
        controller: NepaliCalendarController(),
        onDaySelected: (nepaliDate) {
          ref.read(selectedDateProvider.notifier).state =
              nepaliDate.toDateTime();
          ref.read(focusedDayProvider.notifier).state = nepaliDate.toDateTime();
        },
      ),
    );
  }
}
