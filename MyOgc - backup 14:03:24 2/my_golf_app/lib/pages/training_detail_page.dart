import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/training_type.dart';
import 'package:my_golf_app/pages/training_edit_page.dart';
import 'package:my_golf_app/providers/training.dart';
import 'package:my_golf_app/utiles/utiles.dart';
import 'package:my_golf_app/widget/expandable_fab.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:my_golf_app/widget/training_campo_item.dart';
import 'package:my_golf_app/widget/training_elevated_button.dart';
import 'package:provider/provider.dart';

class TrainingDetailPage extends StatelessWidget {
  const TrainingDetailPage(
      {super.key, required this.trainingId, this.isReadOnly = false});

  static const routeName = '/training-detail';

  final bool isReadOnly;
  final String trainingId;

  final SizedBox _gap = const SizedBox(
    height: 10,
    width: 10,
  );

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
        }));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutWidget(
      title: const Text('Dettaglio allenamento',
          style: TextStyle(color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isReadOnly
          ? null
          : ExpandableFab(
              distance: 112,
              children: [
                ActionButton(
                  onPressed: () {
                    _showDialog(
                      context,
                      title: const Text('Elimina allenamento'),
                      content: const Text(
                          'Procedere con l\'eliminazione dell\'allenamento?'),
                    ).then((value) {
                      if (value) {
                        context.pop(3);
                        Provider.of<TrainingProvider>(context, listen: false)
                            .removeTraining(int.parse(trainingId));
                      }
                    });
                  },
                  icon: const Icon(Icons.delete_outline_outlined),
                  color: theme.colorScheme.error,
                ),
                ActionButton(
                  onPressed: () {
                    context.push('${TrainingEditPage.routeName}/$trainingId',
                        extra: true);
                  },
                  icon: const Icon(Icons.edit),
                  color: const Color.fromARGB(255, 23, 104, 130),
                ),
              ],
            ),
      body: Center(
        child: Container(
          // decoration: BoxDecoration(border: Border.all()),
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 1000),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Consumer<TrainingProvider>(builder: (context, value, child) {
              final training = value.getTraining(int.parse(trainingId));
              debugPrint('TrainingDetailPage.build - Cosumer value: $training');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 24,
                      color: theme.primaryColor,
                    ),
                    _gap,
                    Text(
                      '${training?.date.day} ${AppUtilities.mounthList[training != null ? training.date.month - 1 : 0]} ${training?.date.year}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor),
                    ),
                  ]),
                  _gap,
                  Row(children: [
                    Icon(
                      Icons.timer_sharp,
                      size: 24,
                      color: theme.primaryColor,
                    ),
                    _gap,
                    Text(
                      '${training?.lessionHours.round()} ore',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor),
                    ),
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Allenamento svolto',
                      style: TextStyle(
                          color: theme.primaryColorDark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  _gap,
                  if (training != null)
                    _TrainingListBody(trainingType: training.trainingType),
                  const SizedBox(
                    height: 30,
                  ),
                  if (training != null &&
                      training.trainingType.contains(TrainingType.campo))
                    _TrainingCampoBody(
                      theme: theme,
                      gap: _gap,
                      fairway: training.round!.fairway,
                      gir: training.round!.gir,
                      put: training.round!.put,
                      bunker: training.round!.scrumbleBuncker,
                      scrumble: training.round!.scrumble,
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
        Text('Dettagli campo',
            style: TextStyle(
                color: theme.primaryColorDark,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        gap,
        TrainingCampoItem(label: 'fairway', value: '$fairway'),
        TrainingCampoItem(label: 'gir', value: '$gir'),
        TrainingCampoItem(label: 'put', value: '$put'),
        TrainingCampoItem(label: 'scrum. bunker', value: '$bunker'),
        TrainingCampoItem(label: 'scrumble', value: '$scrumble'),
      ],
    );
  }
}

class _TrainingListBody extends StatelessWidget {
  const _TrainingListBody({required this.trainingType});

  final List<TrainingType> trainingType;

  String _getTrainingLabel(value) {
    String label = '';

    switch (value) {
      case TrainingType.put:
        label = 'put';
        break;
      case TrainingType.giocoCorto:
        label = 'g. corto';
        break;
      case TrainingType.giocoLungo:
        label = 'g. lungo';
        break;
      case TrainingType.campo:
        label = 'campo';
        break;
    }

    return label;
  }

  @override
  Widget build(BuildContext context) {
    final trainingRows = trainingType.map((TrainingType value) {
      return TrainingElevatedButton(
        label: _getTrainingLabel(value),
        isActived: true,
        onPressed: null,
      );
    }).toList();

    return trainingRows.isEmpty
        ? const Text('Nessun tipo di allenamento presente')
        : trainingRows.length > 2
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [trainingRows[0], trainingRows[1]],
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        trainingRows[2],
                        if (trainingRows.length == 4) trainingRows[3],
                      ]),
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                trainingRows[0],
                if (trainingRows.length == 2) trainingRows[1]
              ]);
  }
}
