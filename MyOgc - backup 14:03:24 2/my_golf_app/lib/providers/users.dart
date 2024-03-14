import 'package:flutter/material.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';

class UsersProvider extends ChangeNotifier {
  List<AthleteUser> athletes = [
    AthleteUser(
      id: 5432535235432,
      name: 'Mario',
      surname: 'Rossi',
      phoneNumber: '45423545243',
      email: 'mario.rossi@emal.it',
      serialNumber: 1111,
      birthDate: DateTime.utc(2002, 2, 2),
      group: Group.gruppoUno,
      trainer: ['5454235234'],
    ),
    AthleteUser(
      id: 5532454523524,
      name: 'Valerio',
      surname: 'Verdi',
      phoneNumber: '45423545243',
      email: 'valerio.verdi@emal.it',
      serialNumber: 1112,
      birthDate: DateTime.utc(2012, 3, 2),
      group: Group.gruppoUno,
      trainer: ['5454235234'],
    ),
    AthleteUser(
        id: 543254524542523,
        name: 'Gianluca',
        surname: 'Giallini',
        phoneNumber: '45423545243',
        email: 'gian.gialli@emal.it',
        serialNumber: 1113,
        birthDate: DateTime.utc(2008, 2, 10),
        trainer: ['534234523'],
        group: Group.gruppoDue),
    AthleteUser(
        id: 542542354254,
        name: 'Bruno',
        surname: 'Marroni',
        phoneNumber: '45423545243',
        email: 'bruno.marroni@emal.it',
        serialNumber: 1114,
        birthDate: DateTime.utc(2006, 12, 2),
        trainer: ['534234523'],
        group: Group.gruppoTre),
  ];

  List<TrainerUser> trainers = [
    TrainerUser(
        id: 5454235234,
        name: 'Giovanni',
        surname: 'Storti',
        phoneNumber: '45423545243',
        email: 'maestro.uno@email.it',
        serialNumber: 2222),
    TrainerUser(
        id: 5432542345,
        name: 'Aldo',
        surname: 'Baglio',
        phoneNumber: '45423545243',
        email: 'maestro.due@email.it',
        serialNumber: 2223),
    TrainerUser(
        id: 534234523,
        name: 'Giacomo',
        surname: 'Poretti',
        phoneNumber: '45423545243',
        email: 'maestro.tre@email.it',
        serialNumber: 2224),
    TrainerUser(
        id: 54324532,
        name: 'Renato',
        surname: 'Quaglia',
        phoneNumber: '45423545243',
        email: 'maestro.quattro@email.it',
        serialNumber: 2225),
  ];

  List<CommissionUser> commissions = [
    CommissionUser(
        id: 42343224,
        name: 'Stefano',
        surname: 'Stefanini',
        phoneNumber: '45423545243',
        email: 'commissario.uno@email.it',
        serialNumber: 3333),
    CommissionUser(
        id: 4534235342,
        name: 'Francesca',
        surname: 'Franceschini',
        phoneNumber: '45423545243',
        email: 'commissario.due@email.it',
        serialNumber: 3334),
    CommissionUser(
        id: 43242314231,
        name: 'Marco',
        surname: 'Marchi',
        phoneNumber: '45423545243',
        email: 'commissario.tre@email.it',
        serialNumber: 3335),
    CommissionUser(
        id: 7543753,
        name: 'Rosa',
        surname: 'Rose',
        phoneNumber: '45423545243',
        email: 'commissario.quattro@email.it',
        serialNumber: 3336),
  ];

  List<AthleteUser> getAthletes() {
    // debugPrint('UsersProvider.getAthletes');
    return athletes
      ..sort(
          (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
  }

  List<AthleteUser> getAthletesForGroup(Group group) {
    // debugPrint('UsersProvider.getAthletesForGroup - group: $group');
    return athletes.where((athlete) => athlete.group == group).toList();
  }

  void addAthletes(AthleteUser newAthlete) {
    debugPrint('UsersProvider.addAthletes');
    athletes.add(newAthlete);
    notifyListeners();
  }

  void deleteAthlete(int athleteId) {
    debugPrint('UsersProvider.deleteAthlete');
    athletes.removeWhere((athlete) => athlete.id == athleteId);
    notifyListeners();
  }

  void updateAthlete(int athleteId, AthleteUser newAthlete) {
    debugPrint('UsersProvider.deleteAthlete');
    final athleteIndex = athletes.indexWhere((athlete) => athlete.id == athleteId);
    athletes[athleteIndex] = newAthlete;
    notifyListeners();
  }


  List<TrainerUser> getTrainer() {
    return trainers..sort(
          (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
  }


  void addTraining(TrainerUser newTrainer) {
    trainers.add(newTrainer);
    notifyListeners();
  }

  List<CommissionUser> getCommissioner() {
    return commissions..sort(
          (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
  }

  void addCommissioner(CommissionUser newCommissioner) {
    commissions.add(newCommissioner);
    notifyListeners();
  }
}
