import 'package:flutter/material.dart';
import 'package:kotik/core/app/theme/app_theme.dart';
import 'package:kotik/features/auth/presentation/pages/register_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RegisterPage(),
      color: Theme.of(context).colorScheme.surface,
    );
  }
}
