import 'package:flutter/material.dart';
import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/models/round.dart';

class GameProvider extends ChangeNotifier {
  final List<Game> _gamesList = [
    Game(
      gameName: 'gameName 1',
      circleName: 'circleName 1',
      finalScores: 10,
      positioning: 1,
      rounds: [
        Round(id: 3443, fairway: 10, gir: 10, put: 10, scrumbleBuncker: 10, scrumble: 12),
        Round(id: 3444, fairway: 13, gir: 1, put: 20, scrumbleBuncker: 30, scrumble: 2),
      ],
      endDate: DateTime.utc(2024, 2, 4),
      date: DateTime.utc(2024, 2, 1),
      id: 54265635635,
    ),
    Game(
        gameName: 'gameName 2',
        circleName: 'circleName 2',
        finalScores: 5,
        positioning: 10,
        rounds: [],
        endDate: DateTime.utc(2024, 2, 21),
        date: DateTime.utc(2024, 2, 21),
        id: 54265635634),
    Game(
        gameName: 'gameName 3',
        circleName: 'circleName 3',
        finalScores: 7,
        positioning: 3,
        rounds: [],
        endDate: DateTime.utc(2024, 2, 11),
        date: DateTime.utc(2024, 2, 10),
        id: 54265635),
  ];

  int _roundIndex = 0;

  List<Game> get gamesList {
    _gamesList.sort((a, b) => b.date.compareTo(a.date));
    return _gamesList;
  }

  Game? getGame(int gameId) {
    List<Game> list =
        _gamesList.where((training) => training.id == gameId).toList();
    if (list.isEmpty) return null;
    return list[0];
  }

  Future<Game?>? getGameFuture(int gameId) async {
    List<Game> list =
        _gamesList.where((training) => training.id == gameId).toList();
    if (list.isEmpty) {
      return await Future.delayed(
        const Duration(seconds: 2),
        () => null,
      );
    }
    return await Future.delayed(
      const Duration(seconds: 2),
      () => list[0],
    );
  }

  addGames(Game game) {
    _gamesList.add(game);
    notifyListeners();
  }

  removeGames(int id) {
    _gamesList.removeWhere((Game game) => game.id == id);
    notifyListeners();
  }

  updateGame(Game newGame, int oldGameId) {
    int index = _gamesList.indexWhere((game) => game.id == oldGameId);
    _gamesList[index] = newGame;
    notifyListeners();
  }

  addRound(Round round, int gameId) {
    int index = _gamesList.indexWhere((game) => game.id == gameId);
    _gamesList[index].rounds.add(round);
    notifyListeners();
  }

  updateRound(Round newRound, int gameId, int roundId) {
    int gameIndex = _gamesList.indexWhere((game) => game.id == gameId);
    int roundIndex =
        _gamesList[gameIndex].rounds.indexWhere((round) => round.id == roundId);
    _roundIndex = roundIndex + 1;
    _gamesList[gameIndex].rounds[roundIndex] = newRound;

    notifyListeners();
  }

  removeRound(int roundId, int gameId) {
    int index = _gamesList.indexWhere((game) => game.id == gameId);
    _gamesList[index].rounds.removeWhere((round) => round.id == roundId);
    notifyListeners();
  }

  updatePositioning(int? positioning, int id) {
    int index = _gamesList.indexWhere((game) => game.id == id);
    _gamesList[index] = _gamesList[index].copyWith(positioning: positioning);
    notifyListeners();
  }

  Round? getRound(int roundId, int gameId) {
    Round? round;
    // debugPrint('GameProvider.getRound - roundid: $roundId, gameId: $gameId');
    int gameIndex = _gamesList.indexWhere((game) => game.id == gameId);
    // debugPrint('GameProvider.getRound - gameIndex: $gameIndex');
    int roundIndex =
        _gamesList[gameIndex].rounds.indexWhere((round) => round.id == roundId);
    _roundIndex = roundIndex + 1;

    if (roundIndex == -1) return null;
    round = _gamesList[gameIndex].rounds[roundIndex];
    // debugPrint('GameProvider.getRound - roundIndex: $roundIndex');
    // debugPrint('GameProvider.getRound - _gamesList[gameIndex].rounds[roundIndex]: ${_gamesList[gameIndex].rounds[roundIndex]}');
    return round;
  }

  int getLastRoundIndex(int gameId) {
    int gameIndex = _gamesList.indexWhere((game) => game.id == gameId);
    return _gamesList[gameIndex].rounds.length;
  }

  int get getRoundIndex => _roundIndex;
}
