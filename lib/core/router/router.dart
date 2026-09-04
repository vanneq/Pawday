import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/core/navigation/nav_bar.dart';
import 'package:kotik/core/providers/auth_provider.dart';
import 'package:kotik/features/auth/presentation/pages/login_page.dart';
import 'package:kotik/features/auth/presentation/pages/register_page.dart';
import 'package:kotik/features/dairy/presentation/pages/dairy_page.dart';
import 'package:kotik/features/main/presentation/pages/main_page.dart';
import 'package:kotik/features/profile/presentation/pages/add_cat_page.dart';
import 'package:kotik/features/profile/presentation/pages/edit_cat_page.dart';
import 'package:kotik/features/profile/presentation/pages/profile_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = Provider<GoRouter>((ref) {
  final authState = ref.watch(firebaseAuthProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => NavBar(child: child),
        routes: [
          GoRoute(
            path: '/main',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: MainPage()),
          ),
          GoRoute(
            path: '/diary',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DairyPage()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfilePage()),
          ),
        ],
      ),
      GoRoute(
        path: '/profile/add_cat',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AddCatPage()),
      ),
      GoRoute(
        path: '/profile/edit_cat',
        pageBuilder: (context, state) {
          final cat = state.extra as CatModel;
          return NoTransitionPage(child: EditCatPage(cat: cat));
        },
      ),
    ],
  );
});
