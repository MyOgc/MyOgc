// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/utiles/utiles.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key, required this.user});

  static const routeName = '/details-profile';

  final User user;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return
        // LayoutWidget(
        //   title: Text(
        //     'I miedi dati',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        //   floatingActionButton: ExpandableFab(
        //     distance: 112,
        //     children: [
        //       ActionButton(
        //         onPressed: () => {},
        //         icon: const Icon(Icons.delete_outline_outlined),
        //         color: theme.colorScheme.error,
        //       ),
        //       ActionButton(
        //         onPressed: () => context.push(AthleteEditPage.routeName, extra: true),
        //         icon: const Icon(Icons.edit),
        //         color: const Color.fromARGB(255, 23, 104, 130),
        //       ),
        //     ],
        //   ),
        //   body:
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileField(title: 'Nome e cognome', value: user.name),
            Divider(),
            ProfileField(title: 'Numero matricola', value: user.surname),
            Divider(),
            if (user is AthleteUser)
              ProfileField(
                  title: 'Data di nascita',
                  value:
                      '${user.birthDate?.day} ${AppUtilities.mounthList[user.birthDate!.month]} ${user.birthDate?.year}'),
            if (user is AthleteUser) Divider(),
            ProfileField(title: 'Email', value: user.email),
            Divider(),
            ProfileField(title: 'Numero di telefono', value: user.phoneNumber),
            Divider(),
            if (user is AthleteUser)
              ProfileField(title: 'Gruppo', value: user.group!.label),
            if (user is AthleteUser) Divider(),
            if (user is AthleteUser)
              ProfileField(
                title: 'Allenatore',
                value: 'Pippo Baudo',
                hasContacts: false,
              ),
            // Expanded(child: SizedBox()),
            SizedBox(
              height: 40,
            )
          ],
        ),
        // ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).primaryColorDark));
  }
}

class _ValueField extends StatelessWidget {
  const _ValueField(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: TextStyle(
          fontSize: 20,
          //color: Theme.of(context).primaryColor,
        ));
  }
}

class ProfileField extends StatelessWidget {
  const ProfileField(
      {super.key,
      this.hasContacts = false,
      required this.title,
      required this.value});

  final String title;
  final String value;
  final bool hasContacts;

  final _iconSize = 25.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hasContacts
            ? [
                _TitleField(title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ValueField(value),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 250,
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ContactItem(
                                      icon: Icon(
                                        Icons.phone_outlined,
                                        size: _iconSize,
                                        color: theme.primaryColorDark,
                                      ),
                                      label: 'Chiama',
                                      onPressed: () {},
                                    ),
                                    Divider(),
                                    ContactItem(
                                      icon: FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: theme.primaryColorDark,
                                        size: _iconSize,
                                      ),
                                      label: 'Whatsapp',
                                      onPressed: () {},
                                    ),
                                    Divider(),
                                    ContactItem(
                                      icon: Icon(
                                        Icons.email_outlined,
                                        color: theme.primaryColorDark,
                                        size: _iconSize,
                                      ),
                                      label: 'E-mail',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('Contatta'),
                    ),
                  ],
                ),
              ]
            : [_TitleField(title), _ValueField(value)],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  final Widget icon;
  final String label;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Row(
          children: [
            icon,
            SizedBox(
              width: 15,
            ),
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark),
            ),
          ],
        ));
  }
}
