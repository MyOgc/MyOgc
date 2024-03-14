import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_golf_app/providers/event.dart';
import 'package:my_golf_app/providers/game.dart';
import 'package:my_golf_app/providers/training.dart';
import 'package:my_golf_app/providers/user.dart';
import 'package:my_golf_app/providers/users.dart';
import 'package:my_golf_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => EventProvider()),
    ChangeNotifierProvider(create: (context) => GameProvider()),
    ChangeNotifierProvider(create: (context) => TrainingProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => UsersProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _themeData = ThemeData(
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 28),
      bodySmall: TextStyle(fontSize: 15),
      bodyMedium: TextStyle(fontSize: 20),
    ),
    primaryColor: const Color.fromARGB(255, 76, 136, 123),
    primaryColorLight: const Color.fromARGB(255, 238, 244, 243),
    // primaryColor: const Color.fromARGB(255, 47, 110, 55),
    primaryColorDark: const Color.fromARGB(255, 32, 89, 76),
    highlightColor: const Color.fromARGB(255, 27, 183, 136),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 76, 136, 123),
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 76, 136, 123)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('it'), // Spanish
      ],
      title: 'My Ogc',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      // home: const HomePage(title: 'Home Page'),
      // home: const LoginPage(),
      // initialRoute: '/',
      // routes: routes,

      routerConfig: router,
      // onGenerateRoute: ,
    );
  }
}
