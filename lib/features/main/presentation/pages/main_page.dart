import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_state.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<CatsCubit>()..watchCats()),
      ],
      child: const MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthUnauthenticated) context.go('/auth');
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
      ],
      child: BlocBuilder<CatsCubit, CatsState>(
        builder: (BuildContext context, CatsState state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset('assets/main_bg.png', fit: BoxFit.fill),
                ),
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(24.w, 100.h, 24.w, 0),
                            child: Column(
                              children: [
                                if (state is CatsLoading)
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                if (state is CatsError) Text(state.error),
                                if (state is CatsInitial)
                                  const SizedBox.shrink(),
                                if (state is CatsLoadedData &&
                                    state.cats.isNotEmpty)
                                  Text('Котов добавлено: ${state.cats.length}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state is CatsLoadedData && state.cats.isEmpty)
                  const Positioned.fill(child: _NotAddedCats()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NotAddedCats extends StatelessWidget {
  const _NotAddedCats();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 130,
          child: Opacity(
            opacity: 0.55,
            child: Image.asset('assets/cats/empty_cat.png'),
          ),
        ),
        Positioned(
          left: 10,
          right: 44,
          bottom: 254,
          child: Center(
            child: DottedBorder(
              options: CircularDottedBorderOptions(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 1.5,
                dashPattern: const [5, 4],
              ),
              child: Container(
                width: 54.w,
                height: 54.w,
                margin: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      context.go('/profile');
                    },
                    child: Icon(
                      CupertinoIcons.add,
                      size: 34.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 100,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1.5,
              ),
            ),
            child: Text(
              'Добавьте вашего \n питомца 🐾',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
