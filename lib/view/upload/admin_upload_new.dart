import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/const/base_url.dart';
import 'package:flash/const/fromat_date_string.dart';
import 'package:flash/controller/dio_singletone.dart';
import 'package:flash/controller/first_answer_controller.dart';
import 'package:flash/controller/login_controller.dart';
import 'package:flash/view/upload/grade_select_modal.dart';
import 'package:flash/view/upload/hold_select_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart' hide FormData hide MultipartFile;
import 'package:video_player/video_player.dart';

class AdminUploadNew extends StatefulWidget {
  final int gymId;
  const AdminUploadNew({
    super.key,
    required this.gymId,
  });

  @override
  State<AdminUploadNew> createState() => _AdminUploadWebState();
}

class _AdminUploadWebState extends State<AdminUploadNew> {
  //slider
  double currentSliderValue = 4;
  int totalFrames = 8;
  final firstAnswerController = Get.put(FirstAnswerController());
  VideoPlayerController? videoController;
  Uint8List? videoFile;
  String? videoPath;
  String? thumbnailDataUrl;
  String? thumbnailDataUrlUseUpload;
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
        videoPath = url;
        setState(() {
          videoController = VideoPlayerController.network(url)
            ..initialize().then((_) {
              setState(() {});
              final selectedTime = Duration(
                milliseconds:
                    (videoController!.value.duration.inMilliseconds / 2)
                        .round(),
              );
              videoController!.seekTo(selectedTime);
            });
        });
      }
    } catch (e) {
      print("비디오 왜 오류 $e");
    }
  }

  Future<void> uploadThumbnailToServer() async {
    try {
      // Base64 데이터에서 "data:image/jpeg;base64," 부분 제거
      final base64String = thumbnailDataUrl!.split(',')[1];

      final Uint8List imageData = base64.decode(base64String);

      DioClient().updateOptions(token: LoginController.accessstoken);
      // 서버에 POST 요청 보내기

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          imageData,
          filename: 'thumnail.jpeg',
        ),
      });
      final response = await DioClient().dio.post(
            '${uploadServerUrl}images/',
            data: formData,
            options: Options(
              headers: {
                "Content-Type": "multipart/form-data",
              },
            ),
          );

      thumbnailDataUrlUseUpload = response.data['profileImageUrl'];
      await _uploadVideo();
      if (response.statusCode == 200) {
        print("Thumbnail uploaded successfully: ${response.data}");
      } else {
        print("Failed to upload thumbnail: ${response.data}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode}');
        print('Error Response Data: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      print('오류 헤더${e.response?.headers}');
      print('오류 바디${e.response?.data}');
    } catch (e) {
      print("Error uploading thumbnail: $e");
    }
  }

  Future<void> selectThumbnailFile(int milliseconds) async {
    final html.VideoElement video = html.VideoElement()
      ..src = videoPath!
      ..autoplay = false
      ..controls = false;

    // CanvasElement 생성
    final html.CanvasElement canvas = html.CanvasElement();
    final html.CanvasRenderingContext2D context = canvas.context2D;

    // 비디오 메타데이터 로드 완료 이벤트
    video.onLoadedMetadata.listen((event) {
      // 캔버스 크기를 비디오 크기로 설정
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;

      // 특정 시간으로 이동
      video.currentTime = milliseconds / 1000; // 밀리초를 초로 변환

      // 해당 시점의 프레임을 캡처
      video.onTimeUpdate.listen((_) {
        context.drawImage(video, 0, 0);

        // 캡처된 이미지를 Base64 URL로 가져오기
        final imageData = canvas.toDataUrl('image/jpeg');

        // 화면에 표시를 위해 상태 업데이트
        setState(() {
          thumbnailDataUrl = imageData;
        });
        uploadThumbnailToServer();
        // 메모리 정리
        html.Url.revokeObjectUrl(videoPath!);
      });
    });
  }

  Future<void> _uploadVideo() async {
    if (videoFile == null) return;
    setState(() {
      uplod200 = const Color.fromARGB(255, 255, 140, 0);
    });
    try {
      DioClient().updateOptions(token: LoginController.accessstoken);
      print(thumbnailDataUrlUseUpload);
      final apiResponse = await DioClient().dio.post(
            '${uploadServerUrl}admin/upload/new/',
            /*    data: {
          'problem_id': widget.id,
          'file': Stream.fromIterable(_videoBytes!.map((e) => [e])),
          'nickName': instaId,
          'review': oneLinePyeong,
          'instagram_id': instaId,
        },*/

            data: FormData.fromMap({
              'gymId': widget.gymId,
              'sectorId': firstAnswerController.selectSectorId,
              'holdId': firstAnswerController.selectHoldId,
              'difficulty': firstAnswerController.selectGrade.value,
              'file': MultipartFile.fromBytes(
                videoFile!, // 바이트 배열을 직접 넘깁니다.
                filename: 'video.mp4', // 파일 이름을 지정합니다.
              ),
              'nickName': instaId,
              'review': oneLinePyeong,
              'instagramId': instaId,
              'solvedDate': formatDateDate(DateTime.now()),
              'thumbnailImageUrl': thumbnailDataUrlUseUpload,
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
        title: const Text("new 업로드"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
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
                            child: Text('영상을 선택하시오'),
                          ),
                    Slider(
                      min: 0,
                      max: (totalFrames - 1).toDouble(),
                      value: currentSliderValue,
                      divisions: (totalFrames - 1) * 6, //일단 24개
                      onChanged: (value) {
                        setState(() {
                          currentSliderValue = value;
                        });
                        final selectedTime = Duration(
                          milliseconds:
                              (videoController!.value.duration.inMilliseconds /
                                      totalFrames *
                                      value)
                                  .round(),
                        );
                        videoController!.seekTo(selectedTime);
                      },
                    ),
                  ],
                ),
                if (thumbnailDataUrl != null)
                  SizedBox(
                    height: 200,
                    width: 100,
                    child: Image.network(thumbnailDataUrl!),
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
                Column(
                  children: [
                    HoldSelectModal(),
                    const SizedBox(height: 12),
                    GradeSelectModal(),
                  ],
                ),
              ],
            ),
            ElevatedButton(onPressed: _pickVideo, child: const Text('video')),
            SectorFilter(),
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
                  onPressed: () async {
                    if (videoController == null) return;
                    await selectThumbnailFile(
                      videoController!.value.position.inMilliseconds,
                    );
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

class SectorFilter extends StatelessWidget {
  SectorFilter({
    super.key,
  });

  var firstAnswerController = Get.put(FirstAnswerController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: firstAnswerController.sectorOption.length,
        itemBuilder: (context, index) {
          return Obx(
            () {
              final option = firstAnswerController.sectorOption[index];
              final isSelected =
                  option == firstAnswerController.selectSector.value;
              return Container(
                height: 30,
                padding: const EdgeInsets.only(right: 12),
                child: ChoiceChip(
                  selected: isSelected,
                  visualDensity: const VisualDensity(vertical: 0.0),
                  showCheckmark: false,
                  label: Align(
                    alignment: const Alignment(0, -1.2),
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? const Color.fromARGB(
                                255,
                                0,
                                128,
                                255,
                              )
                            : const Color.fromARGB(255, 17, 17, 17),
                        height: 0,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: const Color.fromARGB(255, 217, 230, 255),
                  side: BorderSide(
                    color: isSelected
                        ? const Color.fromARGB(
                            255,
                            0,
                            128,
                            255,
                          )
                        : const Color.fromARGB(255, 196, 196, 196),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  onSelected: (bool selected) {
                    firstAnswerController.SectorSelection(
                      option,
                      index,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
