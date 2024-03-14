import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/event_type.dart';
import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/models/session.dart';
import 'package:my_golf_app/models/training.dart';
import 'package:my_golf_app/models/training_type.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/athlete_edit_page.dart';
import 'package:my_golf_app/pages/profile_details_page.dart';
import 'package:my_golf_app/pages/sessions_detail_page.dart';
import 'package:my_golf_app/screens/calendar.dart';
import 'package:my_golf_app/screens/events_list.dart';
import 'package:my_golf_app/widget/event_card_item.dart';
import 'package:my_golf_app/widget/expandable_fab.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:my_golf_app/widget/session_widget.dart';

class AthleteDetailsPage extends StatefulWidget {
  const AthleteDetailsPage({super.key});

  static const routeName = '/athlete-details';

  @override
  State<AthleteDetailsPage> createState() => _AthleteDetailsPageState();
}

class _AthleteDetailsPageState extends State<AthleteDetailsPage> {
  int _currentIndex = 0;

  List<Widget> views = [];

  @override
  void initState() {
    // debugPrint('${widget.user}');
    // debugPrint('${widget.user.levelPermissions == LevelPermissions.athlete}');
    // levelPermissionsUser = widget.user.levelPermissions;

    views = <Widget>[
      const AthleteDetailHomeView(),
      const CalendarView(
        isReadOnly: true,
      ),
      const EventsListView(eventType: EventType.game, isReadOnly: true),
      const EventsListView(eventType: EventType.training, isReadOnly: true),
      ProfileDetailsPage(
          user: AthleteUser(
              id: 4325312431,
              name: 'Francesco',
              surname: 'Rossi',
              phoneNumber: '333333333',
              email: 'francesco.rossi@email.it',
              serialNumber: 121212121,
              birthDate: DateTime.utc(2010, 1, 1),
              group: Group.gruppoUno,
              trainer: ['1234'])),
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
      floatingActionButton: _currentIndex == 4
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
                      context.push(AthleteEditPage.routeName, extra: true),
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
    // TextStyle textMenuStyle = const TextStyle(fontSize: 18);
    String svgPic = 'assets/images/svg/sports_golf.svg';
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
              Icons.calendar_month_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.calendar_month,
              color: color,
              size: fontSize,
            ),
            label: 'Calendario'),
        NavigationDestination(
            icon: Icon(
              Icons.emoji_events_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.emoji_events,
              color: color,
              size: fontSize,
            ),
            label: 'Gare'),
        NavigationDestination(
            icon: Icon(
              Icons.sports_golf_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: SvgPicture.asset(
              svgPic,
              height: fontSize,
              // ignore: deprecated_member_use
              color: color,
            ),
            label: 'Allenamento'),
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

class AthleteDetailHomeView extends StatelessWidget {
  const AthleteDetailHomeView({super.key});

  final _gap = const SizedBox(
    width: 10,
    height: 10,
  );

  @override
  Widget build(BuildContext context) {
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
            'Atleta',
            style: TextStyle(color: theme.primaryColor),
          ),
          _gap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dati trimestrali attuali'.toUpperCase(),
                style: TextStyle(
                    color: theme.primaryColorDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              TextButton(
                child: const Text('visualizza tutti'),
                onPressed: () => context.push(SessionsDetailPage.routeName),
              ),
            ],
          ),
          _gap,
          SessionWidget(
            session: Session(
              id: 65464643563,
              wagr: 100,
              hcp: 200,
              odm: 300,
              ranking: 200,
              initialDate: DateTime.utc(2023, 12, 2),
              finalDate: DateTime.utc(2024, 2, 2),
            ),
          ),
          _gap,
          _gap,
          _gap,
          // ProfileDetailSession(),
          // OptionsBody(gap: _gap),
          const _EventsListSection()
        ],
      ),
    );
  }
}

class OptionsBody extends StatelessWidget {
  const OptionsBody({super.key, required this.gap});
  final SizedBox gap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // OptionsItem(
        //   icon: Icons.calendar_month_outlined,
        //   label: 'Calendario eventi',
        //   onTap: () => context.push(ProfilePage.routeName),
        // ),
        // gap,
        // OptionsItem(
        //   icon: Icons.emoji_events_outlined,
        //   label: 'Lista gare',
        //   onTap: () => context.push(ProfilePage.routeName),
        // ),
        // gap,
        // OptionsItem(
        //   icon: Icons.sports_golf_outlined,
        //   label: 'Lista allenamenti',
        //   onTap: () => context.push(ProfilePage.routeName),
        // ),
        // gap,
        OptionsItem(
          icon: Icons.person_outline,
          label: 'Profilo',
          onTap: () => context.push(ProfileDetailsPage.routeName,
              extra: AthleteUser(
                  id: 54335435,
                  name: 'Francesco',
                  surname: 'Rossi',
                  phoneNumber: '333333333',
                  email: 'francesco.rossi@email.it',
                  serialNumber: 121212121,
                  birthDate: DateTime.utc(2010, 1, 1),
                  group: Group.gruppoUno,
                  trainer: ['1234'])),
        ),
      ],
    );
  }
}

class OptionsItem extends StatelessWidget {
  const OptionsItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.onTap});

  final String label;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Theme.of(context).primaryColorLight,
      child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 28),
                      const SizedBox(width: 25),
                      Text(label),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                  )
                ]),
          )),
    );
  }
}

// class ProfileDetailSession extends StatelessWidget {
//   const ProfileDetailSession({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: Colors.grey.shade200),
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ProfileField(
//             title: 'N. tessera',
//             value: '101010101',
//           ),
//           Divider(),
//           ProfileField(
//             title: 'Data di nascita',
//             value: '30 Giugno 2010',
//           ),
//           Divider(),
//           ProfileField(
//             title: 'Numero di telefono',
//             value: '333 3333333',
//           ),
//           Divider(),
//           ProfileField(
//             title: 'E-mail',
//             value: 'nome.cognome@email.it',
//           ),
//           Divider(),
//           ProfileField(
//             title: 'Allenatore',
//             value: 'Mario Merola',
//           ),
//         ],
//       ),
//     );
//   }
// }
class _EventsListSection extends StatelessWidget {
  const _EventsListSection();

  @override
  Widget build(BuildContext context) {
    final events = [
      Game(
          date: DateTime.now(),
          endDate: DateTime.now(),
          gameName: 'Gara Prova 1',
          circleName: 'Circolo di test 1',
          finalScores: 100,
          positioning: 5,
          id: 46342643,
          rounds: [
            Round(
                id: 5435,
                fairway: 10,
                gir: 20,
                put: 30,
                scrumbleBuncker: 40,
                scrumble: 50)
          ]),
      Training(
        id: 123242143,
        date: DateTime.now(),
        lessionHours: 10,
        trainingType: [TrainingType.put],
      ),
      Game(
          date: DateTime.now(),
          endDate: DateTime.now(),
          gameName: 'Gara Prova 2',
          circleName: 'Circolo di test 2',
          finalScores: 100,
          positioning: 10,
          id: 643233643,
          rounds: [
            Round(
                id: 543254,
                fairway: 10,
                gir: 20,
                put: 30,
                scrumbleBuncker: 40,
                scrumble: 50)
          ]),
      Game(
          date: DateTime.now(),
          endDate: DateTime.now(),
          gameName: 'Gara Prova 3',
          circleName: 'Circolo di test 3',
          finalScores: 100,
          positioning: 20,
          id: 54363453,
          rounds: [
            Round(
                id: 534123,
                fairway: 10,
                gir: 20,
                put: 30,
                scrumbleBuncker: 40,
                scrumble: 50)
          ]),
      Game(
          date: DateTime.now(),
          endDate: DateTime.now(),
          gameName: 'Gara Prova 3',
          circleName: 'Circolo di test 3',
          positioning: 2,
          finalScores: 100,
          // finalScore: 200,
          id: 654366534,
          rounds: [
            Round(
                id: 324324,
                fairway: 10,
                gir: 20,
                put: 30,
                scrumbleBuncker: 40,
                scrumble: 50)
          ]),
      Game(
          date: DateTime.now(),
          endDate: DateTime.now(),
          gameName: 'Gara Prova 3',
          circleName: 'Circolo di test 3',
          positioning: 1,
          finalScores: 100,
          // scores: 200,
          id: 6543436,
          rounds: [
            Round(
                id: 43243,
                fairway: 10,
                gir: 20,
                put: 30,
                scrumbleBuncker: 40,
                scrumble: 50)
          ]),
      Training(
        id: 123242141,
        date: DateTime.now(),
        lessionHours: 10,
        trainingType: [
          TrainingType.put,
          TrainingType.giocoCorto,
          TrainingType.campo
        ],
      ),
    ];

    final theme = Theme.of(context);
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        ('Attività recenti').toUpperCase(),
        style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold, color: theme.primaryColorDark),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        // height: 400,
        child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: EventCardItem(event: events[index], isReadOnly: true),
              );
            }),
      ),
    ]));
  }
}
