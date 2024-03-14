import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/training.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/sessions_detail_page.dart';
import 'package:my_golf_app/providers/event.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/providers/training.dart';
import 'package:my_golf_app/providers/user.dart';
import 'package:my_golf_app/widget/event_card_item.dart';
import 'package:my_golf_app/widget/heading_title.dart';
import 'package:my_golf_app/widget/session_item_card.dart';
import 'package:provider/provider.dart';

import '../models/game.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTitle(userName: user.name),
        Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          // height: 400,
          child: const _SessionSection(),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const _EventsListSection()),
        ),
      ],
    );
  }
}

class _SessionSection extends StatelessWidget {
  const _SessionSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<UserProvider>(
      builder: (context, user, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DATI TRIMESTRALI',
                style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: theme.primaryColorDark),
              ),
              TextButton(
                  onPressed: () {
                    context.push(SessionsDetailPage.routeName);
                  },
                  child: Text(
                    'Visualizza tutti',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: theme.primaryColorDark),
                  ))
            ],
          ),
          if (user.userData.sessionList.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Center(
                child: Text('Non ci sono trimestri disponibili'),
              ),
            ),
          if (user.userData.sessionList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SessionItemCard(
                  title: 'WAGR',
                  value: '${user.userData.sessionList.last.wagr}',
                ),
                SessionItemCard(
                  title: 'ODM',
                  value: '${user.userData.sessionList.last.odm}',
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          if (user.userData.sessionList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SessionItemCard(
                  title: 'ranking',
                  value: '${user.userData.sessionList.last.ranking}',
                ),
                SessionItemCard(
                  title: 'HCP',
                  value: '${user.userData.sessionList.last.hcp}',
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _EventsListSection extends StatefulWidget {
  const _EventsListSection();

  @override
  State<_EventsListSection> createState() => _EventsListSectionState();
}

class _EventsListSectionState extends State<_EventsListSection> {
  Future<List<Event>>? _future;
  List<Game>? _gameList;
  List<Training>? _trainingList;

  @override
  void initState() {
    _future = Provider.of<EventProvider>(context, listen: false).getEvents();
    _gameList = Provider.of<GameProvider>(context, listen: false).gamesList;
    _trainingList = Provider.of<TrainingProvider>(context, listen: false).trainingList;
   Provider.of<EventProvider>(context, listen: false).setLastEvents(_gameList!, _trainingList!);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        ('Attività recenti').toUpperCase(),
        style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold, color: theme.primaryColorDark),
      ),
      const SizedBox(
        height: 10,
      ),
      FutureBuilder<List<Event>>(
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              snapshot.hashCode.toString(),
            );
          } else if (snapshot.hasData) {
            return Expanded(
                // height: 400,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: EventCardItem(
                          event: snapshot.data![index],
                          isReadOnly: false,
                        ),
                      );
                    }));
          } else {
            return const Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
            );
          }
        }),
        future: _future,
      ),
    ]);
  }
}
