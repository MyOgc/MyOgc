import 'package:flutter/material.dart';
import 'package:my_golf_app/models/event_type.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/providers/training.dart';
import 'package:my_golf_app/widget/event_card_item.dart';
import 'package:my_golf_app/widget/title_section.dart';
import 'package:provider/provider.dart';

class EventsListView extends StatelessWidget {
  const EventsListView(
      {super.key, required this.eventType, this.isReadOnly = false});

  final EventType eventType;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final title = isReadOnly
        ? eventType == EventType.game
            ? 'Gare'
            : 'Allenamenti'
        : eventType == EventType.game
            ? 'Le mie gare'
            : 'I miei allenamenti';

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleSection(
            title: title,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: _consumerBuilder(eventType),
            ),
          )
        ],
      ),
    );
  }

  _consumerBuilder(EventType type) {
    if (type == EventType.game) {
      return Consumer<GameProvider>(
        builder: (context, value, child) => ListView.builder(
            itemCount: value.gamesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: EventCardItem(
                  event: value.gamesList[index],
                  isReadOnly: isReadOnly,
                ),
              );
            }),
      );
    } else {
      return Consumer<TrainingProvider>(
        builder: (context, value, child) => ListView.builder(
            itemCount: value.trainingList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: EventCardItem(
                  event: value.trainingList[index],
                  isReadOnly: isReadOnly,
                ),
              );
            }),
      );
    }
  }
}
