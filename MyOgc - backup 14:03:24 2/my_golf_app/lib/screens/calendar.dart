import 'package:flutter/material.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/providers/training.dart';
import 'package:my_golf_app/utiles/utiles.dart';
import 'package:my_golf_app/widget/event_card_item.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/game.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, this.isReadOnly = false});

  final bool isReadOnly;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Event> events = [];

  late ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    // debugPrint('CalendarView.initState');
    _selectedDay = _focusedDay;
    // events = context.read<EventProvider>().events;
    final games = context.read<GameProvider>().gamesList;
    final training = context.read<TrainingProvider>().trainingList;
    events = [...games, ...training];
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  double fontSize = 16;

  List<Event> _getEventsForDay(DateTime day) {
    // debugPrint('CalendarView._getEventsForDay');
    return events.where((Event element) {
      if (element is Game) {
        // debugPrint('CalendarView._getEventsForDay - Game element: $element');
        // return (element.date.millisecondsSinceEpoch <=
        //         day.millisecondsSinceEpoch &&
        //     element.endDate.millisecondsSinceEpoch >=
        //         day.millisecondsSinceEpoch);
        return AppUtilities.compareDate(element.date, element.endDate, day);
      }
      // debugPrint('CalendarView._getEventsForDay - Training element: $element');
      //return element.date == day;
      return AppUtilities.isSameDate(element.date, day);
    }).toList();
  }

  // bool _compareDate(
  //     DateTime initialDate, DateTime endDate, DateTime actualDate) {
  //   // return (initialDate.millisecondsSinceEpoch <=
  //   //         actualDate.millisecondsSinceEpoch &&
  //   //     endDate.millisecondsSinceEpoch >= actualDate.millisecondsSinceEpoch);

  //   return (actualDate.isAfter(initialDate) && actualDate.isBefore(endDate)) ||
  //       (_isSameDate(initialDate, actualDate) || _isSameDate(endDate, actualDate));
  // }

  // bool _isSameDate(DateTime dayOne, DateTime dayTwo) {
  //   return dayOne.year == dayTwo.year &&
  //       dayOne.month == dayTwo.month &&
  //       dayOne.day == dayTwo.day;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Consumer2<GameProvider, TrainingProvider>(
        builder: (context, game, training, child) {
          // debugPrint(
          //     'CalendarView.build - Consumer - gameList:\n ${game.gamesList}');
          // debugPrint(
          //     'CalendarView.build - Consumer - trainingList:\n ${training.trainingList}');
          events = [...game.gamesList, ...training.trainingList];
          _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableCalendar(
                calendarBuilders: CalendarBuilders(
                  singleMarkerBuilder: (context, date, event) {
                    final isGameEvent = event is Game;
                    Color cor = isGameEvent
                        ? const Color.fromARGB(255, 249, 211, 116)
                        : const Color.fromARGB(255, 119, 198, 198);
                    return Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: cor),
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1.5, vertical: 3),
                    );
                  },
                ),
                calendarFormat: _calendarFormat,
                calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(fontSize: fontSize),
                    weekendTextStyle: TextStyle(fontSize: fontSize),
                    outsideTextStyle:
                        TextStyle(fontSize: fontSize, color: Colors.grey[500]),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                        fontSize: fontSize,
                        color: Theme.of(context).primaryColorDark),
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      shape: BoxShape.circle,
                    )),
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2025, 1, 1),
                locale: 'it_IT',
                eventLoader: _getEventsForDay,
                daysOfWeekHeight: 50,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: const HeaderStyle(
                    titleCentered: true, formatButtonVisible: false),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _selectedEvents.value = _getEventsForDay(selectedDay);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Eventi in programma',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      if (value.isEmpty) {
                        return const Center(
                          child: Text(
                            'Nessun evento in programma.',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return EventCardItem(
                                event: value[index],
                                isReadOnly: widget.isReadOnly);
                          },
                        );
                      }
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
