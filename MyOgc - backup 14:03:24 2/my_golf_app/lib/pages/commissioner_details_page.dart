import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/commissioner_edit_page.dart';
import 'package:my_golf_app/pages/profile_details_page.dart';
import 'package:my_golf_app/widget/expandable_fab.dart';
import 'package:my_golf_app/widget/layout.dart';

class CommissionerDetailsPage extends StatefulWidget {
  const CommissionerDetailsPage({super.key});

  static const routeName = '/commissioner-details';

  @override
  State<CommissionerDetailsPage> createState() =>
      _CommissionerDetailsPageState();
}

class _CommissionerDetailsPageState extends State<CommissionerDetailsPage> {
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutWidget(
      title: const Text('Rossi Francesco',
          style: TextStyle(
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () => {},
            icon: const Icon(Icons.delete_outline_outlined),
            color: theme.colorScheme.error,
          ),
          ActionButton(
            onPressed: () =>
                context.push(CommissionerEditPage.routeName, extra: true),
            icon: const Icon(Icons.edit),
            color: const Color.fromARGB(255, 23, 104, 130),
          ),
        ],
      ),
      body: ProfileDetailsPage(
          user: CommissionUser(
            id: 5432243,
              name: 'Franco',
              surname: 'Bondi',
              email: 'fanco.bondi@email.it',
              phoneNumber: '23455432',
              serialNumber: 1234564)),
    );
  }
}
