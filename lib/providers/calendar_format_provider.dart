import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

final calendarFormatProvider = StateProvider<CalendarFormat>(
  (ref) => CalendarFormat.month,
);
