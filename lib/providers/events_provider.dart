import 'package:calendar_app/models/event.dart';
import 'package:calendar_app/models/event_detail.dart';
import 'package:calendar_app/service/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsProvider = StateNotifierProvider<EventNotifier, List<Event>>(
  (ref) => EventNotifier(
    firebaseService: ref.read(firebaseServiceProvider),
  ),
);

final eventsStreamProvider = StreamProvider<List<Event>>(
  (ref) {
    final data = ref.read(firebaseServiceProvider).getEvents().map(
          (events) => events
              .map(
                (event) => Event.fromJson(event),
              )
              .toList(),
        );
    return data;
  },
);

class EventNotifier extends StateNotifier<List<Event>> {
  final FirebaseService _firebaseService;
  EventNotifier({
    required FirebaseService firebaseService,
  })  : _firebaseService = firebaseService,
        super([]);

  void addEvent(DateTime date, EventDetail eventDetail) =>
      _firebaseService.addEvent(date, eventDetail);

  void deleteEvent(DateTime date, EventDetail event) =>
      _firebaseService.deleteEvent(date, event);
}
