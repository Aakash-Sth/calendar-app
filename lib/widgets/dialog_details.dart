import 'package:calendar_app/models/event_detail.dart';
import 'package:calendar_app/providers/events_provider.dart';
import 'package:calendar_app/providers/selected_date_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogDetails extends StatefulWidget {
  const DialogDetails({super.key});

  @override
  State<DialogDetails> createState() => _DialogDetailsState();
}

class _DialogDetailsState extends State<DialogDetails> {
  final eventController = TextEditingController();

  @override
  void dispose() {
    eventController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10ns = AppLocalizations.of(context)!;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10ns.addEvent,
            style: Theme.of(context).textTheme.headline6,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: eventController,
              decoration: InputDecoration(
                hintText: l10ns.eventHintText,
              ),
              validator: (value) => value!.isEmpty ? l10ns.emptyEvent : null,
            ),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) => MaterialButton(
              color: Colors.blueGrey,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final selectedDate = ref.read(selectedDateProvider);
                  ref.read(eventsProvider.notifier).addEvent(
                        selectedDate,
                        EventDetail(
                          title: eventController.text,
                        ),
                      );
                  Navigator.of(context).pop();
                }
              },
              child: Text(l10ns.add),
            ),
          ),
        ],
      ),
    );
  }
}
