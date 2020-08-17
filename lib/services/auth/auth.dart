import 'package:snapsheetapp/business_logic/models/user.dart';

abstract class AuthService {
  Stream<User> get user;
  Future currentUser();
  Future signInAnon();
  Future signInWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future signInWithGoogle();
  Future signOut();
}
