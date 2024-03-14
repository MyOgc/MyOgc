import 'package:my_golf_app/models/round.dart';

class Game extends Event {
  final String gameName;
  final String circleName;
  final int? finalScores;
  // final int? scores;
  final List<Round> rounds;
  final DateTime endDate;
  final int? positioning;
  final int id;

  Game({
    required this.id,
    required this.gameName,
    required this.circleName,
    required super.date,
    required this.endDate,
    required this.rounds,
    this.positioning,
    this.finalScores,
    // this.scores,
  });

  get initialDate => null;

  Game copyWith({
    String? gameName,
    String? circleName,
    int? finalScores,
    int? scores,
    List<Round>? rounds,
    DateTime? date,
    DateTime? endDate,
    int? positioning,
  }) {
    return Game(
      id: id,
      gameName: gameName ?? this.gameName,
      circleName: circleName ?? this.circleName,
      date: date ?? this.date,
      finalScores: finalScores,
      // scores: scores ?? this.scores,
      rounds: rounds ?? this.rounds,
      endDate: endDate ?? this.endDate,
      positioning: positioning ?? this.positioning,
    );
  }

  @override
  String toString() {
    return 'id: $id\ndate: $date, endDate: $endDate, gameName: $gameName, circleName: $circleName, finalScores: $finalScores, rounds: $rounds, positioning: $positioning';
  }
}

class Event {
  // final String id = DateTime.now().millisecondsSinceEpoch.toString();
  final DateTime date;

  Event({
    required this.date,
  });

  @override
  String toString() {
    return 'date: $date';
  }
}
