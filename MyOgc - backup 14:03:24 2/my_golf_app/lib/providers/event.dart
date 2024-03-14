import 'package:flutter/material.dart';
import 'package:my_golf_app/models/training.dart';
import 'package:my_golf_app/models/training_type.dart';

import '../models/game.dart';

class EventProvider extends ChangeNotifier {
   List<Event> _lastEvents = [
    Training(
      id: 1233445,
      lessionHours: 2,
      date: DateTime.utc(2024, 2, 20),
      trainingType: [TrainingType.fairway],
    ),
    Game(
        gameName: 'gameName 1',
        circleName: 'circleName 1',
        finalScores: 1,
        positioning: 1,
        rounds: [],
        endDate: DateTime.utc(2024, 2, 4),
        date: DateTime.utc(2024, 2, 1),
        id: 54534),
    Game(
      gameName: 'gameName 2',
      circleName: 'circleName 2',
      finalScores: 5,
      positioning: 10,
      rounds: [],
      endDate: DateTime.utc(2024, 2, 21),
      date: DateTime.utc(2024, 2, 21),
      id: 542665436,
    ),
    Training(
      id: 1233441,
      lessionHours: 2,
      date: DateTime.utc(2024, 2, 10),
      trainingType: [TrainingType.fairway],
    ),
    Game(
      gameName: 'gameName3 ',
      circleName: 'circleName 3',
      finalScores: 7,
      positioning: 3,
      rounds: [],
      endDate: DateTime.utc(2024, 2, 11),
      date: DateTime.utc(2024, 2, 10),
      id: 656535634,
    ),
    Training(
      id: 1233447,
      lessionHours: 4,
      date: DateTime.utc(2024, 3, 20),
      trainingType: [TrainingType.fairway],
    ),
    Training(
      id: 12334234,
      lessionHours: 5,
      date: DateTime.utc(2024, 3, 20),
      trainingType: [TrainingType.fairway],
    ),
  ];

  List<Event> get events => _lastEvents;

  Future<List<Event>> getEvents() async {
    debugPrint('EventProvider.getEvents');
    return await Future.delayed(const Duration(seconds: 2), () {
      events.sort(((a, b) => b.date.compareTo(a.date)));
      return events;
    });
  }

  // void addEvent(Event event) {
  //   bool isIncluded = AppUtilities.compareDate(
  //       events.last.date, events.first.date, event.date);
  //        debugPrint('EventProvider.addEvent - isIncluded: $isIncluded');
  //   if (isIncluded) {
  //     if (_lastEvents.length == 10) {
  //       _lastEvents.removeLast();
  //     }
  //     _lastEvents.add(event);
  //   }
  //   notifyListeners();
  // }

  void setLastEvents(List<Game> gameList, List<Training> trainingList){
    final totalEvents = [...gameList,...trainingList];
    totalEvents.sort((a, b) => b.date.compareTo(a.date));
    if(totalEvents.length > 11){
    _lastEvents = totalEvents.getRange(0,10).toList();
    } else {
      _lastEvents = totalEvents;
    }
  }
}
