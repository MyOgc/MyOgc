import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/athlete_details_page.dart';
import 'package:my_golf_app/pages/commissioner_details_page.dart';
import 'package:my_golf_app/pages/trainer_details_page.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.items,
  });

  final User items;

  @override
  Widget build(BuildContext context) {
    final bodyCard = InkWell(
        onTap: () {
          debugPrint(items.levelPermissions.toString());
          if (items is AthleteUser) {
            debugPrint('is AthleteUser');
            context.push(AthleteDetailsPage.routeName);
          } else if (items is TrainerUser) {
            debugPrint('is TrainerUser');
            context.push(TrainerDetailsPage.routeName);
          } else if (items is CommissionUser) {
            debugPrint('is CommissionUser');
            context.push(
              CommissionerDetailsPage.routeName,
              // extra: CommissionUser(
              //     name: 'zinzo',
              //     surname: 'zanzo',
              //     email: 'zinzo.zanzo@email.it',
              //     phoneNumber: '323232233232',
              //     serialNumber: 1233252),
            );
          }
        },
        // hoverColor: Theme.of(context).primaryColor,
        // splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColorLight,
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${items.surname} ${items.name}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        )));

    // final elevatedButtonBody = ElevatedButton(
    //     onPressed: () {
    //       context.push(AthleteDetailsPage.routeName);
    //     },
    //     style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColorLight, elevation: 1),
    //     child: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             '${items.surname} ${items.name}',
    //             style: const TextStyle(fontWeight: FontWeight.w500),
    //           ),
    //           Icon(
    //             Icons.arrow_forward_ios,
    //             size: 18,
    //             color: Theme.of(context).primaryColor,
    //           ),
    //         ],
    //       ),
    //     ));
    return bodyCard;
  }
}
