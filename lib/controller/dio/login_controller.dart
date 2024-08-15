import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/view/login/user_onboarding_page.dart';
import 'package:flash/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dio_singletone.dart';

class LoginController {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
      /* scopes: [
      'email',
    ],*/
      );
  static String personalInformation =
      'https://sites.google.com/view/flash-climbing/%ED%99%88'; //개인정보처리방침

  static Future<void> initAccount() async {
    KakaoSdk.init(nativeAppKey: '36977b0203b8efbc768e68615a8c9b70');
  }

  static Future<void> googleSignIn(context) async {
    //구글 로그인
    try {
      print('login');
      GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        print('User Name: ${googleAccount.displayName}');
        print('User Email: ${googleAccount.email}');
        print('User ID: ${googleAccount.id}');
      }
      String idToken = '';
      if (googleAccount != null) {
        final GoogleSignInAuthentication auth =
            await googleAccount.authentication;
        idToken = auth.accessToken ?? '';
      }

      print('로그인 성공: ${idToken}');
      /*int i = 0;
      print("id token");
      while (i < idToken.length) {
        int j = i + 1000 < idToken.length ? i + 1000 : idToken.length;
        print(idToken.substring(i, j));
        i = j;
      }*/
      final response = await DioClient().dio.post(
            "/auth/login",
            data: {
              "token": "$idToken",
              "provider": "GOOGLE",
            },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
      if (response.statusCode == 200) {
        // 요청 성공 시 처리
        print('Request successful');
        print('Response data: ${response.data}');
        final token = response.data["accessToken"];
        final isCompleteRegistration = response.data["isCompleteRegistration"];
        storage.write(
          key: ACCESS_TOKEN_KEY,
          value: token,
        );
        DioClient().updateOptions(token: token);

        if (isCompleteRegistration) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false, // 스택에 있는 모든 이전 라우트를 제거
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserOnboardingPage()),
          );
        }
      } else {
        // 요청 실패 시 처리
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<void> appleLogin(context) async {
    //애플 로그인
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final idToken = credential.identityToken;
      final response = await DioClient().dio.post(
        "/auth/login",
        data: {
          "token": "$idToken",
          "provider": "APPLE",
        },
      );
      if (response.statusCode == 200) {
        // 요청 성공 시 처리
        print('Request successful');
        print('Response data: ${response.data}');
        final token = response.data["accessToken"];
        final isCompleteRegistration = response.data["isCompleteRegistration"];
        storage.write(
          key: ACCESS_TOKEN_KEY,
          value: token,
        );
        DioClient().updateOptions(token: token);

        if (isCompleteRegistration) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false, // 스택에 있는 모든 이전 라우트를 제거
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserOnboardingPage()),
          );
        }
      } else {
        // 요청 실패 시 처리
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Apple 로그인 실패: $error');
    }
  }

  static Future<void> kakaoLogin(context) async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      // 로그인 성공 후 유저 정보 가져오기
      User user = await UserApi.instance.me();
      OAuthToken idToken = await UserApi.instance.loginWithKakaoAccount();
      print('카카오 로그인 성공: ${idToken.accessToken}');
      final response = await DioClient().dio.post(
        "/auth/login",
        data: {
          "token": "${idToken.accessToken}",
          "provider": "KAKAO",
        },
      );
      if (response.statusCode == 200) {
        // 요청 성공 시 처리
        print('Request successful');
        print('Response data: ${response.data}');
        final token = response.data["accessToken"];
        final isCompleteRegistration = response.data["isCompleteRegistration"];
        storage.write(
          key: ACCESS_TOKEN_KEY,
          value: token,
        );
        DioClient().updateOptions(token: token);
        if (isCompleteRegistration) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false, // 스택에 있는 모든 이전 라우트를 제거
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserOnboardingPage()),
          );
        }
      } else {
        // 요청 실패 시 처리
        print('Request failed with status: ${response.statusCode}');
      }
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
