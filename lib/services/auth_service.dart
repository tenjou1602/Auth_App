import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();


  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthEXception(e);
    }
  }

  String _handleAuthEXception(FirebaseAuthException e) {
      switch(e.code) {
        case 'user-not-found':
          return 'No user found with this email';
        case 'wrong-password':
          return 'Wrong password provided';
        case 'email-already-in-use':
          return 'An Account already exists with this email';
        case 'invalid-email':
          return 'The Email address is invalid';
        case 'weak-password':
          return ' The password is to weak';
        case 'Operation -not-allowed':
          return 'Operation not allowed. please contact chat-gpt';
        case 'user-disabled':
          return 'This user account has been disabled';
        default:
          return 'An error secured. Please Try Again.';
      }
  }

}