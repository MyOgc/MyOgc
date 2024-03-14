import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/group.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/home_page.dart';
import 'package:my_golf_app/widget/logo_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _Logo(),
                      _gap(),
                      const _FormContent(),
                      const SizedBox(
                        height: 60,
                      ),
                      const LogoText(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }

  Widget _gap() => const SizedBox(height: 16);
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          scale: 2,
        ),
        // FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Benvenuto in  ",
                textAlign: TextAlign.center,
                style: isSmallScreen
                    ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)
                    : Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Theme.of(context).primaryColor),
              ),
              Text(
                'My',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Oooh Baby',
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              Text('Ogc',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Ribeye',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 100, bottom: 30),
          child: Text('Inserisci le credenziali per effettuare il Login!',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent();

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  // final bool _isLogin = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<User> users = [
    CommissionUser(
      id: 4531243123,
      name: 'Commissario',
      surname: 'Com',
      email: 'comm',
      serialNumber: 000,
      phoneNumber: '45423545243',
    ),
    AthleteUser(
      id: 5435423523523,
      name: 'Mirko',
      surname: 'Mattei',
      email: 'mirko.mattei@s3k.it',
      serialNumber: 111111,
      group: Group.gruppoUno,
      birthDate: DateTime.utc(1989, 6, 30),
      phoneNumber: '45423545243',
      trainer: ['3145145265525'],
    ),
    TrainerUser(
      id: 543134243,
      name: 'Maestro',
      surname: 'Mas',
      phoneNumber: '32323232323',
      email: 'maestro.maestro@email.it',
      serialNumber: 12345643,
      athleteIds: ['001', '002'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Inserisci la tua email';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Inserisci un\'email valida';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inserisci la tua password';
                }

                if (value.length < 6) {
                  return 'La password deve contenere almeno 6 caratteri';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Password dimenticata',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: Transform.translate(
                offset: const Offset(-10, 0),
                child: Text(
                  'Ricordami',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  // Navigator.restorablePushNamed(context, HomePage.routeName);
                  if (true) {
                    // if (_formKey.currentState?.validate() ?? false) {
                    context.go(HomePage.routeName, extra: users[0]);

                    /// do something
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
