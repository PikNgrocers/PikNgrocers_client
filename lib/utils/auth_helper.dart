import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper {
  static signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result =  await FirebaseAuth.instance.signInWithCredential(credential);
    print('>>>>>>>>>>>>>>>>>>>>$result');
    return result.user;
  }
  static logout() {
    GoogleSignIn().signOut();
    return FirebaseAuth.instance.signOut();
  }
}

