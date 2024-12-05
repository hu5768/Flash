import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:video_player/video_player.dart';

class AdminUploadWeb extends StatefulWidget {
  final String id, imageUrl;
  final uploadBaseUrl = "https://upload.climbing-answer.com/";
  const AdminUploadWeb({
    super.key,
    required this.id,
    required this.imageUrl,
  });

  @override
  State<AdminUploadWeb> createState() => _AdminUploadWebState();
}

class _AdminUploadWebState extends State<AdminUploadWeb> {
  VideoPlayerController? videoController;
  Uint8List? videoFile;
  String nickName = 'Flash', instaId = 'insta', oneLinePyeong = '';
  final TextEditingController nicCon = TextEditingController();
  final TextEditingController inCon = TextEditingController();
  final TextEditingController oneCon = TextEditingController();
  Color uplod200 = Colors.grey;
  @override
  void initState() {
    super.initState();
    // 텍스트 필드의 값을 변수에 저장
    nicCon.text = 'Flash';
    inCon.text = '';
    oneCon.text = '@$instaId 님의 풀이입니다';
    nicCon.addListener(() {
      setState(() {
        nickName = nicCon.text;
      });
    });
    inCon.addListener(() {
      setState(() {
        instaId = inCon.text;
        oneCon.text = '@$instaId 님의 풀이입니다';
      });
    });
    oneCon.addListener(() {
      setState(() {
        oneLinePyeong = oneCon.text;
      });
    });
  }

  Future<void> _pickVideo() async {
    // 파일 선택 다이얼로그 열기
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      if (result != null) {
        videoFile = result.files.first.bytes;
        final file = result.files.single;
        final blob = html.Blob([file.bytes!]);
        final url = html.Url.createObjectUrlFromBlob(blob);

        setState(() {
          videoController = VideoPlayerController.network(url)
            ..initialize().then((_) {
              setState(() {});
              videoController!.play();
            });
        });
      }
    } catch (e) {
      print("비디오 왜 오류 $e");
    }
  }

  Future<void> _uploadVideo() async {
    if (videoFile == null) return;
    setState(() {
      uplod200 = const Color.fromARGB(255, 255, 140, 0);
    });
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);
      final apiResponse = await DioClient().dio.post(
            '${widget.uploadBaseUrl}admin/upload/',
            /*    data: {
          'problem_id': widget.id,
          'file': Stream.fromIterable(_videoBytes!.map((e) => [e])),
          'nickName': instaId,
          'review': oneLinePyeong,
          'instagram_id': instaId,
        },*/

            data: FormData.fromMap({
              'problemId': widget.id,
              'file': MultipartFile.fromBytes(
                videoFile!, // 바이트 배열을 직접 넘깁니다.
                filename: 'video.mp4', // 파일 이름을 지정합니다.
              ),
              'nickName': instaId,
              'review': oneLinePyeong,
              'instagramId': instaId,
            }),
            options: Options(
              headers: {
                'Content-Type': 'multipart/form-data',
              },
            ),
          );
      if (apiResponse.statusCode == 200) {
        setState(() {
          uplod200 = const Color.fromARGB(255, 0, 255, 8);
        });
      }
    } catch (e) {
      print('영상 업로드 오류$e');
      if (e is DioException) {
        if (e.response != null) {
          print('DioError업로드 오류: ${e.response?.statusCode}');
          print('Error Response Data: ${e.response?.data}');
        } else {
          print('Error: ${e.message}');
        }
      }
    }
  }

  late DropzoneViewController _controller;
  String _uploadedFileName = '';

  Future<void> _uploadFile(dynamic event) async {
    final name = await _controller.getFilename(event);
    final bytes = await _controller.getFileData(event);

    _uploadedFileName = name;
    videoFile = bytes;
    final videoUrl = html.Url.createObjectUrlFromBlob(html.Blob([bytes]));
    setState(() {
      videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          setState(() {});
          videoController!.play();
        });
    });

    print('File uploaded: $_uploadedFileName');
  }

  @override
  void dispose() {
    super.dispose();
    videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('web upload');
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id}업로드"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                videoController != null
                    ? SizedBox(
                        width: 200,
                        child: AspectRatio(
                          aspectRatio: videoController!.value.aspectRatio,
                          child: VideoPlayer(videoController!),
                        ),
                      )
                    : const SizedBox(
                        width: 200,
                        child: Text('오른쪽에 드래그앤 드랍해도됨'),
                      ),
                if (kIsWeb)
                  Container(
                    color: const Color.fromARGB(255, 185, 119, 114),
                    height: 200,
                    width: 200,
                    child: DropzoneView(
                      onCreated: (controller) => _controller = controller,
                      onDropFile: _uploadFile,
                      onError: (error) => print('Dropzone error: $error'),
                      operation: DragOperation.copy,
                      cursor: CursorType.grab,
                    ),
                  ),
                SizedBox(
                  child: Image.network(
                    widget.imageUrl,
                    width: 200,
                  ),
                ),
              ],
            ),
            ElevatedButton(onPressed: _pickVideo, child: const Text('video')),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: inCon,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '인스타 아이디',
                      fillColor: Colors.white, // 배경색을 흰색으로 설정
                      filled: true, // 배경색을 적용하도록 설정
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: oneCon,
              maxLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '한줄평',
                fillColor: Colors.white, // 배경색을 흰색으로 설정
                filled: true, // 배경색을 적용하도록 설정
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print(nickName + instaId + oneLinePyeong);
                    _uploadVideo();
                  },
                  child: const Text('upload'),
                ),
                Icon(
                  Icons.upload,
                  color: uplod200,
                  size: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
