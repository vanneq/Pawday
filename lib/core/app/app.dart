import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kotik/core/app/theme/app_theme.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/providers/auth_provider.dart';
import 'package:kotik/core/router/router.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routers = ref.watch(router);
    final currentUser = ref.watch(firebaseAuthProvider).value;

    return BlocProvider(
      key: ValueKey(currentUser?.uid),
      create: (_) {
        final cubit = getIt<CatsCubit>();
        if (currentUser != null) {
          cubit.watchCats();
        }
        return cubit;
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: routers,
        color: AppTheme.light.colorScheme.surface,
      ),
    );
  }
}
