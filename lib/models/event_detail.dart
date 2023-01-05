class EventDetail {
  final String title;
  final DateTime? startTime;
  final DateTime? endTime;

  const EventDetail({
    required this.title,
    this.startTime,
    this.endTime,
  });

  EventDetail.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        startTime = json["startTime"],
        endTime = json["endTime"];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "starTime": startTime,
      "endTime": endTime,
    };
  }
}
