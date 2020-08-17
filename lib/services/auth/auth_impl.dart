import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/auth/auth.dart';
import 'package:snapsheetapp/services/database/database_impl.dart';
export 'auth.dart';

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Create User object from FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  /// Get the currently logged in user
  Future currentUser() async {
    return await _auth.currentUser().then(_userFromFirebaseUser);
  }

  /// Stream of user to let the app know when a user logs in / out
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // Adding initial data
      DatabaseServiceImpl _db = DatabaseServiceImpl(uid: user.uid);
      Map<String, dynamic> credentials = {
        'uid': user.uid,
        'email': email,
        'isDemo': true,
      };
      _db.addCredentials(credentials);
      await _db.initialize();

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser user = result.user;
      final FirebaseUser currentUser = await _auth.currentUser();

      AdditionalUserInfo additionalUserInfo = result.additionalUserInfo;
      if (additionalUserInfo.isNewUser) {
        DatabaseServiceImpl _db = DatabaseServiceImpl(uid: user.uid);
        Map<String, dynamic> profile = additionalUserInfo.profile;
        Map<String, dynamic> credentials = {
          'uid': currentUser.uid,
          'email': profile['email'],
          'name': profile['name'],
          'isDemo': true,
        };
        _db.addCredentials(credentials);
        await _db.initialize();
      }

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
