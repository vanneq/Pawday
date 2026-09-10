import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kotik/core/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openNextScreen();
  }

  Future<void> _openNextScreen() async {
    await Future.wait([
      Future<void>.delayed(const Duration(seconds: 4)),
      ref.read(firebaseAuthProvider.future),
    ]);

    if (!mounted) return;

    final user = ref.read(firebaseAuthProvider).value;
    context.go(user == null ? '/login' : '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/splash_screen.png', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
