import 'package:flutter/material.dart';
import 'package:my_golf_app/models/session.dart';
import 'package:my_golf_app/widget/session_item_card.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({super.key, required this.session});
  final Session session;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SessionItemCard(
            title: 'WAGR',
            value: '${session.wagr}',
          ),
          SessionItemCard(
            title: 'ODM',
            value: '${session.odm}',
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SessionItemCard(
            title: 'ranking',
            value: '${session.ranking}',
          ),
          SessionItemCard(
            title: 'HCP',
            value: '${session.hcp}',
          ),
        ],
      )
    ]);
  }
}
