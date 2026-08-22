import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/providers/auth_provider.dart';
import 'package:kotik/features/auth/presentation/pages/login_page.dart';
import 'package:kotik/features/auth/presentation/pages/register_page.dart';
import 'package:kotik/features/main/presentation/pages/main_page.dart';

final router = Provider<GoRouter>((ref) {
  final authState = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/register',
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthFlow = ['/login', '/register'].contains(state.uri.toString());

      if (!isLoggedIn && !isAuthFlow) return '/login';
      if (isLoggedIn && isAuthFlow) return '/main';
      return null;
    },
    routes: [
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: RegisterPage()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/main',
        pageBuilder: (context, state) => NoTransitionPage(child: MainPage()),
      ),
    ],
  );
});
