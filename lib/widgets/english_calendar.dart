import 'package:calendar_app/providers/calendar_format_provider.dart';
import 'package:calendar_app/providers/focused_day_provider.dart';
import 'package:calendar_app/providers/selected_date_provider.dart';
import 'package:calendar_app/sizes.dart';
import 'package:calendar_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class EnglishCalendar extends ConsumerWidget {
  final Function getEvents;
  final DateTime firstDay;
  final DateTime lastDay;
  const EnglishCalendar({
    required this.firstDay,
    required this.lastDay,
    required this.getEvents,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    const cellStyle = TextStyle(
      fontSize: Sizes.date,
    );
    DateTime focusedDay = ref.watch(focusedDayProvider);
    final calendarFormat = ref.watch(calendarFormatProvider);
    final selectedDay = ref.watch(
      selectedDateProvider,
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.39,
      margin: const EdgeInsets.only(bottom: 30),
      child: TableCalendar(
        shouldFillViewport: true,
        focusedDay: focusedDay,
        firstDay: firstDay,
        lastDay: lastDay,
        selectedDayPredicate: (day) => isSameDay(
          selectedDay,
          day,
        ),
        availableGestures: AvailableGestures.horizontalSwipe,
        onDaySelected: (selectedDay, focusedDay) {
          ref.read(selectedDateProvider.notifier).state = selectedDay;
          ref.read(focusedDayProvider.notifier).state = focusedDay;
        },
        weekendDays: const [DateTime.saturday],
        headerStyle: const HeaderStyle(
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.header,
          ),
          formatButtonVisible: false,
        ),
        calendarFormat: calendarFormat,
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(5),
          todayTextStyle: cellStyle,
          selectedTextStyle: cellStyle,
          weekendTextStyle: const TextStyle(
            color: AppColors.weekendColor,
            fontSize: Sizes.date,
          ),
          defaultTextStyle: cellStyle,
          markerDecoration: const BoxDecoration(
            color: Colors.lightBlue,
            shape: BoxShape.circle,
          ),
          markerSize: 7,
          markerMargin: const EdgeInsets.symmetric(horizontal: 1.5),
          todayDecoration: const BoxDecoration(
            color: AppColors.focusedDate,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 3,
          selectedDecoration: BoxDecoration(
            color: AppColors.selectedDate,
            shape: BoxShape.circle,
          ),
        ),
        onFormatChanged: (format) =>
            ref.read(calendarFormatProvider.notifier).state = format,
        eventLoader: (day) {
          return getEvents(day);
        },
      ),
    );
  }
}
