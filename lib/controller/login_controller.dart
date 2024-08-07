import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<void> googleSignIn() async {
    try {
      print('login');
      GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        print('Google Sign-In successful!');
        print('User Name: ${googleAccount.displayName}');
        print('User Email: ${googleAccount.email}');
        print('User ID: ${googleAccount.id}');
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<void> googleSignOut() async {
    GoogleSignInAccount? googleAccount = await _googleSignIn.disconnect();
    print('로그아웃 ${googleAccount!.email}');
  }
}
