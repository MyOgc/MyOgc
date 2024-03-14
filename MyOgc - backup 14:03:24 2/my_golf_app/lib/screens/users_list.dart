import 'package:flutter/material.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/models/users_type.dart';
import 'package:my_golf_app/providers/users.dart';
import 'package:my_golf_app/widget/user_list_item.dart';
import 'package:provider/provider.dart';

class UsersListView extends StatefulWidget {
  const UsersListView(
      {super.key, required this.usersType, this.isUpdated = false});

  // final List<User> users;
  final UsersType usersType;
  final bool isUpdated;

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  final _gap = const SizedBox(width: 10, height: 10);

  List<User> items = [];

  Map<String, List<User>> groupList = {
    'group_0': [],
    'group_1': [],
    'group_2': [],
    'group_3': [],
  };

  var _currentIndex = 0;

  bool isAthletes = true;

  String _queryString = '';

  void search(String query, SearchController controller) {
    if (query.isEmpty || query == '') {
      setState(() {
        _clearSearchBar(controller);
      });
    } else {
      debugPrint('UserListView.search');
      setState(() {
        _queryString = query.trim();

        // if (isAthletes) {
        items = items
            .where((User user) => '${user.surname} ${user.name}'
                .toLowerCase()
                .contains(_queryString.toLowerCase()))
            .toList();

        debugPrint('UserListView.search - items.length: ${items.length}');
        // } else {
        //   items = widget.users
        //       .where((User user) => '${user.surname} ${user.name}'
        //           .toLowerCase()
        //           .contains(_queryString.toLowerCase()))
        //       .toList();
        // }
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
      if (_currentIndex > 0) {
        items = usersProvider!.getAthletesForGroup(_getCurrentGroup());
      } else {
        items = usersProvider!.getAthletes();
      }
    } else {
      if (widget.usersType == UsersType.trainer) {
        items = usersProvider!.getTrainer();
      } else {
        items = usersProvider!.getCommissioner();
      }
    }
  }

  UsersProvider? usersProvider;

  @override
  void initState() {
    // debugPrint(
    //     'UsersListView.initState - widget.users: ${widget.users.length}');
    debugPrint(
        'UsersListView.initState - widget.isUpdated: ${widget.isUpdated}');

    usersProvider = Provider.of<UsersProvider>(context, listen: false);

    isAthletes = widget.usersType == UsersType.athlete;

    // if (widget.usersType == UsersType.athlete) {
    //   // setState(() {
    //   items = usersProvider!.getAthletes();
    //   // });
    // }
    // if (widget.usersType == UsersType.trainer) {
    //   // setState(() {
    //   items = usersProvider!.getTrainer();
    //   // });
    // }
    // if (widget.usersType == UsersType.commissioner) {
    //   // setState(() {
    //   items = usersProvider!.getCommissioner();
    //   // });
    // }

    // // items = widget.users
    // items = items
    //   ..sort(
    //       (a, b) => a.surname.toLowerCase().compareTo(b.surname.toLowerCase()));
    // if (isAthletes) _initGroupList();
    super.initState();
  }

  void _changeAthletesListForGroup() {
    if (_currentIndex == 0) {
      items = usersProvider!
          .getAthletes()
          .where((user) => '${user.surname} ${user.name}'
              .toLowerCase()
              .contains(_queryString.toLowerCase()))
          .toList();
    } else {
      items = usersProvider!
          .getAthletesForGroup(_getCurrentGroup())
          .where((user) => '${user.surname} ${user.name}'
              .toLowerCase()
              .contains(_queryString.toLowerCase()))
          .toList();
    }
  }

  _getCurrentGroup() {
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

    return group;
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
          Expanded(
            child: Consumer<UsersProvider>(builder: (context, users, child) {
              if (widget.usersType == UsersType.athlete) {
                _changeAthletesListForGroup();
              } else if (widget.usersType == UsersType.trainer) {
                items = users
                    .getTrainer()
                    .where((User user) => '${user.surname} ${user.name}'
                        .toLowerCase()
                        .contains(_queryString.toLowerCase()))
                    .toList();
              } else {
                items = users
                    .getCommissioner()
                    .where((User user) => '${user.surname} ${user.name}'
                        .toLowerCase()
                        .contains(_queryString.toLowerCase()))
                    .toList();
              }
              // debugPrint('UsersListView.build - Consumer<UsersProvider>');
              // debugPrint('UsersListView.build - Consumer<UsersProvider> - users.athletes.length: ${users.athletes.length}');
              // debugPrint('UsersListView.build - Consumer<UsersProvider> - items.length: ${items.length}');

              // return ListView(children: List<UserListItem>.generate(items.length, (index) =>  UserListItem(items: items[index])),);

              return items.isNotEmpty
                  ? ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return UserListItem(items: items[index]);
                      },
                    )
                  : const Center(child: Text('Nessuna corrispondenza trovata'));
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
