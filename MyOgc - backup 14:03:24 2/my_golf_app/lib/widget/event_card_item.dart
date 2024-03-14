import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/game.dart';
import 'package:my_golf_app/pages/game_page.dart';
import 'package:my_golf_app/pages/summary_game_page.dart';
import 'package:my_golf_app/pages/training_detail_page.dart';

class EventCardItem extends StatelessWidget {
  EventCardItem({super.key, required this.event, this.isReadOnly = false});

  final dynamic event;
  final bool isReadOnly;

  final mounthList = [
    'Gen',
    'Feb',
    'Mar',
    'Apr',
    'Mag',
    'Giu',
    'Lug',
    'Ago',
    'Set',
    'Ott',
    'Nov',
    'Dic'
  ];

  @override
  Widget build(BuildContext context) {
    // debugPrint('EventCardItem.isReadOnly: $isReadOnly');

    bool isGame = event is Game;
    final theme = Theme.of(context);

    // final body = Column(
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(
    //           boxShadow: const [
    //             BoxShadow(
    //                 color: Colors.grey, blurRadius: 5.0, offset: Offset(1, 3)),
    //           ],
    //           color: theme.primaryColorLight,
    //           border: Border(
    //               left: BorderSide(color: theme.primaryColor, width: 10)),
    //           borderRadius: BorderRadius.circular(20)),
    //       padding:
    //           const EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 10),
    //       height: 160,
    //       child: Row(
    //         children: [
    //           Flexible(
    //             flex: 1,
    //             child: Container(
    //               padding: const EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                   color: isGame
    //                       ? const Color.fromARGB(255, 249, 211, 116)
    //                       : const Color.fromARGB(255, 119, 198, 198),
    //                   borderRadius: BorderRadius.circular(50)),
    //               child: Icon(
    //                 isGame
    //                     ? Icons.emoji_events_outlined
    //                     : Icons.sports_golf_outlined,
    //                 size: 40,
    //                 color: const Color.fromARGB(255, 74, 74, 74),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 20,
    //           ),
    //           Flexible(
    //             flex: 4,
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         isGame ? event.gameName : 'Allenamento',
    //                         style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 16,
    //                             color: theme.primaryColorDark),
    //                       ),
    //                       if (isGame)
    //                         Row(
    //                           children: [
    //                             Text(
    //                               'Scores: ',
    //                               style: TextStyle(
    //                                   fontSize: 16, color: theme.primaryColor),
    //                             ),
    //                             Text(
    //                               '${event.scores}',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: theme.primaryColorDark,
    //                                   fontSize: 16),
    //                             ),
    //                           ],
    //                         ),
    //                     ],
    //                   ),
    //                   const SizedBox(
    //                     height: 5,
    //                   ),
    //                   Text(
    //                     '${event.date.day} ${mounthList[event.date.month - 1]}, ${event.date.year}',
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w800,
    //                         fontSize: 18,
    //                         color: theme.primaryColorDark),
    //                   ),
    //                   isGame
    //                       ? Text(
    //                           event.circleName,
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: 18,
    //                               color: theme.primaryColorDark),
    //                         )
    //                       : const SizedBox(
    //                           height: 10,
    //                         ),
    //                   Row(
    //                     children: isGame
    //                         ? [
    //                             Text(
    //                               'Pos: ',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 18,
    //                                   color: theme.primaryColor),
    //                             ),
    //                             Text(
    //                               '${event.finalScores}',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 18,
    //                                   color: theme.primaryColorDark),
    //                             ),
    //                           ]
    //                         : [
    //                             Text(
    //                               'Durata: ',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 18,
    //                                   color: theme.primaryColor),
    //                             ),
    //                             Text(
    //                               '${event.lessionHours}',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 18,
    //                                   color: theme.primaryColorDark),
    //                             ),
    //                           ],
    //                   ),
    //                   if (!isGame) const Expanded(child: SizedBox()),
    //                   Align(
    //                     alignment: Alignment.centerRight,
    //                     //   child: TextButton(
    //                     child: InkWell(
    //                       onTap: () {
    //                         final routeName = isGame
    //                             ? GamePage.routeName
    //                             : TrainingDetailPage.routeName;
    //                         context.push(routeName);
    //                       },
    //                       child: Container(
    //                         //decoration: BoxDecoration(border: Border.all()),
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: 15, vertical: 0),
    //                         child: Text('Visualizza',
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 15,
    //                                 color: theme.primaryColorDark)),
    //                       ),
    //                     ),
    //                     //     onPressed: () =>
    //                     //         context.push(EventDetailPage.routeName),
    //                     //   ),
    //                   ),
    //                 ]),
    //           ),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //   ],
    // );

    final detailsButton = InkWell(
        onTap: () {
          isReadOnly
              ? context.push(
                  isGame
                      ? '${SummaryGamePage.routeName}/${event.id}'
                      : '${TrainingDetailPage.routeName}/${event.id}',
                  extra: true)
              : context.push(
                  isGame
                      ? '${GamePage.routeName}/${event.id}'
                      : '${TrainingDetailPage.routeName}/${event.id}',
                  extra: false);
        },
        highlightColor: Colors.grey,
        child: Text(
          'Dettagli',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor),
        ));

    final bodyCard = Card(
      child: Container(
        // constraints: BoxConstraints(minHeight: 140),
        padding:
            const EdgeInsets.only(top: 8.0, left: 15.0, right: 15, bottom: 8),
        // constraints: BoxConstraints(minHeight: 120),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: isGame
                      ? const Color.fromARGB(255, 255, 218, 125)
                      : const Color.fromARGB(255, 133, 222, 222),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                isGame
                    ? Icons.emoji_events_outlined
                    : Icons.sports_golf_outlined,
                size: 30,
                color: const Color.fromARGB(255, 74, 74, 74),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isGame ? event.gameName : 'Allenamento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: theme.primaryColorDark)),
                      Text(
                        '${event.date.day} ${mounthList[event.date.month - 1]}, ${event.date.year}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: theme.highlightColor),
                      ),
                    ],
                  ),
                  isGame
                      ? Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              event?.circleName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: theme.primaryColorDark),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            //
                            Icon(
                              Icons.timer_sharp,
                              size: 18,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${event.lessionHours.round()} ore',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: theme.primaryColorDark),
                            ),
                          ],
                        ),
                  Row(
                    children: isGame
                        ? [
                            Text(
                              'Pos: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: theme.primaryColor),
                            ),
                            Text(
                              event.positioning != null
                                  ? '${event.positioning}'
                                  : '- -',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: theme.primaryColorDark),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Scores: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: theme.primaryColor),
                            ),
                            Text(
                              event.finalScores != null ? '${event.finalScores}' : '- -',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: theme.primaryColorDark),
                            ),
                            const Expanded(child: SizedBox()),
                            detailsButton,
                          ]
                        : [
                            const Expanded(child: SizedBox()),
                            detailsButton,
                          ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return bodyCard;
  }
}
