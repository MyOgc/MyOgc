import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/pages/game_edit_page.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/utiles/utiles.dart';
import 'package:my_golf_app/widget/game_points_body.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class SummaryGamePage extends StatefulWidget {
  const SummaryGamePage(
      {super.key, this.isReadOnly = false, required this.gameId});

  static const routeName = '/summary-game';

  final bool isReadOnly;
  final String gameId;

  @override
  State<SummaryGamePage> createState() => _SummaryGamePagdState();
}

class _SummaryGamePagdState extends State<SummaryGamePage> {
  final _gap = const SizedBox(
    width: 10,
    height: 10,
  );

  Game? game;

  // Future<Game?>? _gameFuture;

  @override
  void initState() {
    super.initState();
  }

  final horizotalPadding = 30.0;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutWidget(
      title:
          const Text('Riepilogo gara', style: TextStyle(color: Colors.white)),
      body: Container(
        padding:
            EdgeInsets.symmetric(vertical: 10, horizontal: horizotalPadding),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Consumer<GameProvider>(builder: (context, value, _) {
          final Game? game = value.getGame(int.parse(widget.gameId));
          Round? totalGamesPoints;
          if (game!.rounds.isNotEmpty) {
            totalGamesPoints = game.rounds.reduce((value, element) {
              return Round(
                  id: DateTime.now().millisecond,
                  fairway: value.fairway! + element.fairway!,
                  gir: value.gir! + element.gir!,
                  put: value.put! + element.put!,
                  scrumbleBuncker:
                      value.scrumbleBuncker! + element.scrumbleBuncker!,
                  scrumble: value.scrumble! + element.scrumble!);
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryGameHeading(
                theme: theme,
                gap: const SizedBox(
                  height: 5,
                  width: 10,
                ),
                game: game,
                isReadOnly: widget.isReadOnly,
              ),
              _gap,
              _gap,
              //_gap,
              if (totalGamesPoints != null)
                Text('Dettagli punteggio'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColorDark)),
              _gap,
              if (totalGamesPoints != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SummaryFinalScoresCard(
                        theme: theme,
                        label: 'piazzamento',
                        value: game.positioning),
                    _gap,
                    SummaryFinalScoresCard(
                        theme: theme, label: 'scores', value: game.finalScores),
                  ],
                ),
              _gap,
              _gap,
              // _gap,
              totalGamesPoints != null
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          game.rounds.length + 1,
                          (int index) {
                            return index == game.rounds.length
                                ? ChoiceChip(
                                    label: const Text('TOTALE'),
                                    selected: _currentIndex == index,
                                    checkmarkColor: Colors.white,
                                    labelStyle: _currentIndex == index
                                        ? const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: theme.primaryColorDark,
                                            fontWeight: FontWeight.bold),
                                    selectedColor: theme.primaryColor,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _currentIndex = game.rounds.length;
                                      });
                                    },
                                  )
                                : ChoiceChip(
                                    label: Text('Giro ${index + 1}'),
                                    selected: _currentIndex == index,
                                    checkmarkColor: Colors.white,
                                    labelStyle: _currentIndex == index
                                        ? const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color: theme.primaryColorDark,
                                            fontWeight: FontWeight.bold),
                                    selectedColor: theme.primaryColor,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  );
                          },
                        ).toList(),
                      ),
                    )
                  : const Center(child: Text('Nessun punteggio disponibile')),
              _gap,
              if (totalGamesPoints != null)
                GamePointsBody(
                    round: _currentIndex == game.rounds.length
                        ? totalGamesPoints
                        : game.rounds[_currentIndex]),
            ],
          );
        }),
      ),
    );
  }
}

class SummaryFinalScoresCard extends StatelessWidget {
  const SummaryFinalScoresCard({
    super.key,
    required this.theme,
    required this.label,
    this.value,
  });

  final ThemeData theme;
  final String label;
  final int? value;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Card(
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
          // height: 110,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  label.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                      fontSize: 14),
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              value != null ? '$value' : '- -',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: theme.primaryColorDark),
            )
          ]),
        ),
      ),
    );
  }
}

class _SummaryGameHeading extends StatelessWidget {
  const _SummaryGameHeading({
    required this.theme,
    required SizedBox gap,
    required this.game,
    required this.isReadOnly,
  }) : _gap = gap;

  final ThemeData theme;
  final SizedBox _gap;
  final Game game;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Text(
      //   'Riepilogo gara ${game.gameName}'.toUpperCase(),
      //   style: TextStyle(
      //       fontWeight: FontWeight.bold, color: theme.primaryColorDark),
      // ),
      // _gap,
      Row(
        children: [
          Icon(
            Icons.emoji_events_rounded,
            size: 20,
            color: theme.primaryColorDark,
          ),
          _gap,
          Text(
            game.gameName.toUpperCase(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.primaryColorDark),
          ),
          const Expanded(child: SizedBox()),
          if (!isReadOnly)
            TextButton(
              child: const Text('Modifica', style: TextStyle(fontSize: 15)),
              onPressed: () {
                context.push('${GameEditPage.routeName}/${game.id}',
                    extra: true);
              },
            ),
        ],
      ),
      Row(children: [
        Icon(
          Icons.location_on,
          size: 20,
          color: theme.primaryColor,
        ),
        _gap,
        Text(
          game.circleName,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor),
        ),
      ]),
      _gap,
      _gap,
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(
          Icons.calendar_month_outlined,
          size: 20,
          color: theme.primaryColor,
        ),
        _gap,
        Text(
          'inizio: ${game.date.day} ${AppUtilities.mounthList[game.date.month - 1]} ${game.date.year} \nfine: ${game.endDate.day} ${AppUtilities.mounthList[game.endDate.month - 1]} ${game.endDate.year}',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor),
        ),
      ]),
    ]);
  }
}
