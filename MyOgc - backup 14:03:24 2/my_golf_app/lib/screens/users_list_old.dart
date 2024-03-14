import 'package:flutter/material.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/providers/users.dart';
import 'package:my_golf_app/widget/user_list_item.dart';
import 'package:provider/provider.dart';

class UsersListViewOld extends StatefulWidget {
  const UsersListViewOld({super.key, required this.users, this.isUpdated = false});

  final List<User> users;
  final bool isUpdated;

  @override
  State<UsersListViewOld> createState() => _UsersListViewOldState();
}

class _UsersListViewOldState extends State<UsersListViewOld> {
  final _gap = const SizedBox(width: 10, height: 10);

  List<User> items = [];

  Map<String, List<User>> groupList = {
    'group_0': [],
    'group_1': [],
    'group_2': [],
    'group_3': [],
  };

  void _initGroupList() {
    for (var user in items) {
      if (user is AthleteUser && user.group == Group.gruppoUno) {
        groupList['group_1']?.add(user);
      }
      if (user is AthleteUser && user.group == Group.gruppoDue) {
        groupList['group_2']?.add(user);
      }
      if (user is AthleteUser && user.group == Group.gruppoTre) {
        groupList['group_3']?.add(user);
      }
      groupList['group_0']?.add(user);
    }

    items = groupList['group_0']!;
  }

  var _currentIndex = 0;

  bool isAthletes = true;

  String _queryString = '';

  void search(String query, SearchController controller) {
    if (query.isEmpty || query == '') {
      setState(() {
        _clearSearchBar(controller);
      });
    } else {
      setState(() {
        _queryString = query.trim();

        if (isAthletes) {
          items = groupList['group_$_currentIndex']!
              .where((User user) => '${user.surname} ${user.name}'
                  .toLowerCase()
                  .contains(_queryString.toLowerCase()))
              .toList();
        } else {
          items = widget.users
              .where((User user) => '${user.surname} ${user.name}'
                  .toLowerCase()
                  .contains(_queryString.toLowerCase()))
              .toList();
        }
      });
    }
  }

  void _clearSearchBar(SearchController controller) {
    setState(() {
      controller.clear();
      _queryString = '';
      _resetList();
    });
  }

  void _resetList() {
    if (isAthletes) {
      items = groupList['group_$_currentIndex']!
        ..sort((a, b) =>
            a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
    } else {
      items = widget.users
        ..sort((a, b) =>
            a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
    }
  }

  @override
  void initState() {
    // debugPrint(
    //     'UsersListView.initState - widget.users: ${widget.users.length}');
    debugPrint(
        'UsersListView.initState - widget.isUpdated: ${widget.isUpdated}');

    isAthletes = widget.users is List<AthleteUser>;

    items = widget.users
      ..sort(
          (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
    if (isAthletes) _initGroupList();
    super.initState();
  }

  void _changeAthletesListForGroup() {
    if (_currentIndex == 0) {
      items = groupList['group_$_currentIndex']!
          .where((user) =>
              user is AthleteUser &&
              '${user.surname} ${user.name}'
                  .toLowerCase()
                  .contains(_queryString.toLowerCase()))
          .toList();
    } else {
      Group group = Group.gruppoUno;

      switch (_currentIndex) {
        case 1:
          group = Group.gruppoUno;
          break;
        case 2:
          group = Group.gruppoDue;
          break;
        case 3:
          group = Group.gruppoTre;
          break;
      }

      items = groupList['group_$_currentIndex']!
          .where((user) =>
              user is AthleteUser &&
              user.group == group &&
              '${user.surname} ${user.name}'
                  .toLowerCase()
                  .contains(_queryString.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _gap,
          SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                hintText: 'Cerca...',
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onChanged: (value) {
                  search(value, controller);
                },
                leading: const Icon(Icons.search),
                trailing: <Widget>[
                  Tooltip(
                    message: 'Pulisci campo',
                    child: IconButton(
                      onPressed: () {
                        if (_queryString.isNotEmpty || _queryString != '') {
                          _clearSearchBar(controller);
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                  )
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
          _gap,
          _gap,
          _gap,
          if (isAthletes)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(spacing: 5.0, children: [
                _choiceChipList(theme, 'Tutti', 0),
                _choiceChipList(theme, 'Gruppo 1', 1),
                _choiceChipList(theme, 'Gruppo 2', 2),
                _choiceChipList(theme, 'Gruppo 3', 3),
              ]),
            ),
          _gap,
          // Consumer<UsersProvider>(builder: ((context, user, child) {
          //   debugPrint('UsersListView.build - Consumer');
          //   if (widget.users is AthleteUser) {
          //     setState(() {
          //       items = user.getAthletes();
          //     });
          //   }
          //   if (widget.users is TrainerUser) {
          //     setState(() {
          //       items = user.getCommissioner();
          //     });
          //   }
          //   if (widget.users is CommissionUser) {
          //     setState(() {
          //       items = user.getCommissioner();
          //     });
          //   }
          //   return
          Expanded(
            child: Consumer<UsersProvider>(builder: (context, users, child) {
              if (widget.users is List<AthleteUser>) {
                items = users.getAthletes();
              } else if (widget.users is List<TrainerUser>) {
                items = users.getTrainer();
              } else {
                items = users.getCommissioner();
              }
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return UserListItem(items: items[index]);
                },
              );
            }),
          )
        ]));
  }

  ChoiceChip _choiceChipList(ThemeData theme, String label, int value) {
    return ChoiceChip(
      label: Text(label.toUpperCase()),
      selected: _currentIndex == value,
      checkmarkColor: Colors.white,
      labelStyle: _currentIndex == value
          ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          : TextStyle(
              color: theme.primaryColorDark, fontWeight: FontWeight.bold),
      selectedColor: theme.primaryColor,
      onSelected: (bool selected) {
        setState(() {
          _currentIndex = value;
          if (isAthletes) {
            _changeAthletesListForGroup();
          }
        });
      },
    );
  }
}
