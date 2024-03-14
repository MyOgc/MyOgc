import 'package:go_router/go_router.dart';
import 'package:my_golf_app/models/user.dart';
import 'package:my_golf_app/pages/athlete_details_page.dart';
import 'package:my_golf_app/pages/athlete_edit_page.dart';
import 'package:my_golf_app/pages/commissioner_details_page.dart';
import 'package:my_golf_app/pages/commissioner_edit_page.dart';
import 'package:my_golf_app/pages/game_edit_page.dart';
import 'package:my_golf_app/pages/game_page.dart';
import 'package:my_golf_app/pages/home_page.dart';
import 'package:my_golf_app/pages/login_page.dart';
import 'package:my_golf_app/pages/profile_details_page.dart';
import 'package:my_golf_app/pages/profile_page.dart';
import 'package:my_golf_app/pages/round_detail_page.dart';
import 'package:my_golf_app/pages/round_edit_page.dart';
import 'package:my_golf_app/pages/session_edit_page.dart';
import 'package:my_golf_app/pages/summary_game_page.dart';
import 'package:my_golf_app/pages/sessions_detail_page.dart';
import 'package:my_golf_app/pages/trainer_details_page.dart';
import 'package:my_golf_app/pages/trainer_edit_page.dart';
import 'package:my_golf_app/pages/trainer_home_page.dart';
import 'package:my_golf_app/pages/training_detail_page.dart';
import 'package:my_golf_app/pages/training_edit_page.dart';
import 'package:my_golf_app/pages/users_list_page.dart';

// final routes = <String, Widget Function(BuildContext)>{
//   // SelectionScreen.routeName: (_) => SelectionScreen(),

//   '/': (_) => const LoginPage(),
//   HomePage.routeName: (_) => const HomePage(
//         title: 'MyOgc',
//       ),
// };

final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => HomePage(
        user: state.extra as User,
      ),
    ),
    GoRoute(
      path: ProfilePage.routeName,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: SessionsDetailPage.routeName,
      builder: (context, state) => const SessionsDetailPage(),
    ),
    GoRoute(
      path: '${TrainingDetailPage.routeName}/:trainingId',
      builder: (context, state) => TrainingDetailPage(
        trainingId: state.pathParameters['trainingId'] as String,
        isReadOnly: state.extra as bool,
      ),
    ),
    GoRoute(
      path: GameEditPage.routeName,
      builder: (context, state) => const GameEditPage(),
    ),
    GoRoute(
      path: '${GameEditPage.routeName}/:gameId',
      builder: (context, state) => GameEditPage(
        gameId: state.pathParameters['gameId'] as String,
        isEditMode: state.extra as bool,
      ),
    ),
    GoRoute(
      path: TrainingEditPage.routeName,
      builder: (context, state) => const TrainingEditPage(),
    ),
    GoRoute(
      path: '${TrainingEditPage.routeName}/:trainingId',
      builder: (context, state) => TrainingEditPage(
        trainingId: state.pathParameters['trainingId'] as String,
        isEditMode: state.extra as bool,
      ),
    ),
    GoRoute(
      path: SessionEditPage.routeName,
      builder: (context, state) => const SessionEditPage(),
    ),
     GoRoute(
      path: '${SessionEditPage.routeName}/:sessionId',
      builder: (context, state) => SessionEditPage(
        isEditMode: state.extra as bool,
        sessionId: state.pathParameters['sessionId'] as String,
      ),
    ),
    GoRoute(
      path: '${GamePage.routeName}/:gameId',
      builder: (context, state) => GamePage(
        gameId: state.pathParameters['gameId'] as String,
      ),
    ),
    GoRoute(
      path: '${SummaryGamePage.routeName}/:gameId',
      builder: (context, state) => SummaryGamePage(
        isReadOnly: state.extra as bool,
        gameId: state.pathParameters['gameId'] as String,
      ),
    ),
    GoRoute(
      path: '${RoundEditPage.routeName}/:gameId',
      builder: (context, state) => RoundEditPage(
        isEditMode: state.extra as bool,
        gameId: state.pathParameters['gameId'] as String,
      ),
    ),
    GoRoute(
      path: '${RoundEditPage.routeName}/:gameId/:roundId',
      builder: (context, state) => RoundEditPage(
        isEditMode: state.extra as bool,
        gameId: state.pathParameters['gameId'] as String,
        roundId: state.pathParameters['roundId'],
      ),
    ),
    GoRoute(
      path: '${RoundDetailPage.routeName}/:gameId/:roundId',
      builder: (context, state) => RoundDetailPage(
        index: state.extra as int,
        gameId: state.pathParameters['gameId'] as String,
        roundId: state.pathParameters['roundId'] as String,
      ),
    ),
    GoRoute(
      path: UsersListPage.routeName,
      builder: (context, state) => const UsersListPage(),
    ),
    GoRoute(
      path: AthleteEditPage.routeName,
      builder: (context, state) =>
          AthleteEditPage(isEditMode: state.extra as bool),
    ),
    GoRoute(
      path: TrainerEditPage.routeName,
      builder: (context, state) => TrainerEditPage(
        isEditMode: state.extra as bool,
      ),
    ),
    GoRoute(
      path: CommissionerEditPage.routeName,
      builder: (context, state) => CommissionerEditPage(
        isEditMode: state.extra as bool,
      ),
    ),
    GoRoute(
      path: AthleteDetailsPage.routeName,
      builder: (context, state) => const AthleteDetailsPage(),
    ),
    GoRoute(
      path: ProfileDetailsPage.routeName,
      builder: (context, state) => ProfileDetailsPage(
        user: state.extra as User,
      ),
    ),
    GoRoute(
      path: TrainerHomePage.routeName,
      builder: (context, state) => TrainerHomePage(
        user: state.extra as User,
      ),
    ),
    GoRoute(
      path: TrainerDetailsPage.routeName,
      builder: (context, state) => const TrainerDetailsPage(),
    ),
    GoRoute(
      path: CommissionerDetailsPage.routeName,
      builder: (context, state) => const CommissionerDetailsPage(),
    ),
  ],
);
