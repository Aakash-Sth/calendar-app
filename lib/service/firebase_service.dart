import 'package:calendar_app/extensions/date_extension.dart';
import 'package:calendar_app/models/event_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseService {
  final collectionRef = FirebaseFirestore.instance.collection("Events");
  Stream<List<Map<String, dynamic>>> getEvents() {
    final doc = collectionRef;
    final data = doc.snapshots().map(
          (snapshot) => snapshot.docs.map(
            (event) {
              final data = event.data();
              return data;
            },
          ).toList(),
        );
    return data;
  }

  void addEvent(DateTime date, EventDetail eventDetail) async {
    getEvents();
    final doc = collectionRef.doc(date.getDate());
    final docUser = await doc.get();
    if (docUser.exists) {
      final prevEvents = docUser.data()!["events"];
      doc.update(
        {
          "events": [
            ...prevEvents,
            eventDetail.toJson(),
          ]
        },
      );
    } else {
      final jsonEvent = {
        "date": date.getDate(),
        "events": [eventDetail.toJson()],
      };
      doc.set(jsonEvent);
    }
  }

  void deleteEvent(DateTime date, EventDetail eventDetail) async {
    final doc = collectionRef.doc(date.getDate());

    final docUser = await doc.get();

    final prevEvents = docUser.data()!["events"];

    await doc.update(
      {
        "events": [
          for (final event in prevEvents)
            if (event["title"] != eventDetail.title) event
        ]
      },
    );

    final updatedDocUser = await doc.get();

    final updatedEvents = updatedDocUser.data()!["events"];
    if (updatedEvents.isEmpty) {
      doc.delete();
    }
  }
}

final firebaseServiceProvider = Provider(
  (ref) => FirebaseService(),
);
