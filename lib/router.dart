import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail/:name',
      builder: (context, state) {
        final name = state.pathParameters['name'] ?? '';
        return DetailScreen(pokemonName: name);
      },
    ),
  ],
);
