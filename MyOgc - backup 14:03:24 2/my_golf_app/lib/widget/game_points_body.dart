import 'package:flutter/material.dart';
import 'package:my_golf_app/models/round.dart';
import 'package:my_golf_app/widget/training_campo_item.dart';

class GamePointsBody extends StatelessWidget {
  const GamePointsBody({super.key, required this.round});

  final Round round;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TrainingCampoItem(
          label: 'fairway',
          value: '${round.fairway}',
        ),
        TrainingCampoItem(
          label: 'gir',
          value: '${round.gir}',
        ),
        TrainingCampoItem(
          label: 'put',
          value: '${round.put}',
        ),
        TrainingCampoItem(
          label: 'scrum. bunker',
          value: '${round.scrumbleBuncker}',
        ),
        TrainingCampoItem(
          label: 'scrumble',
          value: '${round.scrumble}',
        ),
      ]),
    );
  }
}
