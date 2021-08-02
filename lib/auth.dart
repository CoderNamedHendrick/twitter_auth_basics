import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/twitter_login.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> get authStateChanges;
  Future<User> signInWithTwitter();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: "26UaFRMZvpHlwgcaFkY6wdFkG",
      apiSecretKey: "fkP3C2WfmMFBEFyuLGOOHRTDFw6sHQxn0Kz8olsyhWYmyxTXsB",
      redirectURI: "twitterauthbasics://",
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final userCredential = await _firebaseAuth.signInWithCredential(
          TwitterAuthProvider.credential(
              accessToken: authResult.authToken,
              secret: authResult.authTokenSecret),
        );
        return userCredential.user;
      case TwitterLoginStatus.cancelledByUser:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: authResult.errorMessage,
        );
        break;
      case TwitterLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_TWITTER_LOGIN_FAILED',
          message: authResult.errorMessage,
        );
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
