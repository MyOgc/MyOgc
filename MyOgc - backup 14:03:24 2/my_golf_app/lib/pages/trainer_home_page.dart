import 'package:flutter/material.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/models/users_type.dart';
import 'package:my_golf_app/screens/users_list.dart';
import 'package:my_golf_app/widget/heading_title.dart';
import 'package:my_golf_app/widget/logo_text.dart';

class TrainerHomePage extends StatefulWidget {
  const TrainerHomePage({super.key, required this.user});

  static const routeName = '/trainer-home';
  final User user;

  @override
  State<TrainerHomePage> createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  List<User> items = [];

  List<AthleteUser> athletes = [
    AthleteUser(
      id: 5435254352,
      name: 'Mario',
      surname: 'Rossi',
      phoneNumber: '45423545243',
      email: 'mario.rossi@emal.it',
      serialNumber: 1111,
      birthDate: DateTime.utc(2002, 2, 2),
      group: Group.gruppoUno,
      trainer: ['415245t235t34'],
    ),
    AthleteUser(
      id: 543535325435,
      name: 'Valerio',
      surname: 'Verdi',
      phoneNumber: '45423545243',
      email: 'valerio.verdi@emal.it',
      serialNumber: 1112,
      birthDate: DateTime.utc(2012, 3, 2),
      group: Group.gruppoUno,
      trainer: ['415245t235t34'],
    ),
    AthleteUser(
        id: 54235345432543,
        name: 'Gianluca',
        surname: 'Giallini',
        phoneNumber: '45423545243',
        email: 'gian.gialli@emal.it',
        serialNumber: 1113,
        birthDate: DateTime.utc(2008, 2, 10),
        trainer: ['415245t235t34'],
        group: Group.gruppoDue),
    AthleteUser(
        id: 542334,
        name: 'Bruno',
        surname: 'Marroni',
        phoneNumber: '45423545243',
        email: 'bruno.marroni@emal.it',
        serialNumber: 1114,
        birthDate: DateTime.utc(2006, 12, 2),
        trainer: ['415245t235t34'],
        group: Group.gruppoTre),
  ];

  final _gap = const SizedBox(
    height: 10,
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: theme.primaryColor,
          title: Column(
            children: [
              const LogoText(
                titleColor: Colors.white,
              ),
              _gap,
              const HeadingTitle(userName: 'Maestro'),
            ],
          )),
      body: const UsersListView(
        usersType :UsersType.athlete,
      ),
    );
  }
}
