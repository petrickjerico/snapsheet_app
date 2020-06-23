abstract class AuthService {
  Future currentUser();
  Future signInAnon();
  Future signInWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future signInWithGoogle();
  Future signOut();
}
