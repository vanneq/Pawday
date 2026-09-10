import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/core/model/diary/diary_model.dart';
import 'package:kotik/core/navigation/nav_bar.dart';
import 'package:kotik/core/providers/auth_provider.dart';
import 'package:kotik/features/auth/presentation/pages/login_page.dart';
import 'package:kotik/features/auth/presentation/pages/register_page.dart';
import 'package:kotik/features/dairy/presentation/pages/add_entry_page.dart';
import 'package:kotik/features/dairy/presentation/pages/diary_entry_details_page.dart';
import 'package:kotik/features/dairy/presentation/pages/diary_page.dart';
import 'package:kotik/features/dairy/presentation/pages/edit_entry_page.dart';
import 'package:kotik/features/main/presentation/pages/main_page.dart';
import 'package:kotik/features/profile/presentation/pages/add_cat_page.dart';
import 'package:kotik/features/profile/presentation/pages/edit_cat_page.dart';
import 'package:kotik/features/profile/presentation/pages/profile_page.dart';
import 'package:kotik/features/splash/presentation/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = Provider<GoRouter>((ref) {
  final authState = ref.watch(firebaseAuthProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',

    redirect: (context, state) {
      final location = state.uri.path;

      final isSplash = location == '/splash';
      final isAuthFlow = location == '/login' || location == '/register';

      if (authState.isLoading) {
        return isSplash ? null : '/splash';
      }

      final isLoggedIn = authState.value != null;

      if (isSplash) {
        return null;
      }

      if (!isLoggedIn) {
        if (isAuthFlow) return null;
        return '/login';
      }

      if (isLoggedIn) {
        if (isAuthFlow) {
          return '/main';
        }
      }

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
                const NoTransitionPage(child: DiaryPage()),
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
      GoRoute(
        path: '/diary/add_entry',
        pageBuilder: (context, state) {
          final catId = state.extra as String;
          return NoTransitionPage(child: AddEntryPage(catId: catId));
        },
      ),
      GoRoute(
        path: '/diary/entry',
        pageBuilder: (context, state) {
          final entry = state.extra as DiaryModel;
          return NoTransitionPage(child: DiaryEntryDetailsPage(entry: entry));
        },
      ),
      GoRoute(
        path: '/diary/edit_entry',
        pageBuilder: (context, state) {
          final entry = state.extra as DiaryModel;
          return NoTransitionPage(child: EditEntryPage(entry: entry));
        },
      ),
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) {
          return NoTransitionPage(child: SplashScreen());
        },
      ),
    ],
  );
});
