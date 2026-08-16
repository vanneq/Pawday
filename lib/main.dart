import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kotik/core/app/app.dart';
import 'package:kotik/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 844),
      builder: (context, child) {
        return MaterialApp(home: child);
      },
      child: const MyApp(),
    ),
  );
}
