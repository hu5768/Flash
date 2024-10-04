import 'package:dio/dio.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static String accessstoken = '';

  Future<void> googleSignIn() async {
    //구글 로그인
    try {
      //print('login');
      GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        //print('User Name: ${googleAccount.displayName}');
        //print('User Email: ${googleAccount.email}');
        //print('User ID: ${googleAccount.id}');
      }
      String idToken = '';
      if (googleAccount != null) {
        final GoogleSignInAuthentication auth =
            await googleAccount.authentication;
        idToken = auth.accessToken ?? '';
      }

      //print('로그인 성공: ${idToken}');
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
              "token": idToken,
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
        // print('Response data: ${response.data}');
        final token = response.data["accessToken"];
        final isCompleteRegistration = response.data["isCompleteRegistration"];

        DioClient().updateOptions(token: token);

        if (isCompleteRegistration) {
          print('로그인 성공');
        } else {
          print('허용되지 않은 계정임');
        }
      } else {
        // 요청 실패 시 처리
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
      //print(e);
    }
  }

  Future<bool> TokenLogin(String googletoken) async {
    bool loginS = false;
    try {
      print("로그인 시작");
      final response = await DioClient().dio.post(
            "/auth/login",
            data: {
              "token": googletoken,
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
        // print('Response data: ${response.data}');
        final token = response.data["accessToken"];
        final isCompleteRegistration = response.data["isCompleteRegistration"];

        DioClient().updateOptions(token: token);

        if (isCompleteRegistration) {
          LoginController.accessstoken = token;
          loginS = true;
        } else {
          print('허용되지 않은 계정임');
        }
      } else {
        // 요청 실패 시 처리
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError로그인 오류: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
      //print(e);
    }
    return loginS;
  }
}
