import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/pages/round_edit_page.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/widget/expandable_fab.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:my_golf_app/widget/training_campo_item.dart';
import 'package:provider/provider.dart';

class RoundDetailPage extends StatelessWidget {
  const RoundDetailPage(
      {super.key, required this.roundId, required this.gameId, required this.index});

  final String roundId;
  final String gameId;
  final int index;

  static const routeName = '/round-detail';

  final _gap = const SizedBox(
    height: 20,
    width: 20,
  );

  _showDialog(context, {Widget? title, Widget? content}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: title,
                content: content,
                actions: [
                  CupertinoDialogAction(
                      onPressed: () => context.pop(false),
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
                      onPressed: () => context.pop(false),
                      child: const Text('Annulla')),
                  TextButton(
                      onPressed: () {
                        context.pop(true);
                      },
                      child: const Text('Conferma')),
                ],
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutWidget(
      title:
          const Text('Dettaglio giro', style: TextStyle(color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () => _showDialog(context,
                    title: const Text('Elimina giro'),
                    content:
                        const Text('Procedere con l\'eliminazione del giro?'))
                .then((value) {
              if (value) {
                context.pop();
                Provider.of<GameProvider>(context, listen: false)
                    .removeRound(int.parse(roundId), int.parse(gameId));
              }
            }),
            icon: const Icon(Icons.delete_outline_outlined),
            color: theme.colorScheme.error,
          ),
          ActionButton(
            onPressed: () => {
              context.push('${RoundEditPage.routeName}/$gameId/$roundId',
                  extra: true)
            },
            icon: const Icon(Icons.edit),
            color: const Color.fromARGB(255, 23, 104, 130),
          ),
        ],
      ),
      body: Center(
        child: Container(
          // decoration: BoxDecoration(border: Border.all()),
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 1000),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Consumer<GameProvider>(builder: (context, value, child) {
              final Round? round = value.getRound(int.parse(roundId), int.parse(gameId));
              // debugPrint(round.toString());
              //final int index = round != null ? value.getRoundIndex : 0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Dettaglio Giro ${index + 1}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColorDark,
                      letterSpacing: 0.5,
                    ),
                  ),
                  _gap,
                  _TrainingCampoBody(
                    theme: theme,
                    gap: _gap,
                    fairway: round?.fairway,
                    gir: round?.gir,
                    put: round?.put,
                    bunker: round?.scrumbleBuncker,
                    scrumble: round?.scrumble,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TrainingCampoBody extends StatelessWidget {
  const _TrainingCampoBody(
      {required this.theme,
      required this.gap,
      required this.fairway,
      required this.gir,
      required this.put,
      required this.bunker,
      required this.scrumble});

  final ThemeData theme;
  final SizedBox gap;
  final int? fairway;
  final int? gir;
  final int? put;
  final int? bunker;
  final int? scrumble;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrainingCampoItem(
          label: 'fairway',
          value: '$fairway',
          isBigFont: true,
        ),
        TrainingCampoItem(label: 'gir', value: '$gir', isBigFont: true),
        TrainingCampoItem(label: 'put', value: '$put', isBigFont: true),
        TrainingCampoItem(
            label: 'scrum. bunker', value: '$bunker', isBigFont: true),
        TrainingCampoItem(
            label: 'scrumble', value: '$scrumble', isBigFont: true),
      ],
    );
  }
}
