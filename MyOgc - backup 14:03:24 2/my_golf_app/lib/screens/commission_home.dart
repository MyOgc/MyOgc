import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/home_page.dart';
import 'package:my_golf_app/pages/trainer_home_page.dart';
import 'package:my_golf_app/pages/users_list_page.dart';
import 'package:my_golf_app/widget/heading_title.dart';

class CommissionHomeView extends StatelessWidget {
  const CommissionHomeView({super.key, required this.user});

  final User user;

  final _gap = const SizedBox(
    width: 20,
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTitle(userName: user.name),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: Column(
            children: [
              ElvatedBigButton(
                  onPressed: () {
                    context.go(UsersListPage.routeName);
                  },
                  icon: Icons.person,
                  label: 'Commissario \nView'),
              _gap,
              ElvatedBigButton(
                  onPressed: () {
                    context.go(TrainerHomePage.routeName, extra: user);
                  },
                  icon: Icons.person_add,
                  label: 'Maestro\nView'),
              _gap,
              ElvatedBigButton(
                  onPressed: () {
                    context.go(
                      HomePage.routeName,
                      extra: AthleteUser(
                        id: 111111111,
                        name: 'Mario',
                        surname: 'Rossi',
                        phoneNumber: '45423545243',
                        email: 'mario.rossi@emal.it',
                        serialNumber: 1111,
                        birthDate: DateTime.utc(2002, 2, 2),
                        group: Group.gruppoUno,
                        trainer: ['415245t235t34'],
                      ),
                    );
                  },
                  icon: Icons.person_add,
                  label: 'Allievo\nView'),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElvatedBigButton(
              //         onPressed: () {
              //           context.go(UsersListPage.routeName);
              //         },
              //         icon: Icons.person,
              //         label: 'Lista\natleti'),
              //     _gap,
              //     ElvatedBigButton(
              //         onPressed: () {
              //           context.go(TrainerHomePage.routeName, extra: user);
              //         },
              //         icon: Icons.person_add,
              //         label: 'Crea\natleta'),
              //   ],
              // ),
              // _gap,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElvatedBigButton(
              //         onPressed: () {},
              //         icon: Icons.person,
              //         label: 'Lista\nmaestri'),
              //     _gap,
              //     ElvatedBigButton(
              //         onPressed: () {},
              //         icon: Icons.person_add,
              //         label: 'Crea\nmaestro'),
              //   ],
              // ),
              // _gap,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElvatedBigButton(
              //         onPressed: () {},
              //         icon: Icons.person,
              //         label: 'Lista\ncommissari'),
              //     _gap,
              //     ElvatedBigButton(
              //         onPressed: () {},
              //         icon: Icons.person_add,
              //         label: 'Crea\ncommissario'),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}

class ElvatedBigButton extends StatelessWidget {
  const ElvatedBigButton(
      {super.key, required this.label, this.icon, this.onPressed});

  final String label;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.grey,
          // surfaceTintColor: Colors.white,

          elevation: 5,
          padding: const EdgeInsets.all(10),
          textStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      onPressed: onPressed,
      child: SizedBox(
        width: 160,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   icon,
            //   size: 40,
            // ),
            Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
