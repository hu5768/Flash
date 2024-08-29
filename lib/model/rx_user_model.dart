import 'package:get/get.dart';

class RXUserModel {
  RxString nickName;
  RxString instagramId;
  RxDouble height;
  RxDouble reach;
  RxString profileImageUrl;
  RxString gender;

  RXUserModel({
    String? nickName,
    String? instagramId,
    double? height,
    double? reach,
    String? profileImageUrl,
    String? gender,
  })  : nickName = RxString(nickName ?? ''),
        instagramId = RxString(instagramId ?? ''),
        height = RxDouble(height ?? 1.0),
        reach = RxDouble(reach ?? 1.0),
        profileImageUrl = RxString(profileImageUrl ?? ''),
        gender = RxString(gender ?? '');
}
