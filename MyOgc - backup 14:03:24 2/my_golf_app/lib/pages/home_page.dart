import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/event_type.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/game_edit_page.dart';
import 'package:my_golf_app/pages/session_edit_page.dart';
import 'package:my_golf_app/pages/training_edit_page.dart';
import 'package:my_golf_app/providers/user.dart';
import 'package:my_golf_app/screens/calendar.dart';
import 'package:my_golf_app/screens/commission_home.dart';
import 'package:my_golf_app/screens/events_list.dart';
import 'package:my_golf_app/screens/home.dart';
import 'package:my_golf_app/widget/layout.dart';
import 'package:my_golf_app/widget/logo_text.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key, required this.user});
  static const routeName = '/home';

  User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double topPadding = 0;
  final double horizzontalPadding = 0;

  int _currentIndex = 0;
  List<Widget> views = [];
  LevelPermissions? levelPermissionsUser;

  User? fureUser;

  @override
  void initState() {
    // debugPrint('${widget.user}');
    // debugPrint('${widget.user.levelPermissions == LevelPermissions.athlete}');
    levelPermissionsUser = widget.user.levelPermissions;
    // Provider.of<UserProvider>(context, listen: false).setUserData(widget.user);
    widget.user = Provider.of<UserProvider>(context, listen: false).userData;

    views = <Widget>[
      HomeView(user: widget.user),
      const CalendarView(),
      const EventsListView(eventType: EventType.game),
      const EventsListView(eventType: EventType.training),
    ];
    super.initState();
  }

  void onClickHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  navigateToPages(routeName) async {
    final result = await context.push(routeName);
    if (result != null) {
      //  debugPrint('_HomePageState: navigateToPages ${result.toString()}');
      setState(() {
        _currentIndex = int.parse(result.toString());
      });
    }
  }

  TextStyle textMenuStyle = const TextStyle(fontSize: 18);
  String svgPic = 'assets/images/svg/sports_golf.svg';
  double fontSize = 28;

  @override
  Widget build(BuildContext context) {
    final menuItem = <Widget>[
      MenuItemButton(
        onPressed: () => context.push(SessionEditPage.routeName),
        child: Column(
          children: [
            Text('Aggiungi trimestre', style: textMenuStyle),
          ],
        ),
      ),
      MenuItemButton(
        onPressed: () => navigateToPages(GameEditPage.routeName),
        child: Text('Aggiungi gara', style: textMenuStyle),
      ),
      MenuItemButton(
        onPressed: () => navigateToPages(TrainingEditPage.routeName),
        child: Text(
          'Aggiungi allenamento',
          style: textMenuStyle,
        ),
      ),
    ];

    // Widget _commissionBody (ThemeData theme) {
    //   return ;
    // }

    return LayoutWidget(
      title: const LogoText(
        titleColor: Colors.white,
      ),
      bottomNavigationBar:
          widget.user.levelPermissions == LevelPermissions.athlete
              ? _userNavigationBar(Theme.of(context))
              : null,
      body: widget.user.levelPermissions == LevelPermissions.athlete
          ? views.elementAt(_currentIndex)
          : CommissionHomeView(
              user: widget.user,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          widget.user.levelPermissions == LevelPermissions.athlete
              ? FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
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
                        icon: const Icon(Icons.add),
                        iconSize: 30,
                        color: Colors.white,
                        tooltip: 'Show menu',
                      );
                    },
                    menuChildren: menuItem,
                  ),
                )
              : null,
    );
  }

  NavigationBar _userNavigationBar(ThemeData theme) {
    final Color color = theme.primaryColor;

    return NavigationBar(
      height: 45,
      destinations: <Widget>[
        NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.home,
              color: color,
              size: fontSize,
            ),
            label: 'Home'),
        NavigationDestination(
            icon: Icon(
              Icons.calendar_month_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.calendar_month,
              color: color,
              size: fontSize,
            ),
            label: 'Calendario'),
        NavigationDestination(
            icon: Icon(
              Icons.emoji_events_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: Icon(
              Icons.emoji_events,
              color: color,
              size: fontSize,
            ),
            label: 'Gare'),
        NavigationDestination(
            icon: Icon(
              Icons.sports_golf_outlined,
              color: color,
              size: fontSize,
            ),
            selectedIcon: SvgPicture.asset(
              svgPic,
              height: fontSize,
              // ignore: deprecated_member_use
              color: color,
            ),
            label: 'Allenamento'),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      indicatorColor: theme.primaryColorLight,
      surfaceTintColor: Colors.transparent,
      selectedIndex: _currentIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    );
  }
}
