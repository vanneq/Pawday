import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/core/extension/cat_extension.dart';
import 'package:kotik/core/extension/day_with_cat_extension.dart';
import 'package:kotik/core/model/cat/cat_model.dart';
import 'package:kotik/core/widgets/snackbar.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kotik/features/auth/presentation/cubit/auth_state.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/features/main/presentation/cubit/cats_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthCubit>())],
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
              showSuccessSnackbar(context, state.error);
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
                if (state is CatsLoadedData && state.selectedCat != null)
                  Positioned.fill(
                    child: _AddedCatsList(selectedCat: state.selectedCat!),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AddedCatsList extends StatelessWidget {
  final CatModel selectedCat;
  const _AddedCatsList({required this.selectedCat});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = _MainStackMetrics.fromConstraints(constraints);

        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: metrics.catBottom,
              child: Image.asset(
                selectedCat.color.imagePath,
                height: metrics.catHeight,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: metrics.titleTop,
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
                  '${selectedCat.name} вас заждался!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: metrics.daysTop,
              child: Column(
                children: [
                  Text(
                    'Дней с котом:',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${selectedCat.daysWithCat}',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: metrics.buttonBottom,
              child: Center(
                child: _CreateDiaryEntryButton(
                  onTap: () {
                    context.go('/diary/add_entry', extra: selectedCat.id);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CreateDiaryEntryButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CreateDiaryEntryButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(34.r),
          color: colorScheme.primary,
          strokeWidth: 2,
          dashPattern: const [6, 5],
        ),
        child: Padding(
          padding: EdgeInsets.all(4.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28.r),
            child: Ink(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 18.w, 10.h),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withAlpha(75),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary.withAlpha(34),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.photo_camera,
                      size: 22.sp,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Новая запись',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotAddedCats extends StatelessWidget {
  const _NotAddedCats();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = _MainStackMetrics.fromConstraints(constraints);

        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: metrics.emptyCatBottom,
              child: Opacity(
                opacity: 0.55,
                child: Image.asset(
                  'assets/cats/empty_cat.png',
                  height: metrics.emptyCatHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 44,
              bottom: metrics.emptyAddButtonBottom,
              child: Center(
                child: DottedBorder(
                  options: CircularDottedBorderOptions(
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 1.5,
                    dashPattern: const [5, 4],
                  ),
                  child: Container(
                    width: metrics.emptyAddButtonSize,
                    height: metrics.emptyAddButtonSize,
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
                          size: metrics.emptyAddIconSize,
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
              top: metrics.titleTop,
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
      },
    );
  }
}

class _MainStackMetrics {
  final double titleTop;
  final double daysTop;
  final double catBottom;
  final double catHeight;
  final double buttonBottom;
  final double emptyCatBottom;
  final double emptyCatHeight;
  final double emptyAddButtonBottom;
  final double emptyAddButtonSize;
  final double emptyAddIconSize;

  const _MainStackMetrics({
    required this.titleTop,
    required this.daysTop,
    required this.catBottom,
    required this.catHeight,
    required this.buttonBottom,
    required this.emptyCatBottom,
    required this.emptyCatHeight,
    required this.emptyAddButtonBottom,
    required this.emptyAddButtonSize,
    required this.emptyAddIconSize,
  });

  factory _MainStackMetrics.fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;

    if (width < 360) {
      return _MainStackMetrics(
        titleTop: 72.h,
        daysTop: 132.h,
        catBottom: 200.h,
        catHeight: (height * 0.34).clamp(221.h, 281.h).toDouble(),
        buttonBottom: 146.h,
        emptyCatBottom: 104.h,
        emptyCatHeight: height * 0.42,
        emptyAddButtonBottom: 218.h,
        emptyAddButtonSize: 48.w,
        emptyAddIconSize: 30.sp,
      );
    }

    if (width < 380) {
      return _MainStackMetrics(
        titleTop: 82.h,
        daysTop: 146.h,
        catBottom: 202.h,
        catHeight: (height * 0.36).clamp(238.h, 298.h).toDouble(),
        buttonBottom: 130.h,
        emptyCatBottom: 112.h,
        emptyCatHeight: height * 0.44,
        emptyAddButtonBottom: 232.h,
        emptyAddButtonSize: 50.w,
        emptyAddIconSize: 32.sp,
      );
    }

    if (width < 420) {
      return _MainStackMetrics(
        titleTop: 100.h,
        daysTop: 170.h,
        catBottom: 180.h,
        catHeight: (height * 0.39).clamp(255.h, 323.h).toDouble(),
        buttonBottom: 98.h,
        emptyCatBottom: 126.h,
        emptyCatHeight: height * 0.47,
        emptyAddButtonBottom: 252.h,
        emptyAddButtonSize: 54.w,
        emptyAddIconSize: 34.sp,
      );
    }

    return _MainStackMetrics(
      titleTop: 106.h,
      daysTop: 176.h,
      catBottom: 182.h,
      catHeight: (height * 0.41).clamp(272.h, 332.h).toDouble(),
      buttonBottom: 102.h,
      emptyCatBottom: 132.h,
      emptyCatHeight: height * 0.48,
      emptyAddButtonBottom: 260.h,
      emptyAddButtonSize: 54.w,
      emptyAddIconSize: 34.sp,
    );
  }
}
