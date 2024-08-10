import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static String personalInformation =
      'https://sites.google.com/view/flash-climbing/%ED%99%88'; //개인정보처리방침

  static Future<void> initAccount() async {
    KakaoSdk.init(nativeAppKey: '36977b0203b8efbc768e68615a8c9b70');
  }

  static Future<void> googleSignIn() async {
    //구글 로그인
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

  static Future<void> appleLogin() async {
    //애플 로그인
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final idToken = credential.identityToken;
      print(credential);
      print(idToken);
      // 여기에서 서버로 credential을 보내 사용자 인증을 처리합니다.
    } catch (error) {
      print('Apple 로그인 실패: $error');
    }
  }

  static Future<void> kakaoLogin() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      // 로그인 성공 후 유저 정보 가져오기
      User user = await UserApi.instance.me();
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('로그인 성공: ${token}');
    } catch (error) {
      print('로그인 실패: $error');
    }
  }

  static Future<void> OpenPI() async {
    if (await canLaunchUrl(Uri.parse(personalInformation))) {
      await launchUrl(Uri.parse(personalInformation));
    } else {
      throw 'Could not launch $personalInformation';
    }
  }
}
