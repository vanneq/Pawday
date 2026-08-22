import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        if (state is AuthUnauthenticated) context.go('/auth');
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(body: Text('data')),
    );
  }
}
