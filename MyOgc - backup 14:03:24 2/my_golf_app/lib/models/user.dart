import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/session.dart';

enum LevelPermissions { commission, trainer, athlete }

class User {
  // final String id = DateTime.now().millisecondsSinceEpoch.toString();
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final int serialNumber;
  final DateTime? birthDate;
  LevelPermissions levelPermissions;
  final Group? group;

  User({
    this.levelPermissions = LevelPermissions.commission,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.email,
    required this.serialNumber,
    this.birthDate,
    this.group,
  });
}

class CommissionUser extends User {
  // LevelPermissions levelPermissions = LevelPermissions.commission;
  final int id;

  CommissionUser({
    required this.id,
    required super.name,
    required super.surname,
    required super.email,
    required super.phoneNumber,
    required super.serialNumber,
    super.levelPermissions = LevelPermissions.commission,
  });
  @override
  String toString() {
    return 'CommissionUser\nid: $id\nname: $name\nsurname: $surname\nphoneNumber: $phoneNumber\nemail: $email\nserialNumber: $serialNumber\nlevelPermissions: $levelPermissions';
  }
}

class TrainerUser extends User {
  // LevelPermissions levelPermissions = LevelPermissions.trainer;
  final List<String>? athleteIds;
  final int id;
  TrainerUser({
    required this.id,
    required super.name,
    required super.surname,
    required super.phoneNumber,
    required super.email,
    required super.serialNumber,
    this.athleteIds,
    super.levelPermissions = LevelPermissions.trainer,
  });
  @override
  String toString() {
    return 'TrainerUser\nid: $id\nname: $name\nsurname: $surname\nphoneNumber: $phoneNumber\nemail: $email\nserialNumber: $serialNumber\nlevelPermissions: $levelPermissions\nathleteIds: $athleteIds';
  }
}

class AthleteUser extends User {
  // LevelPermissions levelPermissions = LevelPermissions.athlete;
  // final DateTime birthDate;
  // final Group group;

  final int id;
  final List<String> trainer;
  final List<int> trainingList;
  final List<int> gameList;
  final List<Session> sessionList;

  AthleteUser({
    required this.id,
    required super.name,
    required super.surname,
    required super.phoneNumber,
    required super.email,
    required super.serialNumber,
    required super.birthDate,
    required super.group,
    required this.trainer,
    this.trainingList = const [],
    this.gameList = const [],
    this.sessionList = const [],
    super.levelPermissions = LevelPermissions.athlete,
  });

  AthleteUser copyWith({
    String? name,
    String? surname,
    String? phoneNumber,
    String? email,
    int? serialNumber,
    DateTime? birthDate,
    Group? group,
    List<String>? trainer,
  }) {
    return AthleteUser(
        id: id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        serialNumber: serialNumber ?? this.serialNumber,
        birthDate: birthDate ?? this.birthDate,
        group: group ?? this.group,
        trainer: trainer ?? this.trainer);
  }

  addTraining(int idTraining) {
    trainingList.add(idTraining);
  }

  removeTraining(int idTraining) {
    trainingList.removeWhere((id) => id == idTraining);
  }

  addGame(int idGame) {
    trainingList.add(idGame);
  }

  removeGame(int idGame) {
    gameList.removeWhere((id) => id == idGame);
  }

  addSession(Session session) {
    sessionList.add(session);
  }

  removeSession(int index) {
    sessionList.removeAt(index);
  }

  @override
  String toString() {
    return 'AthleteUser\nid: $id\nname: $name\nsurname: $surname\nphoneNumber: $phoneNumber\nemail: $email\nserialNumber: $serialNumber\nlevelPermissions: $levelPermissions\nbirthDate: $birthDate\ngroup: $group\ntrainer: $trainer\ntrainingList: $trainingList\ngameList: $gameList\nsessionList: $sessionList';
  }
}
