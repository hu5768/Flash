import 'dart:io';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart' as dios;
import '../../controller/dio_singletone.dart';

class AnswerUpload extends StatefulWidget {
  final String id, imageUrl;
  const AnswerUpload({
    super.key,
    required this.id,
    required this.imageUrl,
  });

  @override
  State<AnswerUpload> createState() => _AnswerUploadState();
}

class _AnswerUploadState extends State<AnswerUpload> {
  VideoPlayerController? videoController;
  File? _videoFile;
  String nickName = '', instaId = '', oneLinePyeong = '';
  final TextEditingController nicCon = TextEditingController();
  final TextEditingController inCon = TextEditingController();
  final TextEditingController oneCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 텍스트 필드의 값을 변수에 저장
    nicCon.addListener(() {
      setState(() {
        nickName = nicCon.text;
      });
    });
    inCon.addListener(() {
      setState(() {
        instaId = inCon.text;
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
        _videoFile = File(result.files.first.path!);
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
    if (_videoFile == null) return;
    try {
      //put에서 url 받아오기
      final presignedUrlResponse = await DioClient().dio.get(
            'https://1rpjfkrhnj.execute-api.ap-northeast-2.amazonaws.com/dev/solutions/presigned-url',
          );
      final presignedUrlData = presignedUrlResponse.data;
      final uploadUrl = presignedUrlData['body']['upload_url'];
      final fileName = presignedUrlData['body']['file_name'];
// s3에 put
      final uploadResponse = await DioClient().dio.put(
            uploadUrl,
            data: _videoFile!.openRead(),
            options: Options(
              headers: {
                'Content-Type': 'video.type',

                ///*
              },
            ),
          );
// put 성공하면
      if (uploadResponse.statusCode == 200) {
        print("업로드 성공?????????" + fileName);
      }
    } catch (e) {
      print('영상 업로드 오류$e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id}업로드"),
      ),
      body: Column(
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
                      child: Text('비디오 골라라'),
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
                  controller: nicCon,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '닉네임',
                    fillColor: Colors.white, // 배경색을 흰색으로 설정
                    filled: true, // 배경색을 적용하도록 설정
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
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
          ElevatedButton(
            onPressed: () {
              print(nickName + instaId + oneLinePyeong);
              _uploadVideo();
            },
            child: const Text('upload'),
          ),
        ],
      ),
    );
  }
}
