import 'package:dio/dio.dart';
import 'package:flash/const/data.dart';
import 'package:flash/controller/dio/dio_singletone.dart';
import 'package:flash/model/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dios;

class CommentController extends GetxController {
  TextEditingController commentText = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var textEmpty = true.obs;
  var commentList = <CommentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    commentText.addListener(() {
      // 텍스트가 비어 있으면 true, 아니면 false
      textEmpty.value = commentText.text.isEmpty;
    });
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendComment(int solutionId) async {
    print('댓글 전송');
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    try {
      print(commentText.text);
      final response = await DioClient().dio.post(
        '/solutions/${solutionId}/comments',
        data: {"content": commentText.text},
      );

      if (response.statusCode == 201) {
        // 요청이 성공적으로 처리된 경우
        print('성공');
      } else {
        print('Failed to update comment: ${response.statusCode}');
        print('Failed to update comment: ${response.data}');
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
    }
  }

  Future<void> DeleteComment(int commentId) async {
    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      final response = await DioClient().dio.delete(
            "/comments/${commentId}",
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError: ${e.response?.headers}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }

  Future<void> modifyComment(int commentId) async {
    print('댓글 수정');
    final token = await storage.read(key: ACCESS_TOKEN_KEY);
    DioClient().updateOptions(token: token.toString());
    final response = await DioClient()
        .dio
        .patch('/commnt/${commentId}', data: {"content": '수정'});
    try {
      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리된 경우
        print('수정성공');
      } else {
        print('Failed to update comment: ${response.statusCode}');
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
    }
  }

  Future<void> newFetch(int solutionId) async {
    dios.Response response;

    try {
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      DioClient().updateOptions(token: token.toString());

      response = await DioClient().dio.get(
            "/solutions/${solutionId}/comments",
          );
      List<Map<String, dynamic>> resMapList =
          List<Map<String, dynamic>>.from(response.data["comments"]);

      List<CommentModel> cm =
          resMapList.map((e) => CommentModel.fromJson(e)).toList();
      commentList.assignAll(cm);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('마이페이지 첫 해설 데이터 로딩 실패DioError: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }
}
