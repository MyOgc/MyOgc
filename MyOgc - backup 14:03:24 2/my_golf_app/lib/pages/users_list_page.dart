import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/models/users_type.dart';
import 'package:my_golf_app/pages/athlete_edit_page.dart';
import 'package:my_golf_app/pages/commissioner_edit_page.dart';
import 'package:my_golf_app/pages/trainer_edit_page.dart';
import 'package:my_golf_app/screens/users_list.dart';
import 'package:my_golf_app/widget/heading_title.dart';
import 'package:my_golf_app/widget/logo_text.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  static const routeName = '/users-list';

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<User> items = [];

  final _gap = const SizedBox(
    height: 10,
    width: 10,
  );

  @override
  void initState() {
    debugPrint('UsersListPage.initState');
    super.initState();
  }

  TabBar get _tabBar => const TabBar(
        tabs: [
          Tab(text: 'Atleti'),
          Tab(text: 'Maestri'),
          Tab(text: 'Commissari'),
        ],
      );

  // bool _isUpdated = false;

  navigateToPages(routeName, {extra}) async {
    final result = await context.push(routeName, extra: extra);
    // debugPrint('UsersListPage.navigateToPages - result: $result');
    if (result == true) {
      // setState(() {
      //   _isUpdated = result as bool;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    TextStyle textMenuStyle = const TextStyle(fontSize: 18);

    final menuItem = <Widget>[
      MenuItemButton(
        onPressed: () =>
            navigateToPages(AthleteEditPage.routeName, extra: false),
        child: Text('Aggiungi Atleta', style: textMenuStyle),
      ),
      MenuItemButton(
        onPressed: () => context.push(TrainerEditPage.routeName, extra: false),
        child: Text('Aggiungi Maestro', style: textMenuStyle),
      ),
      MenuItemButton(
        onPressed: () =>
            context.push(CommissionerEditPage.routeName, extra: false),
        child: Text(
          'Aggiungi Commissario',
          style: textMenuStyle,
        ),
      ),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: theme.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: MenuAnchor(
            builder: (BuildContext context, MenuController controller,
                Widget? child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(
                  Icons.person_add_outlined,
                ),
                iconSize: 28,
                color: Colors.white,
                tooltip: 'Show menu',
              );
            },
            menuChildren: menuItem,
          ),
        ),
        appBar: AppBar(
            toolbarHeight: 150,
            backgroundColor: theme.primaryColor,
            // centerTitle: true,
            bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Material(child: _tabBar)),
            title: Column(
              children: [
                const LogoText(
                  titleColor: Colors.white,
                ),
                _gap,
                const HeadingTitle(userName: 'Commissario'),
              ],
            )),
        body: const TabBarView(
          children: [
            UsersListView(usersType: UsersType.athlete),
            UsersListView(usersType: UsersType.trainer),
            UsersListView(usersType: UsersType.commissioner),
          ],
        ),
      ),
    );
  }
}
