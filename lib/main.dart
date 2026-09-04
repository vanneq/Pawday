import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kotik/core/app/app.dart';
import 'package:kotik/core/di/injection_container.dart';
import 'package:kotik/features/main/presentation/cubit/cats_cubit.dart';
import 'package:kotik/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies(onUnathorized: () async {});

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 844),
      builder: (context, child) {
        return child!;
      },
      child: UncontrolledProviderScope(
        container: container,
        child: BlocProvider(
          create: (_) => getIt<CatsCubit>()..watchCats(),
          child: const MyApp(),
        ),
      ),
    ),
  );
}
