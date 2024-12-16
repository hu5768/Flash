class MySolutionModel {
  int? solutionId;
  String? gymName;
  String? sectorName;
  String? difficultyName;
  String? thumbnailImageUrl;
  int? commentsCount;
  String? solvedDate;
  String? uploadedAt;

  MySolutionModel({
    this.solutionId,
    this.gymName,
    this.sectorName,
    this.difficultyName,
    this.thumbnailImageUrl,
    this.commentsCount,
    this.solvedDate,
    this.uploadedAt,
  });

  MySolutionModel.fromJson(Map<String, dynamic> json) {
    solutionId = json['solutionId'];
    gymName = json['gymName'];
    sectorName = json['sectorName'];
    difficultyName = json['difficultyName'];
    thumbnailImageUrl = json['thumbnailImageUrl'];
    commentsCount = json['commentsCount'];
    solvedDate = json['solvedDate'];
    uploadedAt = json['uploadedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['solutionId'] = this.solutionId;
    data['gymName'] = this.gymName;
    data['sectorName'] = this.sectorName;
    data['difficultyName'] = this.difficultyName;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['commentsCount'] = this.commentsCount;
    data['solvedDate'] = this.solvedDate;
    data['uploadedAt'] = this.uploadedAt;
    return data;
  }
}
