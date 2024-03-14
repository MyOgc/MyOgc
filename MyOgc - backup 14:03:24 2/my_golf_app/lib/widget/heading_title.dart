import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/pages/profile_page.dart';

class HeadingTitle extends StatelessWidget {
  const HeadingTitle({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 20),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Ciao ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  // color: Colors.grey.shade300,
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {
                  context.push(ProfilePage.routeName);
                },
                iconSize: 30,
                icon: const Icon(Icons.person_outline),
              ),
            )
          ],
        ));
  }
}

