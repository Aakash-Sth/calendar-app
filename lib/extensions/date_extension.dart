import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String getDate() => DateFormat("yyyy-MM-dd").format(this);
}
