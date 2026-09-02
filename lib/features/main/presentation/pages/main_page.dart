import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
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
      child: MainView(),
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
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: MediaQuery.of(context).size.height,
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
                                if (state is CatsLoadedData)
                                  if (state.cats.isEmpty)
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/cats/empty_cat.png',
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context.read<CatsCubit>().addCat(
                                              CreateCatParams(
                                                name: 'Лелик',
                                                createdAt: DateTime.now(),
                                                color: CatColoration.ginger,
                                                dayWithCat: 1,
                                                dairyEntries: 4,
                                              ),
                                            );
                                          },

                                          child: Text('Добавить кота'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<AuthCubit>()
                                                .logoutUseCase();
                                          },
                                          child: Text('Выйти'),
                                        ),
                                      ],
                                    )
                                  else
                                    Text(
                                      'Котов добавлено: ${state.cats.length}',
                                    ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
