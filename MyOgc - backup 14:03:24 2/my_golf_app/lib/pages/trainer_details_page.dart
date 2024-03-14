import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/models/users_type.dart';
import 'package:my_golf_app/pages/profile_details_page.dart';
import 'package:my_golf_app/pages/trainer_edit_page.dart';
import 'package:my_golf_app/screens/users_list.dart';
import 'package:my_golf_app/widget/expandable_fab.dart';
import 'package:my_golf_app/widget/layout.dart';

class TrainerDetailsPage extends StatefulWidget {
  const TrainerDetailsPage({super.key});

  static const routeName = '/trainer-details';

  @override
  State<TrainerDetailsPage> createState() => _TrainerDetailsPageState();
}

class _TrainerDetailsPageState extends State<TrainerDetailsPage> {
  int _currentIndex = 0;

  List<Widget> views = [];

  @override
  void initState() {
    views = <Widget>[
      const TrainerDetailHomeView(),
      ProfileDetailsPage(
          user: TrainerUser(
            id: 54352542,
        name: 'Francesco',
        surname: 'Rossi',
        phoneNumber: '333333333',
        email: 'francesco.rossi@email.it',
        serialNumber: 121212121,
      )),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutWidget(
      title: const Text('Rossi Francesco',
          style: TextStyle(
            color: Colors.white,
          )),
      bottomNavigationBar: _userNavigationBar(Theme.of(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _currentIndex == 1
          ? ExpandableFab(
              distance: 112,
              children: [
                ActionButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.delete_outline_outlined),
                  color: theme.colorScheme.error,
                ),
                ActionButton(
                  onPressed: () =>
                      context.push(TrainerEditPage.routeName, extra: true),
                  icon: const Icon(Icons.edit),
                  color: const Color.fromARGB(255, 23, 104, 130),
                ),
              ],
            )
          : null,
      body: views.elementAt(_currentIndex),
    );
  }

  NavigationBar _userNavigationBar(ThemeData theme) {
    final Color color = theme.primaryColor;
    double fontSize = 28;

    return NavigationBar(
      height: 45,
      destinations: <Widget>[
        NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.home,
              color: color,
              size: fontSize,
            ),
            label: 'Home'),
        NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.person,
              color: color,
              size: fontSize,
            ),
            label: 'Profilo'),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      indicatorColor: theme.primaryColorLight,
      surfaceTintColor: Colors.transparent,
      selectedIndex: _currentIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    );
  }
}

class TrainerDetailHomeView extends StatelessWidget {
  const TrainerDetailHomeView({super.key});

  final _gap = const SizedBox(
    width: 10,
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
    // List<AthleteUser> athletes = [
    //   AthleteUser(
    //     id: 432143521,
    //     name: 'Mario',
    //     surname: 'Rossi',
    //     phoneNumber: '45423545243',
    //     email: 'mario.rossi@emal.it',
    //     serialNumber: 1111,
    //     birthDate: DateTime.utc(2002, 2, 2),
    //     group: Group.gruppoUno,
    //     trainer: ['415245t235t34'],
    //   ),
    //   AthleteUser(
    //     id: 5423245,
    //     name: 'Valerio',
    //     surname: 'Verdi',
    //     phoneNumber: '45423545243',
    //     email: 'valerio.verdi@emal.it',
    //     serialNumber: 1112,
    //     birthDate: DateTime.utc(2012, 3, 2),
    //     group: Group.gruppoUno,
    //     trainer: ['415245t235t34'],
    //   ),
    //   AthleteUser(
    //       id: 5432534521,
    //       name: 'Gianluca',
    //       surname: 'Giallini',
    //       phoneNumber: '45423545243',
    //       email: 'gian.gialli@emal.it',
    //       serialNumber: 1113,
    //       birthDate: DateTime.utc(2008, 2, 10),
    //       trainer: ['415245t235t34'],
    //       group: Group.gruppoDue),
    //   AthleteUser(
    //       id: 544354524,
    //       name: 'Bruno',
    //       surname: 'Marroni',
    //       phoneNumber: '45423545243',
    //       email: 'bruno.marroni@emal.it',
    //       serialNumber: 1114,
    //       birthDate: DateTime.utc(2006, 12, 2),
    //       trainer: ['415245t235t34'],
    //       group: Group.gruppoTre),
    // ];

    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Francesco Rossi',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.primaryColorDark,
                fontSize: 22),
          ),
          Text(
            'Maestro',
            style: TextStyle(color: theme.primaryColor),
          ),
          _gap,
          _gap,
          _gap,
          Text(
            'Lista allievi',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark),
          ),
          const Expanded(
            child: UsersListView(
              usersType: UsersType.athlete,
            ),
          ),
        ],
      ),
    );
  }
}
