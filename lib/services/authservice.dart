import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // handleAuth() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.onAuthStateChanged,
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return LoginScreen();
  //         } else {
  //           return MobileVerificationScreen(fullName, passWord);
  //         }
  //       });
  // }
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCred) {
    FirebaseAuth.instance.signInWithCredential(authCred);
  }

  signInwithOtp(oTP, verId) {
    AuthCredential authCred =
        PhoneAuthProvider.getCredential(verificationId: verId, smsCode: oTP);
    signIn(authCred);
  }
}
