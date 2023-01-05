import 'package:calendar_app/constants/strings.dart';
import 'package:calendar_app/extensions/date_extension.dart';
import 'package:calendar_app/models/event_detail.dart';
import 'package:calendar_app/providers/events_provider.dart';
import 'package:calendar_app/providers/locale_provider.dart';
import 'package:calendar_app/providers/selected_calendar_provider.dart';
import 'package:calendar_app/sizes.dart';
import 'package:calendar_app/styles/app_colors.dart';
import 'package:calendar_app/widgets/dialog_details.dart';
import 'package:calendar_app/widgets/event_list.dart';
import 'package:calendar_app/widgets/custom_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/english_calendar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    DateTime firstDay = DateTime(2010);
    DateTime lastDay = DateTime(2030);

    List<String> langs = [Strings.english, Strings.nepali];
    // final screenSize = MediaQuery.of(context).size;
    // final screenHeight = screenSize.height;
    final l10ns = AppLocalizations.of(context)!;
    final selectedCalendar = ref.watch(selectedCalendarProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10ns.appName),
        actions: [
          DropdownButton(
            iconSize: 23,
            style: const TextStyle(fontSize: Sizes.dropButton),
            value: selectedCalendar,
            hint: Text(l10ns.selectCalendarType),
            items: langs
                .map(
                  (lang) => DropdownMenuItem(
                    value: lang,
                    child: Text(
                      lang,
                    ),
                  ),
                )
                .toList(),
            onChanged: (type) {
              ref.read(selectedCalendarProvider.notifier).state = type;
              if (type == Strings.english) {
                ref.read(localeProvider.notifier).state = const Locale("en");
              } else {
                ref.read(localeProvider.notifier).state = const Locale("ne");
              }
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final eventsStream = ref.watch(eventsStreamProvider);

          return eventsStream.when(
            data: (events) {
              List<EventDetail> getEvents(DateTime day) {
                List<EventDetail> eventsOnTheDay = [];
                for (final event in events) {
                  if (event.date == day.getDate()) {
                    eventsOnTheDay = event.events;
                    break;
                  }
                }
                return eventsOnTheDay;
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      selectedCalendar == Strings.nepali
                          ? CustomNepaliCalendar(getEvents)
                          : EnglishCalendar(
                              firstDay: firstDay,
                              lastDay: lastDay,
                              getEvents: getEvents),
                      EventList(
                        getEvents: getEvents,
                      )
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => const Center(
              child: Text(
                Strings.error,
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.focusedDate,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              content: DialogDetails(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
