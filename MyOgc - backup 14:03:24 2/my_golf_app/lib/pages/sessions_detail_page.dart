import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/models/session.dart';
import 'package:my_golf_app/pages/session_edit_page.dart';
import 'package:my_golf_app/providers/user.dart';
import 'package:my_golf_app/widget/expandable_fab.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:my_golf_app/widget/session_widget.dart';
import 'package:my_golf_app/widget/title_section.dart';
import 'package:my_golf_app/widget/training_campo_item.dart';
import 'package:provider/provider.dart';

// class DropDownItem {
//   const DropDownItem({required int index, required String text});
// }

class SessionsDetailPage extends StatefulWidget {
  const SessionsDetailPage({super.key});
  static const routeName = '/sessions-detail';

  @override
  State<SessionsDetailPage> createState() => _SessionsDetailPageState();
}

class _SessionsDetailPageState extends State<SessionsDetailPage> {
  int dropdownValue = 0;

  int? sessionId;

  UserProvider? userProvider;

  List<Session> sessionsValueList = [];

  final _gap = const SizedBox(
    width: 10,
    height: 10,
  );

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    sessionsValueList = userProvider!.getSessionsList().reversed.toList();
    if(sessionsValueList.isNotEmpty) sessionId = sessionsValueList[dropdownValue].id;
    super.initState();
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
      title: const Text('Dettaglio trimestre',
          style: TextStyle(color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: sessionsValueList.isNotEmpty ? ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () => _showDialog(
              context,
              title: const Text('Elimina trimestre'),
              content:
                  const Text('Procedere con l\'eliminazione del trimestre?'),
            ).then((value) {
              if (value) {
                context.pop();
                dropdownValue = 0;
                userProvider?.deleteSession(sessionId!);
              }
            }),
            icon: const Icon(Icons.delete_outline_outlined),
            color: theme.colorScheme.error,
          ),
          ActionButton(
            onPressed: () => context
                .push('${SessionEditPage.routeName}/$sessionId', extra: true),
            icon: const Icon(Icons.edit),
            color: const Color.fromARGB(255, 23, 104, 130),
          ),
        ],
      ) : null,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Consumer<UserProvider>(builder: (context, user, child) {
          sessionsValueList = user.getSessionsList().reversed.toList();
          if (sessionsValueList.isEmpty) {
            return const Center(
                child: Text('Non ci sono trimestri disponibili'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleSection(title: 'trimestre'),
                      DropdownMenu<int>(
                        key: UniqueKey(),
                        textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        width: 250,
                        initialSelection: dropdownValue,
                        onSelected: (int? value) {
                          setState(() {
                            dropdownValue = value!;
                            sessionId = sessionsValueList[dropdownValue].id;
                          });
                        },
                        dropdownMenuEntries:
                            List<DropdownMenuEntry<int>>.generate(
                          sessionsValueList.length,
                          (index) {
                            // debugPrint('SessionsDetailPage - List.generate: sessionsValueList: $sessionsValueList');
                            return DropdownMenuEntry<int>(
                                label:
                                    '${sessionsValueList[index].finalDate.day}/${sessionsValueList[index].finalDate.month}/${sessionsValueList[index].finalDate.year}${index == 0 ? ' (attuale)' : ''}',
                                value: index);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SessionWidget(session: sessionsValueList[dropdownValue]),
                ]),
              ),
              _gap,
              _gap,
              Text('Media scores allenamento trimestre:',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              _gap,
              _CampoMediaPointsBody(
                  rounds: sessionsValueList[dropdownValue].campoTrainingPoints),
            ],
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
class _CampoMediaPointsBody extends StatelessWidget {
  _CampoMediaPointsBody({required this.rounds});

  final List<Round> rounds;

  int _fairwayTotal = 0;
  int _girTotal = 0;
  int _putTotal = 0;
  int _scrumbleBunkerTotal = 0;
  int _scrumbleTotal = 0;

  _getMediaPoints() {
    _fairwayTotal = rounds.fold(0, (int sum, item) => sum + item.fairway!);
    _girTotal = rounds.fold(0, (int sum, item) => sum + item.gir!);
    _putTotal = rounds.fold(0, (int sum, item) => sum + item.put!);
    _scrumbleBunkerTotal =
        rounds.fold(0, (int sum, item) => sum + item.scrumbleBuncker!);
    _scrumbleTotal = rounds.fold(0, (int sum, item) => sum + item.scrumble!);
  }

  @override
  Widget build(BuildContext context) {
    if (rounds.isNotEmpty) _getMediaPoints();

    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TrainingCampoItem(
            label: 'Fairway',
            value: rounds.isNotEmpty
                ? (_fairwayTotal / rounds.length).toStringAsFixed(1)
                : '$_fairwayTotal'),
        TrainingCampoItem(
            label: 'Gir',
            value: rounds.isNotEmpty
                ? (_girTotal / rounds.length).toStringAsFixed(1)
                : '$_girTotal'),
        TrainingCampoItem(
            label: 'put',
            value: rounds.isNotEmpty
                ? (_putTotal / rounds.length).toStringAsFixed(1)
                : '$_putTotal'),
        TrainingCampoItem(
            label: 'scrum. bunker',
            value: rounds.isNotEmpty
                ? (_scrumbleBunkerTotal / rounds.length).toStringAsFixed(1)
                : '$_scrumbleBunkerTotal'),
        TrainingCampoItem(
            label: 'scrumble',
            value: rounds.isNotEmpty
                ? (_scrumbleTotal / rounds.length).toStringAsFixed(1)
                : '$_scrumbleTotal'),
      ]),
    );
  }
}
