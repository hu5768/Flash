class UserModel {
  String? nickName;
  String? instagramId;
  double? height;
  double? reach;
  String? profileImageUrl;
  String? gender;

  UserModel({
    this.nickName,
    this.instagramId,
    this.height,
    this.reach,
    this.profileImageUrl,
    this.gender,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    instagramId = json['instagramId'];
    height = json['height'];
    reach = json['reach'];
    profileImageUrl = json['profileImageUrl'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickName'] = this.nickName;
    data['instagramId'] = this.instagramId;
    data['height'] = this.height;
    data['reach'] = this.reach;
    data['profileImageUrl'] = this.profileImageUrl;
    data['gender'] = this.gender;
    return data;
  }
}
