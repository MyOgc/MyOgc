import 'package:flutter/material.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/models/session.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/utiles/utiles.dart';

class UserProvider extends ChangeNotifier {
  User _userData = AthleteUser(
      id: 111111111,
      name: 'Mirko',
      surname: 'Mattei',
      phoneNumber: '33333333333',
      email: 'mirko.mattei@email.it',
      serialNumber: 12344566,
      birthDate: DateTime.utc(1989, 6, 30),
      group: Group.gruppoUno,
      // gameList: [],
      // trainingList: [],
      trainer: [
        '12345'
      ],
      sessionList: [
        Session(
          id: 425254235,
          wagr: 100,
          odm: 200,
          ranking: 120,
          hcp: 21,
          initialDate: DateTime.utc(2023, 12, 31),
          finalDate: DateTime.utc(2024, 03, 31),
          campoTrainingPoints: [
            Round(
              fairway: 100,
              gir: 12,
              put: 2,
              scrumbleBuncker: 200,
              scrumble: 25,
              id: 434314234,
            ),
            Round(
              fairway: 15,
              gir: 130,
              put: 144,
              scrumbleBuncker: 232,
              scrumble: 1332,
              id: 54634643,
            ),
          ],
        ),
        Session(
          id: 5434524532,
          wagr: 300,
          odm: 100,
          ranking: 420,
          hcp: 2,
          initialDate: DateTime.utc(2023, 09, 31),
          finalDate: DateTime.utc(2023, 12, 31),
          campoTrainingPoints: [
            Round(
              fairway: 10,
              gir: 11,
              put: 12,
              scrumbleBuncker: 13,
              scrumble: 14,
              id: 54352552,
            ),
            Round(
              fairway: 1,
              gir: 13,
              put: 100,
              scrumbleBuncker: 21,
              scrumble: 13,
              id: 543543254,
            ),
            Round(
              fairway: 12,
              gir: 130,
              put: 10,
              scrumbleBuncker: 20,
              scrumble: 12,
              id: 54355234542,
            ),
          ],
        ),
      ]);

  get userData => _userData;

  setUserData(User newUSer) {
    _userData = newUSer;
    // notifyListeners();
  }

  List<Session> getSessionsList() {
    // final user = _userData as AthleteUser;
    // debugPrint('_userData: ${user.sessionList}');
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      return user.sessionList;
    }
    return [];
  }

  getSessionId(DateTime trainingDate) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      final index = user.sessionList.indexWhere((session) =>
          AppUtilities.compareDate(
              session.initialDate, session.finalDate, trainingDate));
      return user.sessionList[index].id;
    }
  }

  addSession(Session session) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      user.addSession(session);
      notifyListeners();
    }
  }

  updateSession(int sessionId, Session newSession) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      final index =
          user.sessionList.indexWhere((session) => session.id == sessionId);
      user.sessionList[index] = newSession;
      notifyListeners();
    }
  }

  deleteSession(int sessionId) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      user.sessionList.removeWhere((session) => session.id == sessionId);
      notifyListeners();
    }
  }

  getRound(int sessionId, int roundId) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      final index =
          user.sessionList.indexWhere((session) => session.id == sessionId);
      final roundIndex = user.sessionList[index].campoTrainingPoints
          .indexWhere((round) => round.id == roundId);
      final round = user.sessionList[index].campoTrainingPoints[roundIndex];
      return round;
    }
  }

  addRound(Round newRound, int sessionId) {
    debugPrint('------------------------------');
    debugPrint(
        'UserProvider.addRound - newRound: $newRound, sessionId: $sessionId');
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      final index =
          user.sessionList.indexWhere((session) => session.id == sessionId);
      user.sessionList[index].addCampoTraining(newRound);
      notifyListeners();
    }
  }

  updateRound(Round updatedRound, int sessionId) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      //  debugPrint('===============');
      //   debugPrint(
      //       'UserProvider.updateRound - user.sessionList: ${user.sessionList} - sessionId: $sessionId');
      final index = user.sessionList.indexWhere((session) {
        // debugPrint('===============');
        // debugPrint(
        //     'UserProvider.updateRound - indexWhere - session: $session - sessionId: $sessionId');
        return session.id == sessionId;
      });
      // debugPrint('===============');
      // debugPrint('UserProvider.updateRound - index: $index');
      // debugPrint('===============');
      // debugPrint('UserProvider.updateRound - campoTrainingPoints: ${user.sessionList[index].campoTrainingPoints}');
      // debugPrint('===============');
      final roundIndex =
          user.sessionList[index].campoTrainingPoints.indexWhere((round) {
        // debugPrint(
        //     'UserProvider.updateRound - indexWhere - round.id: ${round.id} - updatedRound.id: ${updatedRound.id}');
        // debugPrint('===============');
        return round.id == updatedRound.id;
      });
      // debugPrint('UserProvider.updateRound - roundIndex: $roundIndex');
      // debugPrint('===============');
      user.sessionList[index].campoTrainingPoints[roundIndex] = updatedRound;
      notifyListeners();
    }
  }

  deleteRound(int roundId, int sessionId) {
    if (_userData is AthleteUser) {
      final user = _userData as AthleteUser;
      final index =
          user.sessionList.indexWhere((session) => session.id == sessionId);
      user.sessionList[index].campoTrainingPoints
          .removeWhere((round) => round.id == roundId);
      notifyListeners();
    }
  }
}
