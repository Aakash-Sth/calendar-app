import 'package:calendar_app/providers/events_provider.dart';
import 'package:calendar_app/providers/selected_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventList extends ConsumerWidget {
  final Function getEvents;
  const EventList({
    super.key,
    required this.getEvents,
  });

  @override
  Widget build(BuildContext context, ref) {
    final l10ns = AppLocalizations.of(context)!;

    final selectedDate = ref.watch(selectedDateProvider);
    final events = getEvents(
      selectedDate,
    );

    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Column(
      children: [
        Text(
          l10ns.events,
          style: Theme.of(context).textTheme.headline6,
        ),
        Container(
          height: screenHeight * 0.3,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: events.isEmpty
              ? Center(
                  child: Text(l10ns.noEvents),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.6,
                            child: Text(
                              events[index].title,
                            ),
                          ),
                          PopupMenuButton(
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                height: 5,
                                child: Text(
                                  l10ns.delete,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                ),
                                onTap: () {
                                  final event = events[index];
                                  ref.read(eventsProvider.notifier).deleteEvent(
                                        selectedDate,
                                        event,
                                      );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: events.length,
                ),
        ),
      ],
    );
  }
}
