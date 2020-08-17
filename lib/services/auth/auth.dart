import 'package:snapsheetapp/business_logic/models/user.dart';

abstract class AuthService {
  /// Stream of user to let the app know when a user logs in / out
  Stream<User> get user;

  /// Get the currently logged in user
  Future currentUser();

  /// Sign in and Sign up using email or Google
  Future signInWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future signInWithGoogle();

  Future signOut();
}
