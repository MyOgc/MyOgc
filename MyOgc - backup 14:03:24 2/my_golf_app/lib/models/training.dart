import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/models/training_type.dart';

class Training extends Event {
  final double lessionHours;
  final List<TrainingType> trainingType;
  final Round? round;
  // final int? fairway;
  // final int? gir;
  // final int? put;
  // final int? bunker;
  // final int? scrumble;
  final int id;

  Training({
    required this.id,
    required this.lessionHours,
    required super.date,
    required this.trainingType,
    this.round,
    // this.fairway,
    // this.gir,
    // this.put,
    // this.bunker,
    // this.scrumble,
  });

  Training copyWith(
      {double? lessionHours,
      DateTime? date,
      List<TrainingType>? trainingType,
      Round? round,
      int? fairway,
      int? gir,
      int? put,
      int? bunker,
      int? scrumble}) {
    return Training(
      id: id,
      lessionHours: lessionHours ?? this.lessionHours,
      date: date ?? this.date,
      trainingType: trainingType ?? this.trainingType,
      round: round?.copyWith(
          fairway: round.fairway,
          gir: round.gir,
          put: round.put,
          scrumbleBuncker: round.scrumbleBuncker,
          scrumble: round.scrumble),
      // fairway: fairway,
      // gir: gir,
      // put: put,
      // bunker: bunker,
      // scrumble: scrumble,
    );
  }

  @override
  String toString() {
    return 'id: $id\nlessionHours: $lessionHours\n date: $date\n trainingType: $trainingType\nround: $round';
  }
}
