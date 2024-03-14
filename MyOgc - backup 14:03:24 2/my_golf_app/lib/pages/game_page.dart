import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/pages/round_detail_page.dart';
import 'package:my_golf_app/pages/round_edit_page.dart';
import 'package:my_golf_app/pages/summary_game_page.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/utiles/utiles.dart';
import 'package:my_golf_app/widget/container_forms_layout.dart';
import 'package:my_golf_app/widget/custom_text_form_field.dart';
import 'package:my_golf_app/widget/elevated_form_button.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.gameId});

  static const routeName = '/game';
  final String gameId;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _gap = const SizedBox(
    width: 20,
    height: 20,
  );

  final _minGap = const SizedBox(
    width: 10,
    height: 10,
  );

  final _maxGap = const SizedBox(
    width: 150,
    height: 150,
  );

  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _positioningValueController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  final _positioningValueController = TextEditingController();

  List<Widget> _roundsBody(ThemeData theme, List<Round> rounds) {
    return List<Widget>.generate(rounds.length, (index) {
      return Column(
        children: [
          Card(
            child: InkWell(
              onTap: () {
                myFocusNode.unfocus();
                context.push('${RoundDetailPage.routeName}/${widget.gameId}/${rounds[index].id}',
                    extra: index);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 15),
                width: double.infinity,
                height: 60,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giro ${index + 1}'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryColor),
                      ),
                      const Icon(
                        Icons.arrow_right_rounded,
                        size: 30,
                      ),
                    ]),
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutWidget(
      title: const Text('Gara', style: TextStyle(color: Colors.white)),
      body: ContainerFormsLayout(
          child: Consumer<GameProvider>(builder: (context, value, child) {
        final Game? game = value.getGame(int.parse(widget.gameId));
        if (game != null && game.positioning != null) {
          _positioningValueController.text = game.positioning.toString();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: const BoxConstraints(minHeight: 600),
                // decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Gara ${game?.gameName}'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColorDark,
                            letterSpacing: 0.5,
                          ),
                        )),
                    _minGap,
                    Row(children: [
                      Icon(
                        Icons.location_on,
                        size: 24,
                        color: theme.primaryColor,
                      ),
                      _minGap,
                      Text(
                        game != null ? game.circleName : '',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor),
                      ),
                    ]),
                    _minGap,
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 24,
                            color: theme.primaryColor,
                          ),
                          _gap,
                          Text(
                            'dal: ${game?.date.day} ${AppUtilities.mounthList[game != null ? game.date.month - 1 : 0]} ${game?.date.year} \nal: ${game?.endDate.day} ${AppUtilities.mounthList[game != null ? game.endDate.month - 1 : 0]} ${game?.endDate.year}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor),
                          ),
                        ]),
                    _gap,
                    _gap,
                    if (game != null && game.rounds.isNotEmpty)
                      CustomTextFormField(
                        focusNode: myFocusNode,
                        controller: _positioningValueController,
                        labelText: 'Piazzamento finale',
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    _minGap,
                    ..._roundsBody(theme, game != null ? game.rounds : []),
                    if (game != null && game.rounds.isNotEmpty)
                      Card(
                        child: InkWell(
                          onTap: () {
                            context.push('${SummaryGamePage.routeName}/${widget.gameId}',
                                extra: false);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, right: 15),
                            width: double.infinity,
                            height: 60,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'RIEPILOGO',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.primaryColorDark,
                                        fontSize: 18),
                                  ),
                                  const Icon(
                                    Icons.arrow_right_rounded,
                                    size: 30,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    game != null && game.rounds.isEmpty ? _maxGap : _minGap,
                    TextButton(
                      onPressed: () {
                        context.push(
                            '${RoundEditPage.routeName}/${widget.gameId}',
                            extra: false);
                      },
                      child: const Text(
                        '+ Aggiungi giro',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            ElevatedFormButton(
                text: 'Salva',
                onPressed: () {
                  value.updatePositioning(
                      _positioningValueController.text.isNotEmpty
                          ? int.parse(_positioningValueController.text)
                          : null,
                      int.parse(widget.gameId));
                  context.pop(2);
                }),
            const SizedBox(
              height: 10,
            ),
            ElevatedFormButton(
              text: 'Rimuovi gara',
              onPressed: () {
                _showDialog(
                  context,
                  title: const Text('Elimina gara'),
                  content:
                      const Text('Procedere con l\'eliminazione della gara?'),
                ).then((val) {
                  if (val) {
                    context.pop();
                    value.removeGames(int.parse(widget.gameId));
                  }
                });
              },
              isSaveButton: false,
            ),
          ],
        );
      })),
    );
  }

  _showDialog(context, {Widget? title, Widget? content}) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: [
                    CupertinoDialogAction(
                        onPressed: () => context.pop(),
                        child: const Text('Annulla')),
                    CupertinoDialogAction(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: const Text('Conferma')),
                  ],
                )
              : AlertDialog(
                  title: title,
                  content: content,
                  actions: [
                    TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Annulla')),
                    TextButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: const Text('Conferma')),
                  ],
                );
        }));
  }

  // onSavedForm() {}
}
