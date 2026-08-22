import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kotik/core/di/injection_container.dart';

final firebaseAuthProvider = StreamProvider<User?>((ref) {
  return getIt<FirebaseAuth>().authStateChanges();
});
