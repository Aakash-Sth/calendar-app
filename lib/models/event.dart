import 'package:calendar_app/models/event_detail.dart';

class Event {
  final String date;
  final List<EventDetail> events;

  Event({
    required this.date,
    required this.events,
  });

  Event.fromJson(Map<String, dynamic> json)
      : date = json["date"].toString(),
        events = json["events"]
            .map(
              (json) => EventDetail.fromJson(json),
            )
            .cast<EventDetail>()
            .toList();

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "events": events,
    };
  }
}
