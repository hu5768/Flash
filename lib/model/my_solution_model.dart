class MySolutionModel {
  int? id;
  String? uploader;
  String? review;
  String? instagramId;
  String? videoUrl;
  String? uploaderId;
  bool? isUploader;

  MySolutionModel({
    this.id,
    this.uploader,
    this.review,
    this.instagramId,
    this.videoUrl,
    this.uploaderId,
    this.isUploader,
  });

  MySolutionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploader = json['uploader'];
    review = json['review'];
    instagramId = json['instagramId'];
    videoUrl = json['videoUrl'];
    uploaderId = json['uploaderId'];
    isUploader = json['isUploader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uploader'] = uploader;
    data['review'] = review;
    data['instagramId'] = instagramId;
    data['videoUrl'] = videoUrl;
    data['uploaderId'] = uploaderId;
    data['isUploader'] = isUploader;
    return data;
  }
}
