import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth firebaseAuth;

  AuthDataSource({required this.firebaseAuth});

  Future<UserCredential> register(String email, String password) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login(String email, String password) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() {
    return firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
